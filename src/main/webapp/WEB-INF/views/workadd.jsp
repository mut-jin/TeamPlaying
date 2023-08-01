<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrer-policy="no-referrer"/>
    <style>
        .container-lg {
            width: 500px;
            margin: 0 auto; /* Center the container horizontally */
            margin-top: 100px; /* Add top margin for spacing */
        }

        .btn-success {
            background-color: #00C73C;
            border-color: #00C73C;
        }

        .btn-success:hover {
            background-color: #00A237;
            border-color: #00A237;
        }

        .form-label {
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        .form-control {
            border: 1px solid black;
            height: 50px;
        }

        .mb-3 {
            margin-bottom: 1rem;
        }

        .dropdown-toggle {
            width: 466px;
            border: 1px solid black;
            text-align: left;
            height: 50px;
        }

        /* 노란색 테두리 스타일 */
        .yellow-border {
            border: 1px solid yellow !important;
        }

        .yellow-label {
            color: yellow !important;
        }


        .dropdown-item.active {
            background-color: orange;
        }

        .form-control::placeholder {
            text-align: left;
            position: absolute;
            top: 0;
            left: 0;
            transform: translate(10px, 10px); /* 조정할 수 있는 위치로 이동 */
        }

        #checkIdBtn, #checkNickNameBtn, #checkEmailBtn {
            margin-top: 0.5rem;
        }

        /* Custom styles for the bordered container */
        .registration-container {
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            padding: 1rem;
            background-color: white;
            margin-bottom: 2rem;
            width: 600px; /* Adjust the width as desired */
            margin: 0 auto;
        }

        .form-group {
            position: relative;
            display: inline-block; /* 이렇게 추가해줍니다. */
        }

        .other-information {
            margin-top: 10px; /* 다른 정보와의 간격을 조절합니다. */
        }
    </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container-lg">
    <div class="row justify-content-center">

        <div class="registration-container">
            <!-- Added container -->
            <h1>작품 등록</h1>
            <br/>
            <form id="registerForm" method="post" action="/workadd" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="inputTitle" class="form-label">작품명</label>
                    <input id="inputTitle" type="title" class="form-control" name="title"
                           placeholder="작품명" onclick="highlightInput(this)"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">신발 브랜드</label>
                    <div class="dropdown" onclick="highlightInput(this)">
                        <button style="background-color: white;" class="btn dropdown-toggle" type="button"
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <input id="brand" name="brand" style="border: 0; width: 420px;" placeholder="신발 브랜드"/>
                        </button>
                        <ul class="dropdown-menu" style="width: 466px; font-size: 22px; font-weight: bolder">
                            <li>
                                <button type="button" class="dropdown-item ShoeBrand nike" id="nike" value="나이키">나이키
                                </button>
                            </li>
                            <li>
                                <button type="button" class="dropdown-item ShoeBrand adidas" id="adidas" value="아디다스">
                                    아디다스
                                </button>
                            </li>
                            <li>
                                <button type="button" class="dropdown-item ShoeBrand vans" id="vans" value="반스">반스
                                </button>
                            </li>
                            <li>
                                <button type="button" class="dropdown-item ShoeBrand converse" id="converse"
                                        value="컨버스">컨버스
                                </button>
                            </li>
                            <li>
                                <button type="button" class="dropdown-item ShoeBrand etc" id="etc" value="기타">기타
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">신발 모델명</label>
                    <div class="dropdown" onclick="highlightInput(this)">
                        <button style="background-color: white;" class="btn dropdown-toggle" type="button"
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <input id="shoeModel" name="shoeName" style="border: 0; width: 420px;"
                                   placeholder="신발 모델명"/>
                        </button>


                        <ul class="dropdown-menu" id="shoeModelDropdown"
                            style="width: 466px; font-size: 22px; font-weight: bolder">
                            <!-- 나이키 브랜드의 신발 모델 -->
                            <li><a class="dropdown-item ShoeName nike-model" href="#">에어포스 1</a></li>
                            <li><a class="dropdown-item ShoeName nike-model" href="#">우먼스 코르테즈 올흰</a></li>
                            <li><a class="dropdown-item ShoeName nike-model" href="#">조던1 미드 올백</a></li>
                            <li><a class="dropdown-item ShoeName nike-model" href="#">우먼스 에어포스 1</a></li>
                            <li><a class="dropdown-item ShoeName nike-model" href="#">에어포스 1(블랙)</a></li>
                            <li><a class="dropdown-item ShoeName nike-model" href="#">기타</a></li>

                            <!-- 아디다스 브랜드의 신발 모델 -->
                            <li><a class="dropdown-item ShoeName adidas-model" href="#">이지부스트 350</a></li>
                            <li><a class="dropdown-item ShoeName adidas-model" href="#">슈퍼스타</a></li>
                            <li><a class="dropdown-item ShoeName adidas-model" href="#">기타</a></li>

                            <!-- 반스 브랜드의 신발 모델 -->
                            <li><a class="dropdown-item ShoeName vans-model" href="#">올드스쿨 (화이트)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">어센틱 (화이트)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">클래식 슬립온 (화이트)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">올드스쿨 (블랙)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">어센틱 (블랙)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">클래식 슬립온 (블랙)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">에라 (블랙)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">에라 (화이트)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">클래식 슬립온 (체커)</a></li>
                            <li><a class="dropdown-item ShoeName vans-model" href="#">기타</a></li>

                            <!-- 컨버스 브랜드의 신발 모델 -->
                            <li><a class="dropdown-item ShoeName converse-model" href="#">척테일러 1970S 하이 (블랙)</a></li>
                            <li><a class="dropdown-item ShoeName converse-model" href="#">척테일러 1970S 하이 (화이트)</a></li>
                            <li><a class="dropdown-item ShoeName converse-model" href="#">척테일러 1970S 로우 (블랙)</a></li>
                            <li><a class="dropdown-item ShoeName converse-model" href="#">척테일러 1970S 로우 (화이트)</a></li>
                            <li><a class="dropdown-item ShoeName converse-model" href="#">기타</a></li>

                            <%-- 기타 브랜드의 신발 모델 --%>
                            <li><a class="dropdown-item ShoeName etc-model" href="#">기타</a></li>
                        </ul>
                    </div>

                    <br>
                    <div class="form-text">1MB 크기의 파일, 총 10MB 크기만 허용</div>
                    <div class="form-group" style="width: 466px;">
                        <!-- <label for="fileInput" class="form-label"></label>  -->
                        <input class="form-control form-control-user" style="height: 38px;" type="file" multiple
                               name="files" accept="image/*"
                               id="fileInput" onchange="setDetailImage(event);"/>
                    </div>
                    <div id="images_preview"></div>
                    <div class="other-information">
                        <div>
                            <label for="inputPrice" class="form-label">작업 비용</label>
                            <input id="inputPrice" type="title" class="form-control" name="price"
                                   placeholder="작업 비용" onclick="highlightInput(this)"/>
                        </div>
                        <br>
                        <div class="mb-3">
                            <label for="inputMakeTime" class="form-label">작업 일수</label>
                            <input id="inputMakeTime" type="makeTime" class="form-control" name="makeTime"
                                   value="${shoeBoard.makeTime }"
                                   placeholder="작업 일수" onclick="highlightInput(this)"/>
                        </div>

                        <div class="mb-3">
                            <label for="inputBody" class="form-label">작품 설명</label>
                            <input id="inputBody" style="height: 250px;" type="body" class="form-control" name="body"
                                   value="${shoeBoard.body }"
                                   placeholder="작품 설명" onclick="highlightInput(this)"/>
                        </div>

                        <div class="mb-3">
                            <button class="btn btn-warning"
                                    style="width: 466px; height: 50px; color: white; font-size: 20px;" type="submit">
                                등록하기
                            </button>
                        </div>
                    </div>

                </div>
            </form>
            <form method="post">

            </form>
        </div>


    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/workadd.js"></script>
<script>
    // 이전에 클릭한 요소를 저장하는 변수
    let previousClickedElement = null;

    function highlightInput(input) {
        console.log(input);
        // 이전에 클릭한 요소의 테두리와 텍스트 색상을 원래 색으로 되돌림
        if (previousClickedElement !== null) {
            previousClickedElement.classList.remove('yellow-border');
            const labelElement = previousClickedElement.parentNode.querySelector('.form-label');
            labelElement.classList.remove('yellow-label');
        }

        // 현재 클릭한 요소에 노란색 테두리를 적용
        input.classList.add('yellow-border');
        const labelElement = input.parentNode.querySelector('.form-label');
        labelElement.classList.add('yellow-label');

        // 이전에 클릭한 요소를 현재 클릭한 요소로 업데이트
        previousClickedElement = input;
    }


</script>

<script>
    function setDetailImage(event) {
        var container = document.getElementById('images_container');
        container.innerHTML = ''; // 이전에 표시된 이미지를 제거합니다.

        var files = event.target.files;
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var reader = new FileReader();
            reader.onload = function (e) {
                var image = document.createElement('img');
                image.src = e.target.result;
                image.style.maxWidth = '100%';
                image.style.maxHeight = '100%';
                container.appendChild(image);
            }
            reader.readAsDataURL(file);
        }
    }
</script>

<script>
    function setDetailImage(event) {
        const previewContainer = document.getElementById("images_preview");
        previewContainer.innerHTML = "";

        const files = event.target.files;
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function (e) {
                const image = document.createElement("img");
                image.src = e.target.result;
                image.style.width = "250px";
                image.style.height = "200px";
                image.style.objectFit = "cover";
                previewContainer.appendChild(image);
            };

            reader.readAsDataURL(file);
        }
    }
</script>


</body>
</html>