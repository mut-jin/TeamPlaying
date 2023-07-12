<!DOCTYPE html>
<html>
<head>
    <style>
        #drawing-board {
            position: relative;
            width: 400px;
            height: 400px;
            border: 1px solid black;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #drawing-board canvas {
            position: absolute;
            top: 0;
            left: 0;
        }
        #drawing-board img {
            position: absolute;
            top: 0;
            left: 0;
            transform: translate(-50%, -50%);
            cursor: move;
        }
        .rotate-button {
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
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
            top: -20px;
            right: 50%;
            transform: translateX(-50%);
            background-color: rgba(255, 0, 0, 0.7);
            color: white;
            padding: 5px;
            border-radius: 50%;
            cursor: pointer;
            opacity: 0;
            transition: opacity 0.3s ease;
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
    let selectedImageContainer = null;
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
                const container = document.createElement('div');
                container.classList.add('image-container');
                document.getElementById('drawing-board').appendChild(container); // 수정된 부분

                const rotateButton = document.createElement('div');
                rotateButton.classList.add('rotate-button');
                rotateButton.textContent = '↻';
                container.appendChild(rotateButton);

                const deleteButton = document.createElement('div');
                deleteButton.classList.add('delete-button');
                deleteButton.textContent = 'X';
                container.appendChild(deleteButton);

                selectedImage = newImage;
                selectedImageContainer = container;

                // 이미지가 캔버스 중앙에 위치하도록 수정된 부분
                container.style.left = `${canvas.width / 2 - selectedImage.width / 2}px`;
                container.style.top = `${canvas.height / 2 - selectedImage.height / 2}px`;

                rotateButton.style.opacity = '1';
                deleteButton.style.opacity = '1';
            };
        }
    }

    function handleCanvasMouseDown(event) {
        if (event.target === canvas) {
            const container = event.target.closest('.image-container');
            if (container) {
                selectedImageContainer = container;
                selectedImage = container.querySelector('img');
                isDragging = true;
                dragStartX = event.clientX - container.offsetLeft;
                dragStartY = event.clientY - container.offsetTop;
            }
        }
    }

    function handleCanvasMouseMove(event) {
        if (isDragging && selectedImage && selectedImageContainer) {
            const dragOffsetX = event.clientX - selectedImageContainer.offsetLeft - dragStartX;
            const dragOffsetY = event.clientY - selectedImageContainer.offsetTop - dragStartY;

            imageX += dragOffsetX;
            imageY += dragOffsetY;

            selectedImageContainer.style.transform = `translate(${imageX}px, ${imageY}px)`;

            dragStartX = event.clientX - selectedImageContainer.offsetLeft;
            dragStartY = event.clientY - selectedImageContainer.offsetTop;
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

            selectedImage.style.transform = `translate(-50%, -50%) rotate(${rotationAngle}deg)`;
        }
    }

    function handleRotateButtonMouseUp() {
        isRotating = false;

        document.removeEventListener('mousemove', handleRotateButtonMouseMove);
        document.removeEventListener('mouseup', handleRotateButtonMouseUp);
    }

    function handleDeleteButtonMouseDown() {
        selectedImageContainer.remove();
        selectedImage = null;
        selectedImageContainer = null;
    }
</script>
</body>
</html>
