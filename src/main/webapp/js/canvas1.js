const canvas = document.getElementById('drawing-board');
const toolbar = document.getElementById('toolbar');
const ctx = canvas.getContext('2d');

const canvasOffsetX = canvas.offsetLeft;
const canvasOffsetY = canvas.offsetTop;

canvas.width = window.innerWidth - canvasOffsetX;
canvas.height = window.innerHeight - canvasOffsetY;

let isPainting = false;
let lineWidth = 5;

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
    isPainting = true;

    ctx.beginPath();
    ctx.moveTo(event.clientX - canvasOffsetX, event.clientY);
});

canvas.addEventListener('mouseup', (event) => {
    isPainting = false;
});

canvas.addEventListener('mousemove', (event) => {
    if (!isPainting) {
        return;
    }

    ctx.lineWidth = lineWidth;
    ctx.lineCap = 'round';

    ctx.lineTo(event.clientX - canvasOffsetX, event.clientY);
    ctx.stroke();
});