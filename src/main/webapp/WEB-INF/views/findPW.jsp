<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
<my:navBar current="login"></my:navBar>

<div class="container-lg">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <br><br><br><br>
            <h1 class="login-title" style="/*margin-left:265px;*/ text-align: center; font-family: 'Jeju Gothic', sans-serif;">Zero-One</h1>
            <br/>
            <form method="post" id="findIdForm">
                <div class="mb-3" <%--style="margin-left:120px;"--%>>
                    <%--<label for="inputUsername" class="form-label" style="font-family: 'Jeju Gothic', sans-serif; width: 80%;">아이디</label>--%>
                    <div class="input-group" style="margin: 0 auto; width: 80%;">
                        <input id="inputUserId" class="form-control" type="text" name="userId" placeholder="아이디"/>
                        <button class="btn btn-outline-secondary" type="button" id="checkIdBtn">아이디  확인</button>
                    </div>
                    <div class="d-none form-text text-primary" id="existIdMessage" style="margin: 0 auto; width: 80%;">
                        <i class="fa-solid fa-check"></i>
                        존재하는 ID입니다.
                    </div>
                    <div class="d-none form-text text-danger" id="notExistIdMessage" style="margin: 0 auto; width: 80%;">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        존재하지 않는 ID입니다. ID를 확인해주세요
                    </div>
                </div>
                <br>
                <div class="mb-3" <%--style="margin-left:120px;"--%>>
                    <%--<label for="inputPassword" class="form-label" style="font-family: 'Jeju Gothic', sans-serif;">비밀번호</label>--%>
                    <div class="input-group" id="emailGroup" style="width: 80%; margin: 0 auto">
                        <input id="inputEmail" class="form-control" type="email" name="email" style="margin: 0 auto;" placeholder="등록한 이메일"/>
                        <button class="btn btn-success" type="button" id="emailAuth">인증코드받기</button>
                    </div>
                    <div class="d-none form-text text-primary" id="availableEmailMessage" style="margin: 0 auto; width: 80%;">
                        <i class="fa-solid fa-check"></i>
                        이메일로 인증코드를 발송했습니다. 인증코드를 입력해주세요.
                    </div>
                    <div class="d-none form-text text-danger" id="notAvailableEmailMessage" style="margin: 0 auto; width: 80%;">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        등록된 이메일과 일치하지 않습니다. 다시 입력해주세요.
                    </div>
                </div>
                <br>
                <div class="mb-3"  <%--style="margin-left:120px;"--%>>
                    <%--<label for="inputPassword" class="form-label" style="font-family: 'Jeju Gothic', sans-serif;">비밀번호</label>--%>
                    <input class="form-control" id="authCode" maxlength="6" disabled="disabled" name="authCode" type="text" placeholder="인증 코드 6자리를 입력해주세요." style="margin: 0 auto; width: 80%;" autofocus>
                    <div style="margin: 0 auto; width: 80%;">
                        <span id="emailAuthWarn"></span>
                    </div>
                </div>
                <br>
                <div class="mb-3"  style="text-align: center;"  <%--style="margin-left:120px;"--%>>
                    <button id="findPW" class="btn btn-dark" style="/*width: 412.8px; height: 39px;*/ margin: 0 auto; font-family: 'Jeju Gothic', sans-serif; width: 80%;" type="submit" disabled="disabled" onclick="location.href='/login.jsp'">임시 비밀번호 발급</button>
                </div>
            </form>
            <sec:csrfInput/>
        </div>
    </div>
</div>

<script src="/js/findPW.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


</body>
</html>