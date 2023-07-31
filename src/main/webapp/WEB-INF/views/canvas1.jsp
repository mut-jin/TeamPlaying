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
                <div class="card" style="margin-bottom: 100px;">
                    <div id="outImage" class="canvas-image">
                        <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-out1.webp" alt="..." style="width: 200px; height: auto">
                    </div>
                    <div class="card-body">
                        <button> 버튼 </button>
                    </div>
                </div>
                <div class="card">
                    <div id="innerImage" class="canvas-image">
                        <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-in1.webp" alt="..." style="width: 200px; height: auto">
                    </div>
                    <div class="card-body">
                        <button> 버튼 </button>
                    </div>
                </div>
            </div>
            <div class="col-8 d-flex justify-content-center" style="margin-top: 200px;">
                <div class="canvas-container" id="canvas-container">
                    <canvas id="drawing-board" style="border-radius: 10px; border: 2px solid #000;"></canvas>
                    <img id="canvas-image" src="" alt="Selected Image">
                </div>
            </div>
            <div class="col-2 right-div d-flex flex-column align-items-center" style="display: flex; flex-direction: column; align-items: center; margin-top: 200px;">
                <div class="card">
                    <div id="leftImage" class="canvas-image">
                        <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-left1.webp" alt="..." style="width: 200px; height: auto">
                    </div>
                    <div class="card-body">
                        <button> 버튼 </button>
                    </div>
                </div>
                <div class="card">
                    <div id="backImage" class="canvas-image">
                        <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-back1.webp" alt="..." style="width: 200px; height: auto">
                    </div>
                    <div class="card-body">
                        <button> 버튼 </button>
                    </div>
                </div>
                <div class="card">
                    <div id="rightImage" class="canvas-image">
                        <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-right1.webp" alt="..." style="width: 200px; height: auto">
                    </div>
                    <div class="card-body">
                        <button> 버튼 </button>
                    </div>
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
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            신발 목록
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">에어포스</a></li>
                            <li><a class="dropdown-item" href="#">올드스쿨</a></li>
                            <li><a class="dropdown-item" href="#">컨버스</a></li>
                            <li><a class="dropdown-item" href="#">조던</a></li>
                        </ul>
                    </div>
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

    // Dropdown 아이템 클릭 이벤트 처리
    const dropdownItems = document.querySelectorAll('.dropdown-item');
    dropdownItems.forEach(item => {
        item.addEventListener('click', function() {
            const selectedShoe = this.textContent;

            // 이미지 URL 변경
            if (selectedShoe === '에어포스') {
                document.getElementById('outImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-out1.webp';  // 바깥 이미지 변경
                document.getElementById('innerImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-in1.webp';  // 안쪽 이미지 변경
                document.getElementById('leftImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-left1.webp';  // 왼쪽 위 이미지 변경
                document.getElementById('backImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-back1.webp';  // 뒷면 이미지 변경
                document.getElementById('rightImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/airforce/airforce-right1.webp';  // 오른쪽 위 이미지 변경
                clearCanvas();
            } else if (selectedShoe === '올드스쿨') {
                document.getElementById('outImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/oldschool/oldschool-out.png';  // 바깥 이미지 변경
                document.getElementById('innerImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/oldschool/oldschool-in.png';  // 안쪽 이미지 변경
                document.getElementById('leftImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/oldschool/oldschool-left.png';  // 왼쪽 위 이미지 변경
                document.getElementById('backImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/oldschool/oldschool-back.png';  // 뒷면 이미지 변경
                document.getElementById('rightImage').firstElementChild.src = 'https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/ShoeExample/oldschool/oldschool-right.png';  // 오른쪽 위 이미지 변경
                clearCanvas();
            } else if (selectedShoe === '컨버스') {
                // 컨버스에 대한 이미지 URL 변경
                clearCanvas();
            } else if (selectedShoe === '조던') {
                // 조던에 대한 이미지 URL 변경
                clearCanvas();
            }
        });
    });

    // 선택한 단면 이미지와 꾸밀 요소들을 저장하는 객체
    const selectedImages = {
        outImage: { image: null, decorations: [] },
        innerImage: { image: null, decorations: [] },
        leftImage: { image: null, decorations: [] },
        backImage: { image: null, decorations: [] },
        rightImage: { image: null, decorations: [] }
    };

    // 꾸밀 요소들을 그리는 함수
    function drawDecorations(imageType) {
        const image = selectedImages[imageType].image;
        const decorations = selectedImages[imageType].decorations;
        if (!image) return;

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.drawImage(image, 0, 0);

        for (const decoration of decorations) {
            ctx.drawImage(decoration.image, decoration.x, decoration.y);
        }
    }

    // 이미지를 선택하고 꾸밀 요소들을 저장하는 함수
    function selectImage(imageElement, imageType) {
        const newImage = new Image();
        newImage.onload = () => {
            selectedImages[imageType].image = newImage;
            selectedImage = {
                image: newImage,
                decorations: [],
                offsetX: 0,
                offsetY: 0
            };

            drawDecorations(imageType);
        };
        newImage.src = imageElement.src;
    }

    // 꾸밀 요소를 추가하는 함수
    function addDecoration(imageType, decorationImage, x, y) {
        selectedImages[imageType].decorations.push({ image: decorationImage, x, y });

        drawDecorations(imageType);
    }

    // 예시: innerImage를 클릭했을 때 이전 outImage의 꾸밀 요소들을 적용
    innerImage.addEventListener('click', () => {
        drawDecorations('outImage');
    });

    // 예시: outImage를 클릭했을 때 이전 outImage의 꾸밀 요소들을 적용
    outImage.addEventListener('click', () => {
        drawDecorations('outImage');
    });

    // 예시: 이미지를 선택하고 꾸밀 요소 추가하기
    const imageListImages = document.querySelectorAll('.image-list img');
    imageListImages.forEach((image) => {
        image.addEventListener('click', function () {
            const selectedImageType = this.dataset.imageType;
            selectImage(this, selectedImageType);
        });
    });

    // 예시: painting 요소를 클릭하면 꾸밀 요소 추가하기
    canvas.addEventListener('click', (event) => {
        const { offsetX, offsetY } = event;
        const selectedImageType = document.querySelector('.selected-image').dataset.imageType;
        const decorationImage = document.getElementById('selectedDecoration');

        const canvasRect = canvas.getBoundingClientRect();
        const clickedX = event.clientX - canvasRect.left;
        const clickedY = event.clientY - canvasRect.top;

        const rotateButtonIndex = findClickedRotateButton(clickedX, clickedY);
        if (rotateButtonIndex !== -1) {
            images[rotateButtonIndex].showButtons = !images[rotateButtonIndex].showButtons;
            drawCanvas();
            return; // 이미지를 눌러서 회전 버튼을 보여준 경우 더 이상의 처리는 하지 않도록 반환
        }

        const clickedImageIndex = findClickedImage(clickedX, clickedY);
        if (clickedImageIndex !== -1) {
            images[clickedImageIndex].showButtons = !images[clickedImageIndex].showButtons;
            drawCanvas();
        }

        addDecoration(selectedImageType, decorationImage, offsetX, offsetY);
    });



    leftDivImages.forEach((image) => {
        image.addEventListener('click', () => {
            const newImage = new Image();
            newImage.onload = () => {
                const canvasCenterX = canvas.width / 2 - newImage.width / 2;
                const canvasCenterY = canvas.height / 2 - newImage.height / 2;
                // 이미지 대체 로직 추가
                const existingImage = shoeImage.find((item) => item.name === image.name);
                if (existingImage) {
                    // 이미 해당 이미지가 존재하는 경우 대체
                    existingImage.image = newImage;
                    existingImage.offsetX = canvasCenterX;
                    existingImage.offsetY = canvasCenterY;
                } else {
                    // 이미지 추가
                    shoeImage.push({
                        name: image.name,
                        image: newImage,
                        offsetX: canvasCenterX,
                        offsetY: canvasCenterY,
                        loaded: true
                    });
                }
                drawCanvas();
            };
            newImage.crossOrigin = 'Anonymous';

            newImage.src = image.src;
        });
    });

    rightDivImages.forEach((image) => {
        image.addEventListener('click', () => {
            const newImage = new Image();
            newImage.onload = () => {
                const canvasCenterX = canvas.width / 2 - newImage.width / 2;
                const canvasCenterY = canvas.height / 2 - newImage.height / 2;
                // 이미지 대체 로직 추가
                const existingImage = shoeImage.find((item) => item.name === image.name);
                if (existingImage) {
                    // 이미 해당 이미지가 존재하는 경우 대체
                    existingImage.image = newImage;
                    existingImage.offsetX = canvasCenterX;
                    existingImage.offsetY = canvasCenterY;
                } else {
                    // 이미지 추가
                    shoeImage.push({
                        name: image.name,
                        image: newImage,
                        offsetX: canvasCenterX,
                        offsetY: canvasCenterY,
                        loaded: true
                    });
                }
                drawCanvas();
            };
            newImage.crossOrigin = 'Anonymous';

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
        location.reload(); // 페이지를 새로고침합니다.
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
                rotation: 0, // 회전 각도 초기값
                loaded: false,
                layer: 'front'
            };
            newImage.crossOrigin = 'Anonymous';
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
    let isRotating = false;
    let rotateImageIndex = -1;
    let rotateStartX = 0;
    let rotateStartY = 0;
    let rotateCenterX = 0;
    let rotateCenterY = 0;

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
            // 회전 버튼 클릭 시 회전 시작
            const rotateButtonIndex = findClickedRotateButton(clickedX, clickedY);
            if (rotateButtonIndex !== -1) {
                isRotating = true;
                rotateImageIndex = rotateButtonIndex;
                rotateStartX = clickedX;
                rotateStartY = clickedY;
                images[rotateButtonIndex].showButtons = !images[rotateButtonIndex].showButtons;
                drawCanvas();
                rotateCenterX = images[rotateButtonIndex].offsetX + images[rotateButtonIndex].image.width / 2;
                rotateCenterY = images[rotateButtonIndex].offsetY + images[rotateButtonIndex].image.height / 2;
            } else {
                isPainting = true;
                paintingPoints.push([]);
            }
        }

        if (!isDragging && !isRotating) {
            // 새로운 그리기 경로 생성
            currentPath = [];
            paintingPoints.push(currentPath);
        }
    });

    const rotateSpeed = 0.1; // 회전 속도를 조절하는 값 (더 작은 값일수록 느리게 회전)
    const rotateButtonSize = 20; // 회전 버튼의 크기
    // 회전 버튼 그리기
    function drawRotateButton(x, y, image) {
        /*const buttonOffsetX = x - rotateButtonSize / 2; // 이미지 왼쪽 상단 꼭지점에 맞춤
        const buttonOffsetY = y - rotateButtonSize / 2; // 이미지 왼쪽 상단 꼭지점에 맞춤

        // 회전 버튼 그리기
        ctx.fillStyle = '#00ff00';
        ctx.fillRect(buttonOffsetX, buttonOffsetY, rotateButtonSize, rotateButtonSize);*/
        const buttonSize = 20;
        const centerX = image.offsetX + image.width - buttonSize;
        const centerY = image.offsetY - buttonSize;
        const radius = buttonSize / 2;
        const arrowSize = 5;

        ctx.fillStyle = '#00ff00'; // 버튼 색상
        ctx.beginPath();
        ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI); // 원 그리기
        ctx.fill();

        // 원 중심을 기준으로 삼각형 그리기 (시계 방향)
        ctx.fillStyle = '#ffffff'; // 삼각형 색상
        ctx.beginPath();
        ctx.moveTo(centerX + arrowSize, centerY);
        ctx.lineTo(centerX - arrowSize, centerY - arrowSize);
        ctx.lineTo(centerX - arrowSize, centerY + arrowSize);
        ctx.closePath();
        ctx.fill();
    }

    canvas.addEventListener('mouseup', () => {
        isPainting = false;
        isDragging = false;
        isRotating = false;
    });

    // 회전 버튼 클릭 여부 확인
    function findClickedRotateButton(x, y) {
        for (let i = images.length - 1; i >= 0; i--) {
            const image = images[i];
            const buttonX = image.offsetX - 10;
            const buttonY = image.offsetY - 10;
            const buttonSize = 20;

            if (
                x >= buttonX &&
                x <= buttonX + buttonSize &&
                y >= buttonY &&
                y <= buttonY + buttonSize
            ) {
                return i;
            }
        }

        return -1;
    }

    canvas.addEventListener('mousemove', (event) => {
        const canvasRect = canvas.getBoundingClientRect();
        const currentX = event.clientX - canvasRect.left;
        const currentY = event.clientY - canvasRect.top;

        if (!isPainting && !isDragging && !isRotating) {
            return;
        }

        if (isDragging) {
            images[dragImageIndex].offsetX = currentX - dragStartX;
            images[dragImageIndex].offsetY = currentY - dragStartY;
            images[dragImageIndex].buttonOffsetX = images[dragImageIndex].offsetX + images[dragImageIndex].image.width - 10;
            images[dragImageIndex].buttonOffsetY = images[dragImageIndex].offsetY - 10;
            drawCanvas();
        } else if (isRotating) {
            const rotateAngle = calculateRotationAngle(
                currentX,
                currentY,
                rotateStartX,
                rotateStartY,
                rotateCenterX,
                rotateCenterY
            );
            images[rotateImageIndex].rotation += rotateSpeed * rotateAngle; // 회전 속도 조절
            drawCanvas();
        } else {
            if (isPainting) {
                //paintingPoints[paintingPoints.length - 1].push({ x: currentX, y: currentY });
                currentPath.push({ x: currentX, y: currentY });
                drawCanvas();
            }
        }
    });

    // 회전 각도 계산
    function calculateRotationAngle(currentX, currentY, startX, startY, centerX, centerY) {
        const startAngle = Math.atan2(startY - centerY, startX - centerX);
        const currentAngle = Math.atan2(currentY - centerY, currentX - centerX);
        let rotateAngle = currentAngle - startAngle;
        rotateAngle = (rotateAngle * 180) / Math.PI; // 라디안을 각도로 변환

        // 회전 방향 결정
        if (rotateAngle < -180) {
            rotateAngle += 360;
        } else if (rotateAngle > 180) {
            rotateAngle -= 360;
        }

        return rotateAngle;
    }

    // 이미지 캐시 객체
    const imageCache = {};

    function drawImages() {
        for (const image of images) {
            if (image.loaded) {
                const { offsetX, offsetY, image: img, rotation } = image;
                img.crossOrigin = 'Anonymous'; // CORS 정책 우회 설정
                drawImageWithRotation(img, offsetX, offsetY, rotation);
                if (image.showButtons) {
                    drawRotateButton(offsetX, offsetY, img);
                    drawDeleteButton(offsetX + img.width - 10, offsetY - 10);
                }
            }
        }
    }

    // 이미지와 회전 버튼 그리는 함수
    function drawImageWithRotation(image, offsetX, offsetY, rotation) {
        const centerX = offsetX + image.width / 2;
        const centerY = offsetY + image.height / 2;

        ctx.save(); // 현재 캔버스 상태 저장

        // 이미지 회전을 위한 변환 작업
        ctx.translate(centerX, centerY);
        ctx.rotate((rotation * Math.PI) / 180); // 각도를 라디안으로 변환하여 회전
        ctx.drawImage(image, -image.width / 2, -image.height / 2, image.width, image.height);

        ctx.restore(); // 이전 캔버스 상태 복원
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
    }

    function drawDeleteButton(x, y) {
        const buttonSize = 20;

        ctx.fillStyle = '#ff0000'; // 버튼 색상
        ctx.fillRect(x, y, buttonSize, buttonSize); // 사각형 그리기

        // X 모양 그리기
        ctx.strokeStyle = '#ffffff'; // X 모양 색상
        ctx.lineWidth = 2;
        ctx.beginPath();
        ctx.moveTo(x + 4, y + 4);
        ctx.lineTo(x + buttonSize - 4, y + buttonSize - 4);
        ctx.moveTo(x + 4, y + buttonSize - 4);
        ctx.lineTo(x + buttonSize - 4, y + 4);
        ctx.stroke();
    }

    function findClickedImage(x, y) {
        for (let i = images.length - 1; i >= 0; i--) {
            const image = images[i];
            const { offsetX, offsetY, image: img } = image;
            const imageX = image.offsetX;
            const imageY = image.offsetY;
            const imageWidth = image.image.width;
            const imageHeight = image.image.height;
            const buttonX = offsetX + img.width - 10;
            const buttonY = offsetY - 10;
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

    // 이미지 리스트에서 회전 버튼 클릭 여부 확인
    function findClickedRotateButton(x, y) {
        for (let i = images.length - 1; i >= 0; i--) {
            const image = images[i];
            const buttonX = image.offsetX;
            const buttonY = image.offsetY - 20;
            const buttonSize = 20;

            if (
                x >= buttonX &&
                x <= buttonX + buttonSize &&
                y >= buttonY &&
                y <= buttonY + buttonSize
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
