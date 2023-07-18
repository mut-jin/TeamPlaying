<%--
  Created by IntelliJ IDEA.
  User: 윤보상
  Date: 2023-07-16
  Time: 오후 6:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        .layout {
            display: flex;
            flex: 1 1 auto;
            flex-wrap: wrap;
            min-width: 0;
        }

        .shadow {
            box-shadow: 0 3px 30px 0 rgba(0, 0, 0, .16) !important;
        }

    </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="padding-top: 84px;">
    <form method="post" enctype="multipart/form-data">
        <div class="layout shadow" style="flex-direction: column; align-items: center">
            <h1>내문의 수정하기</h1>
            <hr>
            <div class="layout" style="width: 70%; border: 1px solid black; border-bottom: 0;">
                <div class="dropdown" style="width: 100%;">
                    <button style="width: inherit; background-color: white" class="btn dropdown-toggle" type="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                        <input style="border: 0; width: 98%;" type="text" placeholder="문의 유형" name="category"
                               id="category" readonly value="${csBoard.category}">
                    </button>
                    <ul class="dropdown-menu" style="width: 100%;">
                        <li>
                            <button type="button" class="dropdown-item" value="결제">결제</button>
                        </li>
                        <li>
                            <button type="button" class="dropdown-item" value="회원정보">회원정보</button>
                        </li>
                        <li>
                            <button type="button" class="dropdown-item" value="서비스">서비스</button>
                        </li>
                        <li>
                            <button type="button" class="dropdown-item" value="기타">기타</button>
                        </li>
                    </ul>
                </div>
            </div>
            <input type="text" name="title" style="width: 70%; height: 5vh; padding-left: 10px;" placeholder="제 목"
                   value="${csBoard.title}">
            <textarea name="body" rows="20" style="padding: 10px 0 0 10px; margin-bottom: 10px; width: 70%;"
                      placeholder="문의 내용">${csBoard.body}</textarea>
            <div style="width: 70%; margin-bottom: 30px;">
                <input class="form-control" style="height: 38px;" type="file" multiple
                       name="files" accept="image/*">
            </div>
            <div class="layout" style="margin-bottom: 30px;">
                <c:forEach items="${files}" var="file" varStatus="status">
                    <div style="position: relative; display: inline-block;" id="file${status.index}">
                        <img src="${bucketUrl }/csBoard/${csBoard.id }/${file}" alt="">
                        <button type="button" class="removeFile" data-board-fileId="file${status.index}" data-board-file="${file}" style="border: 0; color: #ec2a2a; padding: 3px; background-color: #ffffff00; position: absolute; top: 0; right: 0;">
                            <i class="fa-solid fa-xmark" style="font-size: x-large"></i>
                        </button>
                    </div>
                </c:forEach>
            </div>
            <div style="margin-bottom: 30px;">
                <input type="hidden" name="id" value="${csBoard.id }" />
                <input type="hidden" name="removeFileList" id="removeFileList" value="">
                <input type="submit" value="수정하기">
                <input type="button" onclick="location.href='/myCs/${csBoard.id}'" value="취소하기">
            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/cs.js"></script>
</body>
</html>
