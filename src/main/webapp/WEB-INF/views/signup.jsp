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

        .mb-3 {
            margin-bottom: 1rem;
        }

        #checkIdBtn, #checkNickNameBtn, #checkEmailBtn {
            margin-top: 0.5rem;
        }

        .search-container {
            display: flex;
            align-items: center;
        }

        .search-input {
            flex: 1;
            margin-right: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 6px 12px;
        }

        .search-button {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 6px 12px;
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
<my:alert></my:alert>
<my:navBar></my:navBar>
<div class="container-lg">
    <div class="row justify-content-center">

        <div class="registration-container">
            <!-- Added container -->
            <h1>회원가입</h1>
            <br/>
            <form method="post">
                <div class="mb-3">
                    <label for="inputId" class="form-label">아이디</label>
                    <input id="inputId" type="text" class="form-control" name="userId" value="${member.userId }"/>
                    <!-- <div id="availableIdMessage">사용 가능한 ID입니다.</div>
              <div id="notAvailableIdMessage">사용 불가능한 ID입니다.</div>
              <button type="button" id="checkIdBtn" class="btn btn-secondary">중복확인</button> -->
                </div>
                <div class="mb-3">
                    <label for="inputPassword" class="form-label">비밀번호</label>
                    <input id="inputPassword" type="password" class="form-control" name="password"
                           value="${member.password }"/>
                </div>
                <div class="mb-3">
                    <label for="inputName" class="form-label">이름</label>
                    <input id="inputName" type="text" class="form-control" name="name" value="${member.name }"/>
                </div>
                <div class="mb-3">
                    <label for="inputNickName" class="form-label">닉네임</label>
                    <input id="inputNickName" type="text" class="form-control" name="nickName"
                           value="${member.nickName }"/>
                    <!-- <div id="availableNickNameMessage">사용 가능한 별명입니다.</div>
              <div id="notAvailableNickNameMessage">사용 불가능한 별명입니다.</div>
              <button type="button" id="checkNickNameBtn" class="btn btn-secondary">중복확인</button> -->
                </div>
                <div class="mb-3">
                    <label for="inputBirth" class="form-label">생년월일</label>
                    <input id="inputBirth" type="text" class="form-control" name="birth" value="${member.birth }"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">회원구분</label>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="memberType" id="memberTypeInputCustomer"
                               value="customer" checked>
                        <label class="form-check-label" for="memberTypeInputCustomer"> 고객 </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="memberType" id="memberTypeInputArtist"
                               value="artist">
                        <label class="form-check-label" for="memberTypeInputArtist"> 아티스트 </label>
                    </div>
                    <div class="form-check" style="display: none">
                        <input class="form-check-input" type="radio" name="memberType" id="memberTypeInputAdmin"
                               value="admin">
                        <label class="form-check-label" for="memberTypeInputAdmin"> 관리자 </label>
                    </div>
                </div>

                <label class="form-label">주소</label>
                <div>
                    <div class="search-container">
                        <input type="text" id="address_kakao" name="address" value="${member.address}" readonly class="search-input" placeholder="주소">
                    </div>
                    <div class="search-container">
                        <input id="inputAddressDetail" type="text" class="form-control search-input" name="addressDetail" value="${member.addressDetail}" placeholder="상세주소">
                    </div>
                </div>

                <br>

                <div class="mb-3">
                    <label for="inputPhone" class="form-label">전화번호</label>
                    <input id="inputPhone" type="text" class="form-control" name="phone" value="${member.phone }"/>
                </div>
                <div class="mb-3">
                    <label for="inputEmail" class="form-label">이메일</label>
                    <input id="inputEmail" type="text" class="form-control" name="email" value="${member.email }"/>
                    <!-- <div id="availableEmailMessage">사용 가능한 이메일입니다.</div>
              <div id="notAvailableEmailMessage">사용 불가능한 이메일입니다.</div>
              <button type="button" id="checkEmailBtn" class="btn btn-secondary">중복확인</button> -->
                </div>
                <div class="mb-3">
                    <label for="inputIntroduce" class="form-label">소개</label>
                    <input id="inputIntroduce" type="text" class="form-control" name="introduce"
                           value="${member.introduce }"/>
                </div>
                <div class="mb-3">
                    <input id="signupSubmit" class="btn btn-dark" type="submit" value="회원가입">
                </div>
            </form>
        </div>

    </div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    window.onload = function () {
        document.getElementById("address_kakao").addEventListener("click", function () { //주소입력칸을 클릭하면
            new daum.Postcode({
                oncomplete: function (data) {
                    document.getElementById("address_kakao").value = data.address; // 주소 넣기
                    document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
                }
            }).open();
        });
    }
</script>



