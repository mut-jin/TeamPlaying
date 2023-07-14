<%--
  Created by IntelliJ IDEA.
  User: dkssu
  Date: 2023-07-10
  Time: 오후 2:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Title</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
    #toolbar {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: yellow;
        width: 100%;
        position: absolute;
        transform: translate(-50%, -50%);
        left: 50%;
        margin-top: 20px;
        border-radius: 10px;
        border: 2px solid #000;
    }



    /*    .tool {
            display: flex;
            justify-content: center;
            align-items: center;
        }*/

    #toolbar input {
        width: 10%;
    }

    #image-list {
        text-align: center;
    }
    .canvas-container {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
    }
</style>
<body>
<my:navBar></my:navBar>
    <div class="row justify-content-center">
        <div class="d-flex mb-3 row">
            <div class="col-2 left-div d-flex flex-column align-items-center" style="display: flex; flex-direction: column; align-items: center; margin-top: 200px;">
                <div style="margin-bottom: 200px;">
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce-out2.webp" alt="..." style="width: 200px; height: auto">
                </div>
                <div>
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce-out2.webp" alt="..." style="width: 200px; height: auto">
                </div>
            </div>
            <div class="col-8 d-flex justify-content-center" style="margin-top: 200px;">
                <div class="canvas-container" id="canvas-container">
                    <canvas id="drawing-board" style="border-radius: 10px; border: 2px solid #000;"></canvas>
                </div>
            </div>
            <div class="col-2 right-div d-flex flex-column align-items-center" style="display: flex; flex-direction: column; align-items: center; margin-top: 200px;">
                <div style="margin-bottom: 200px;">
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce-out2.webp" alt="..." style="width: 200px; height: auto">
                </div>
                <div>
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce-out2.webp" alt="..." style="width: 200px; height: auto">
                </div>
            </div>
        </div>
        <div id="tool">
            <div class="mb-3">
                <div id="toolbar">
                    <label for="stroke">Stroke</label>
                    <input id="stroke" name='stroke' type="color">
                    <label for="lineWidth">Line Width</label>
                    <input id="lineWidth" name='lineWidth' type="number" value="5">
                    <button id="clear">Clear</button>
                    <button id="save">Save</button>
                </div>
            </div>
            <div class="mb-3">
                <div id="image-list">
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/UserPhoto.jpg" alt="Image 1" class="draggable-image">
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/UserPhoto+(1).jpg" alt="Image 2" class="draggable-image">
                </div>
            </div>
        </div>
    </div>

<%--<script src="canvas1.js"></script>--%>
<%--<div>
    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce-out.webp">
</div>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>




<script>
    const canvas = document.getElementById('drawing-board');
    const toolbar = document.getElementById('toolbar');
    const ctx = canvas.getContext('2d');

    const canvasContainer = document.querySelector('.canvas-container');

    canvas.width = canvasContainer.offsetWidth;
    canvas.height = canvasContainer.offsetHeight;

    const leftDivImages = document.querySelectorAll('.left-div img');
    const rightDivImages = document.querySelectorAll('.right-div img');

    const shoeImage = [];
    // left-div의 이미지를 클릭했을 때

    leftDivImages.forEach((image) => {
        image.addEventListener('click', () => {
            const newImage = new Image();
            newImage.onload = () => {
                const canvasCenterX = canvas.width / 2 - newImage.width / 2;
                const canvasCenterY = canvas.height / 2 - newImage.height / 2;
                ctx.drawImage(newImage, canvasCenterX, canvasCenterY);
                shoeImage.push({
                    image: newImage,
                    offsetX: canvasCenterX,
                    offsetY: canvasCenterY,
                    loaded: true
                });
                drawCanvas();
            };
            newImage.src = image.src;
        });
    });

    rightDivImages.forEach((image) => {
        image.addEventListener('click', () => {
            const newImage = new Image();
            newImage.onload = () => {
                const canvasCenterX = canvas.width / 2 - newImage.width / 2;
                const canvasCenterY = canvas.height / 2 - newImage.height / 2;
                ctx.drawImage(newImage, canvasCenterX, canvasCenterY);
                shoeImage.push({
                    image: newImage,
                    offsetX: canvasCenterX,
                    offsetY: canvasCenterY,
                    loaded: true
                });
                drawCanvas();
            };
            newImage.src = image.src;
        });
    });

    function sortImagesByLayer() {
        images.sort((a, b) => {
            if (a.layer === 'front' && b.layer !== 'front') {
                return -1; // a를 앞에 배치
            } else if (a.layer !== 'front' && b.layer === 'front') {
                return 1; // b를 앞에 배치
            } else {
                return 0; // 순서 유지
            }
        });
    }

    function drawCanvas() {
        clearCanvas();
        drawShoeImage();
        drawImages();
        drawPainting();
    }

    function centerImage(image) {
        const canvasCenterX = canvas.width / 2;
        const canvasCenterY = canvas.height / 2;
        const imageCenterX = image.offsetX + image.image.width / 2;
        const imageCenterY = image.offsetY + image.image.height / 2;
        const newOffsetX = canvasCenterX - imageCenterX;
        const newOffsetY = canvasCenterY - imageCenterY;
        image.offsetX += newOffsetX;
        image.offsetY += newOffsetY;
    }

    function adjustImageSize(image) {
        const canvasRatio = canvas.width / canvas.height;
        const imageRatio = image.originalWidth / image.originalHeight;

        if (imageRatio > canvasRatio) {
            // 이미지의 가로 비율이 더 큰 경우
            const newWidth = canvas.width * 0.4;
            const newHeight = newWidth / imageRatio;
            image.image.width = newWidth;
            image.image.height = newHeight;
        } else {
            // 이미지의 세로 비율이 더 큰 경우
            const newHeight = canvas.height * 0.4;
            const newWidth = newHeight * imageRatio;
            image.image.width = newWidth;
            image.image.height = newHeight;
        }
    }

    function drawShoeImage() {
        for (const image of shoeImage) {
            if (image.loaded) {
                ctx.drawImage(image.image, image.offsetX, image.offsetY, image.image.width, image.image.height);
                drawDeleteButton(image.buttonOffsetX, image.buttonOffsetY);
            }
        }
    }

    function drawImages() {
        for (const image of images) {
            if (image.loaded) {
                ctx.drawImage(image.image, image.offsetX, image.offsetY, image.image.width, image.image.height);
                drawDeleteButton(image.buttonOffsetX, image.buttonOffsetY);
            }
        }
    }

    let isPainting = false;
    let lineWidth = 5;
    let images = [];
    let paintingPoints = [];

    let currentPath; // 현재 그리기 경로

    const saveButton = document.getElementById('save');
    saveButton.addEventListener('click', () => {
        const image = canvas.toDataURL('image/png'); // 캔버스 이미지를 Data URL 형식으로 가져옵니다.
        const link = document.createElement('a');
        console.log(link);
        link.href = image;
        link.download = 'canvas_image.png'; // 다운로드할 이미지 파일의 이름을 설정합니다.
        link.click(); // 링크를 클릭하여 이미지를 다운로드합니다.
    });


    function clearCanvas() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }

    toolbar.addEventListener('click', (event) => {
        if (event.target.id === 'clear') {
            clearCanvas();
            paintingPoints = [];
            images = images.filter((image) => image.loaded); // 로드된 이미지만 남깁니다.
            drawCanvas();
        }
    });

    toolbar.addEventListener('change', (event) => {
        if (event.target.id === 'stroke') {
            ctx.strokeStyle = event.target.value;
        }

        if (event.target.id === 'stroke') {
            // 그리기 경로마다 독립적인 스타일 적용
            ctx.strokeStyle = event.target.value;
            for (const points of paintingPoints) {
                ctx.beginPath();
                if (points.length > 0) {
                    ctx.moveTo(points[0].x, points[0].y);
                    for (let i = 1; i < points.length; i++) {
                        ctx.lineTo(points[i].x, points[i].y);
                    }
                    ctx.stroke();
                }
            }
        }

        if (event.target.id === 'lineWidth') {
            lineWidth = event.target.value;
        }
    });

    const imageList = document.getElementById('image-list');
    imageList.addEventListener('click', (event) => {
        const clickedImage = event.target;
        if (clickedImage.tagName === 'IMG') {
            const newImage = {
                image: new Image(),
                offsetX: 0,
                offsetY: 0,
                buttonOffsetX: 0,
                buttonOffsetY: 0,
                loaded: false,
                layer: 'front'
            };
            newImage.image.onload = () => {
                newImage.loaded = true;
                newImage.offsetX = canvas.width / 2 - newImage.image.width / 2;
                newImage.offsetY = canvas.height / 2 - newImage.image.height / 2;
                newImage.buttonOffsetX = newImage.offsetX + newImage.image.width - 10;
                newImage.buttonOffsetY = newImage.offsetY - 10;
                drawCanvas();
            };
            newImage.image.src = clickedImage.src;
            images.push(newImage);
        }
    });

    let isDragging = false;
    let dragImageIndex = -1;
    let dragStartX = 0;
    let dragStartY = 0;

    canvas.addEventListener('mousedown', (event) => {
        const canvasRect = canvas.getBoundingClientRect();
        const clickedX = event.clientX - canvasRect.left;
        const clickedY = event.clientY - canvasRect.top;

        dragImageIndex = findClickedImage(clickedX, clickedY);
        if (dragImageIndex !== -1) {
            isDragging = true;
            dragStartX = clickedX - images[dragImageIndex].offsetX;
            dragStartY = clickedY - images[dragImageIndex].offsetY;
        } else {
            isPainting = true;
            paintingPoints.push([]);
        }

        if (!isDragging) {
            // 새로운 그리기 경로 생성
            currentPath = [];
            paintingPoints.push(currentPath);
        }
    });

    canvas.addEventListener('mouseup', () => {
        isPainting = false;
        isDragging = false;
    });

    canvas.addEventListener('mousemove', (event) => {
        const canvasRect = canvas.getBoundingClientRect();
        const currentX = event.clientX - canvasRect.left;
        const currentY = event.clientY - canvasRect.top;

        if (!isPainting && !isDragging) {
            return;
        }

        if (isDragging) {
            images[dragImageIndex].offsetX = currentX - dragStartX;
            images[dragImageIndex].offsetY = currentY - dragStartY;
            images[dragImageIndex].buttonOffsetX = images[dragImageIndex].offsetX + images[dragImageIndex].image.width - 10;
            images[dragImageIndex].buttonOffsetY = images[dragImageIndex].offsetY - 10;
            drawCanvas();
        } else {
            if (isPainting) {
                //paintingPoints[paintingPoints.length - 1].push({ x: currentX, y: currentY });
                currentPath.push({ x: currentX, y: currentY });
                drawCanvas();
            }
        }
    });

    function drawImages() {
        for (const image of images) {
            if (image.loaded) {
                ctx.drawImage(image.image, image.offsetX, image.offsetY, image.image.width, image.image.height);
                drawDeleteButton(image.buttonOffsetX, image.buttonOffsetY);
            }
        }
    }

    function drawPainting() {
        ctx.lineWidth = lineWidth;
        ctx.lineCap = 'round';

        for (let i = 0; i < paintingPoints.length; i++) {
            const points = paintingPoints[i];

            ctx.beginPath();
            if (points.length > 0) {
                ctx.moveTo(points[0].x, points[0].y);

                for (let j = 1; j < points.length; j++) {
                    ctx.lineTo(points[j].x, points[j].y);
                }

                ctx.stroke();
            }
        }

        // for (const points of paintingPoints) {
        //     ctx.beginPath();
        //     if (points.length > 0) {
        //         ctx.moveTo(points[0].x, points[0].y);
        //
        //         for (let i = 1; i < points.length; i++) {
        //             ctx.lineTo(points[i].x, points[i].y);
        //         }
        //
        //         ctx.stroke();
        //     }
        // }
    }

    function drawDeleteButton(x, y) {
        const buttonSize = 20;
        ctx.fillStyle = '#ff0000';
        ctx.fillRect(x, y, buttonSize, buttonSize);
    }

    function findClickedImage(x, y) {
        for (let i = images.length - 1; i >= 0; i--) {
            const image = images[i];
            const imageX = image.offsetX;
            const imageY = image.offsetY;
            const imageWidth = image.image.width;
            const imageHeight = image.image.height;
            const buttonX = image.buttonOffsetX;
            const buttonY = image.buttonOffsetY;
            const buttonSize = 20;

            if (
                x >= buttonX &&
                x <= buttonX + buttonSize &&
                y >= buttonY &&
                y <= buttonY + buttonSize
            ) {
                images.splice(i, 1);
                drawCanvas();
                return -1;
            }

            if (
                x >= imageX &&
                x <= imageX + imageWidth &&
                y >= imageY &&
                y <= imageY + imageHeight
            ) {
                return i;
            }
        }

        return -1;
    }

    function updateCanvasSize() {
        const canvasContainer = document.querySelector('.canvas-container');
        canvas.width = canvasContainer.offsetWidth;
        canvas.height = canvasContainer.offsetHeight;
        drawCanvas();
    }

    function updateElementPositions() {
        const drawingBoardRect = canvas.getBoundingClientRect();
        const toolbarRect = toolbar.getBoundingClientRect();
        const imageListRect = imageList.getBoundingClientRect();

        toolbar.style.top = drawingBoardRect.bottom + 'px';
        toolbar.style.width = drawingBoardRect.width + 'px'; // toolbar의 너비를 canvas의 너비로 설정
        imageList.style.top = toolbarRect.bottom + 'px';
        imageList.style.left = drawingBoardRect.left + 'px';
        imageList.style.width = drawingBoardRect.width + 'px';
    }

    updateCanvasSize();
    updateElementPositions();
    window.addEventListener('resize', () => {
        updateCanvasSize();
        updateElementPositions();
    });

    function adjustCanvasSize() {
        const canvasContainer = document.querySelector('.canvas-container');
        canvas.width = canvasContainer.offsetWidth;
        canvas.height = canvasContainer.offsetHeight;
    }


    function resizeHandler() {
        adjustCanvasSize();
        const newImage = new Image();
        const selectedImage = document.querySelector('.left-div img.selected, .right-div img.selected');
        if (selectedImage) {
            newImage.onload = () => {
                const canvasCenterX = canvas.width / 2 - newImage.width / 2;
                const canvasCenterY = canvas.height / 2 - newImage.height / 2;
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.drawImage(newImage, canvasCenterX, canvasCenterY);
            };
            newImage.src = selectedImage.src;
        }
    }

    // 윈도우 크기 조정 이벤트 핸들러 등록
    window.addEventListener('resize', resizeHandler);

    // 초기화
    adjustCanvasSize();
</script>





</body>
</html>
