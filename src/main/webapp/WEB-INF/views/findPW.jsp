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
                    <input id="inputUserId" class="form-control" type="text" name="userId" style="margin: 0 auto; width: 80%;" placeholder="아이디"/>
                </div>
                <br>
                <div class="mb-3" <%--style="margin-left:120px;"--%>>
                    <%--<label for="inputPassword" class="form-label" style="font-family: 'Jeju Gothic', sans-serif;">비밀번호</label>--%>
                    <input id="inputEmail" class="form-control" type="email" name="email" style="margin: 0 auto; width: 80%;" placeholder="이메일"/>
                </div>
                <br>
                <div class="mb-3" <%--style="margin-left:120px;"--%>>
                    <%--<label for="inputPassword" class="form-label" style="font-family: 'Jeju Gothic', sans-serif;">비밀번호</label>--%>
                    <input id="inputEmail" class="form-control" type="email" name="email" style="margin: 0 auto; width: 80%;" placeholder="인증번호 입력"/>
                </div>
                <br>
                <div class="mb-3"  style="text-align: center;"  <%--style="margin-left:120px;"--%>>
                    <button id="findId" class="btn btn-dark" style="/*width: 412.8px; height: 39px;*/ margin: 0 auto; font-family: 'Jeju Gothic', sans-serif; width: 80%;" type="submit">비밀번호 재설정</button>
                </div>
                <div id="result" style="text-align: center;">
                    <!-- 아이디가 보여질 영역 -->
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