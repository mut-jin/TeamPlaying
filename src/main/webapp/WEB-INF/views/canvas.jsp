<%--
  Created by IntelliJ IDEA.
  User: dkssu
  Date: 2023-07-07
  Time: 오전 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
      crossorigin="anonymous" referrerpolicy="no-referrer"/>
<head>
    <title>Custom</title>
    <style>
        /*body {
            margin: 0;
            padding: 0;
            height: 100%;
            !*overflow: hidden;*!
            color: white;
        }*/
        /*.container {
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        #toolbar {
            display: flex;
            flex-direction: row;
            height: auto;
            background-color: black;
        }

        #toolbar * {
            margin-bottom: 5px;
        }

        #toolbar input {
            width: 100%;
        }*/
    </style>

</head>
<body>
<my:navBar></my:navBar>
<br>
<br>
<br>
<br>
<br>

<%--s3://bucket0503-mason/TeamPlay/
--%>
<section style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
    <canvas id="drawing-board" style="border: 1px solid black; border-radius: 10px; width: 80%; height: auto; position: relative;"></canvas>
    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/UserPhoto.jpg" onclick="handleImageClick(event)" style="max-width: 100%; max-height: 100%;" />
    <div id="toolbar" style="border: 1px solid black; border-radius: 10px; width: 80%;">
        <label for="stroke">color</label>
        <input id="stroke" name='stroke' type="color">

        <label for="lineWidth">선 두께</label>
        <input id="lineWidth" name='lineWidth' type="range" min="0.1" max="20" value="10" step="0.1" />

        <button onclick="selectMode('delete')">Delete</button>
        <button onclick="selectMode('draw')">Draw</button>

        <button id="clear">Clear</button>
        <form method="post" enctype="multipart/form-data">
            <div class=""></div>
        </form>

    </div>
</section>

<script>
    const canvas = document.getElementById('drawing-board');
    const toolbar = document.getElementById('toolbar');
    const ctx = canvas.getContext('2d');
    const canvasOffsetX = canvas.offsetLeft;
    const canvasOffsetY = canvas.offsetTop;

    canvas.width = window.innerWidth - canvasOffsetX;
    canvas.height = window.innerHeight - canvasOffsetY;

    let isPainting = false;
    let isDragging = false;
    let isDeleting = false;
    let lineWidth = 5;
    let imageX = 0;
    let imageY = 0;

    toolbar.addEventListener('click', (event) => {
        if (event.target.id === 'clear') {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }
    });

    toolbar.addEventListener('change', (event) => {
        if (event.target.id === 'stroke') {
            ctx.strokeStyle = event.target.value;
        }

        if (event.target.id === 'lineWidth') {
            lineWidth = event.target.value;
        }
    });

    canvas.addEventListener('mousedown', (event) => {
        if (isDeleting) {
            handleDelete(event);
        } else {
            isPainting = true;
            ctx.beginPath();
            ctx.moveTo(event.clientX - canvasOffsetX, event.clientY);
        }
    });

    canvas.addEventListener('mouseup', (event) => {
        isPainting = false;
    });

    canvas.addEventListener('mousemove', (event) => {
        if (isPainting) {
            ctx.lineWidth = lineWidth;
            ctx.lineCap = 'round';
            ctx.lineTo(event.clientX - canvasOffsetX, event.clientY);
            ctx.stroke();
        } else if (isDragging) {
            handleMouseMove(event);
        }
    });

    function handleImageClick(event) {
        if (isPainting || isDeleting) {
            return;
        }

        const image = new Image();
        image.src = event.target.src;
        image.onload = function() {
            const centerX = (canvas.width - image.width) / 2;
            const centerY = (canvas.height - image.height) / 2;
            imageX = centerX;
            imageY = centerY;

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.drawImage(image, centerX, centerY);

            const deleteButtonSize = 20;
            const deleteButtonX = centerX;
            const deleteButtonY = centerY - deleteButtonSize;
            ctx.fillStyle = 'red';
            ctx.fillRect(deleteButtonX, deleteButtonY, deleteButtonSize, deleteButtonSize);
        };
    }

    function handleDelete(event) {
        if (isDeleting) {
            const deleteButtonSize = 20;
            const deleteButtonX = (canvas.width - deleteButtonSize) / 2;
            const deleteButtonY = (canvas.height - deleteButtonSize) / 2 - deleteButtonSize;

            const clickX = event.clientX - canvasOffsetX;
            const clickY = event.clientY - canvasOffsetY;

            if (clickX >= deleteButtonX && clickX <= deleteButtonX + deleteButtonSize &&
                clickY >= deleteButtonY && clickY <= deleteButtonY + deleteButtonSize) {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
            }
        }
    }

    function handleMouseDown(event) {
        if (isDeleting) {
            handleDelete(event);
        } else {
            isDragging = true;
            dragStartX = event.clientX;
            dragStartY = event.clientY;
        }
    }

    function handleMouseMove(event) {
        if (isDragging) {
            const dragOffsetX = event.clientX - dragStartX;
            const dragOffsetY = event.clientY - dragStartY;

            imageX += dragOffsetX;
            imageY += dragOffsetY;

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.drawImage(image, imageX, imageY);

            dragStartX = event.clientX;
            dragStartY = event.clientY;
        }
    }

    function handleMouseUp(event) {
        isDragging = false;
    }

    function selectMode(mode) {
        isPainting = false;
        isDeleting = false;
        isDragging = false;

        if (mode === 'draw') {
            toolbar.style.cursor = 'crosshair';
            canvas.removeEventListener('mousedown', handleMouseDown);
            canvas.removeEventListener('mousemove', handleMouseMove);
            canvas.removeEventListener('mouseup', handleMouseUp);
        } else if (mode === 'delete') {
            toolbar.style.cursor = 'pointer';
            canvas.addEventListener('mousedown', handleMouseDown);
            canvas.addEventListener('mousemove', handleMouseMove);
            canvas.addEventListener('mouseup', handleMouseUp);
        }
    }

    selectMode('draw');
</script>

</html>
