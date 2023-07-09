<!DOCTYPE html>
<html>
<head>
    <style>
        #drawing-board {
            position: relative;
            width: 400px;
            height: 400px;
            border: 1px solid black;
        }
        #drawing-board canvas {
            position: absolute;
            top: 0;
            left: 0;
        }
        #drawing-board img {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            cursor: move;
        }
        .rotate-button {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 5px;
            border-radius: 50%;
            cursor: pointer;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .delete-button {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(255, 0, 0, 0.7);
            color: white;
            padding: 5px;
            border-radius: 50%;
            cursor: pointer;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        #drawing-board:hover .rotate-button,
        #drawing-board:hover .delete-button {
            opacity: 1;
        }
    </style>
</head>
<body>
<div id="drawing-board">
    <canvas id="canvas"></canvas>
</div>

<div id="image-list">
    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/UserPhoto.jpg" alt="Image 1" class="draggable-image">
    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/UserPhoto+(1).jpg" alt="Image 2" class="draggable-image">
</div>

<script>
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    const imageList = document.getElementById('image-list');
    const draggableImages = document.querySelectorAll('.draggable-image');

    let isDragging = false;
    let dragStartX, dragStartY;
    let selectedImage = null;
    let imageX = 0, imageY = 0;
    let rotationAngle = 0;

    canvas.width = 400;
    canvas.height = 400;

    imageList.addEventListener('mousedown', handleImageClick);
    canvas.addEventListener('mousedown', handleCanvasMouseDown);
    canvas.addEventListener('mousemove', handleCanvasMouseMove);
    canvas.addEventListener('mouseup', handleCanvasMouseUp);

    function handleImageClick(event) {
        if (event.target.classList.contains('draggable-image')) {
            const image = event.target;
            const newImage = new Image();
            newImage.src = image.src;

            newImage.onload = function() {
                const centerX = (canvas.width - newImage.width) / 2;
                const centerY = (canvas.height - newImage.height) / 2;
                imageX = centerX;
                imageY = centerY;

                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.save();
                ctx.translate(centerX, centerY);
                ctx.rotate((rotationAngle * Math.PI) / 180);
                ctx.drawImage(newImage, -newImage.width / 2, -newImage.height / 2);
                ctx.restore();

                selectedImage = newImage;

                // 이미지를 canvas에 추가하는 부분
                selectedImage.style.position = 'absolute';
                selectedImage.style.left = `${centerX}px`;
                selectedImage.style.top = `${centerY}px`;
                selectedImage.style.transformOrigin = 'center center';
                selectedImage.style.pointerEvents = 'none';
                selectedImage.classList.add('draggable');
                document.getElementById('drawing-board').appendChild(selectedImage);

                const rotateButton = document.createElement('div');
                rotateButton.classList.add('rotate-button');
                rotateButton.textContent = '↻';
                rotateButton.addEventListener('mousedown', handleRotateButtonMouseDown);
                document.getElementById('drawing-board').appendChild(rotateButton);

                const deleteButton = document.createElement('div');
                deleteButton.classList.add('delete-button');
                deleteButton.textContent = 'X';
                deleteButton.addEventListener('mousedown', handleDeleteButtonMouseDown);
                document.getElementById('drawing-board').appendChild(deleteButton);

                //selectedImage = newImage;

                rotateButton.style.left = `${imageX - rotateButton.offsetWidth / 2}px`;
                rotateButton.style.top = `${imageY - rotateButton.offsetHeight / 2}px`;

                deleteButton.style.right = `${canvas.offsetWidth - (imageX + selectedImage.width) - deleteButton.offsetWidth / 2}px`;
                deleteButton.style.top = `${imageY - deleteButton.offsetHeight / 2}px`;
            };
        }
    }

    function handleCanvasMouseDown(event) {
        if (event.target === canvas && selectedImage) {
            isDragging = true;
            dragStartX = event.clientX - canvas.offsetLeft;
            dragStartY = event.clientY - canvas.offsetTop;

            // 이미지를 선택한 상태에서 마우스를 클릭하면 selectedImage를 canvas의 자식 요소로 이동합니다.
            canvas.appendChild(selectedImage);

        }
    }

    function handleCanvasMouseMove(event) {
        if (isDragging && selectedImage) {
            const dragOffsetX = event.clientX - canvas.offsetLeft - dragStartX;
            const dragOffsetY = event.clientY - canvas.offsetTop - dragStartY;

            imageX += dragOffsetX;
            imageY += dragOffsetY;

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.save();
            ctx.translate(imageX + selectedImage.width / 2, imageY + selectedImage.height / 2);
            ctx.rotate((rotationAngle * Math.PI) / 180);
            ctx.drawImage(selectedImage, -selectedImage.width / 2, -selectedImage.height / 2);
            ctx.restore();

            dragStartX = event.clientX - canvas.offsetLeft;
            dragStartY = event.clientY - canvas.offsetTop;

            const rotateButton = document.querySelector('.rotate-button');
            rotateButton.style.left = `${imageX - rotateButton.offsetWidth / 2}px`;
            rotateButton.style.top = `${imageY - rotateButton.offsetHeight / 2}px`;

            const deleteButton = document.querySelector('.delete-button');
            deleteButton.style.right = `${canvas.offsetWidth - (imageX + selectedImage.width) - deleteButton.offsetWidth / 2}px`;
            deleteButton.style.top = `${imageY - deleteButton.offsetHeight / 2}px`;
        }
    }

    function handleCanvasMouseUp() {
        isDragging = false;
    }

    let rotateStartX, rotateStartY;
    let rotationStartAngle;
    let isRotating = false;
    function handleRotateButtonMouseDown(event) {
        rotateStartX = event.clientX;
        rotateStartY = event.clientY;
        rotationStartAngle = rotationAngle;

        isRotating = true;

        document.addEventListener('mousemove', handleRotateButtonMouseMove);
        document.addEventListener('mouseup', handleRotateButtonMouseUp);
    }

    function handleRotateButtonMouseMove(event) {
        if (isRotating) {
            const rotateOffsetX = event.clientX - rotateStartX;
            const rotateOffsetY = event.clientY - rotateStartY;

            const angle = Math.atan2(rotateOffsetY, rotateOffsetX);
            const newRotationAngle = rotationStartAngle + (angle * 180) / Math.PI;

            rotationAngle = newRotationAngle;

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.save();
            ctx.translate(imageX + selectedImage.width / 2, imageY + selectedImage.height / 2);
            ctx.rotate((rotationAngle * Math.PI) / 180);
            ctx.drawImage(selectedImage, -selectedImage.width / 2, -selectedImage.height / 2);
            ctx.restore();
        }
    }

    function handleRotateButtonMouseUp() {
      isRotating = false;

      document.removeEventListener('mousemove', handleRotateButtonMouseMove);
      document.removeEventListener('mouseup', handleRotateButtonMouseUp);
    }

    function handleDeleteButtonMouseDown() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      const rotateButton = document.querySelector('.rotate-button');
      rotateButton.remove();

      const deleteButton = document.querySelector('.delete-button');
      deleteButton.remove();

      selectedImage = null;
    }
  </script>
</body>
</html>
