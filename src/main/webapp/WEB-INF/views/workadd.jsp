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
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
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
        }

        .mb-3 {
            margin-bottom: 1rem;
        }

        .dropdown-toggle {
            width: 466px;
            border: 1px solid black;
            text-align: left;
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
            <div class="mb-3">
                <label for="inputTitle" class="form-label">작품명</label>
                <input id="inputTitle" type="title" class="form-control" name="title" value="${member.title }" placeholder="작품명"/>
            </div>
            <div class="mb-3">
                <label class="form-label">신발 브랜드</label>
                <div class="dropdown">
                    <button style="background-color: white;" class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <input id="brand" style="border: 0; width: 420px;" placeholder="신발 브랜드"/>
                    </button>
                    <ul class="dropdown-menu">
                        <li><button class="dropdown-item ShoeBrand nike" id="nike" value="나이키">나이키</button></li>
                        <li><button class="dropdown-item ShoeBrand adidas" id="adidas" value="아디다스">아디다스</button></li>
                        <li><button class="dropdown-item ShoeBrand vans" id="vans" value="반스">반스</button></li>
                        <li><button class="dropdown-item ShoeBrand converse" id="converse" value="컨버스">컨버스</button></li>
                    </ul>
                </div>
            </div>
            <div class="mb-3">
                <label for="inputShoeName" class="form-label">신발 모델명</label>
                <div class="dropdown">
                    <button style="background-color: white;" class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <input style="border: 0; width: 420px;" placeholder="신발 모델명"/>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item ShoeName nike-model" href="#">에어포스 1</a></li>
                        <li><a class="dropdown-item ShoeName nike-model" href="#">우먼스 코르테즈 올흰</a></li>
                        <li><a class="dropdown-item ShoeName nike-model" href="#">조던1 미드 올백</a></li>
                        <li><a class="dropdown-item ShoeName nike-model" href="#">우먼스 에어포스 1</a></li>
                        <li><a class="dropdown-item ShoeName nike-model" href="#">에어포스 1(블랙)</a></li>
                    </ul>
                </div>
            </div>

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
</body>
</html>