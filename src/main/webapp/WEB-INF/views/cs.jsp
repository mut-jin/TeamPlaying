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
<div class="container" style="padding-top: 74px;">
    <form style="display: flex; justify-content: center;" method="post" enctype="multipart/form-data">
        <div style="width: 70%;">
            <div class="layout shadow">
                <div style="flex-basis: 15%; max-width: 15%;"></div>
                <div class="layout" style="flex-direction: column; flex-basis: 70%; max-width: 70%;">
                    <h1 style="margin-top: 16px; margin-bottom: 0;">1:1 문의하기</h1>
                    <hr>
                    <div style="margin-bottom: 5px">제 목</div>
                    <input id="name" type="text" name="title"
                           style="margin-bottom: 20px; width: 100%; height: 5vh; padding-left: 10px;" placeholder="제 목">
                    <div class="layout">
                        <div style="margin-bottom: 5px;">문의 유형</div>
                    </div>
                    <div class="layout" style="margin-bottom: 20px;  width: 100%; border: 1px solid black;">
                        <div class="dropdown" style="width: 100%;">
                            <button style="width: inherit; background-color: white" class="btn dropdown-toggle"
                                    type="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                <input style="border: 0; width: 98%;" type="text" placeholder="문의 유형" name="category"
                                       id="category" readonly>
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
                    <div style="margin-bottom: 5px;">문의 내용</div>
                    <textarea id="body" name="body" rows="10"
                              style="padding: 10px 0 0 10px; margin-bottom: 20px; width: 100%;"
                              placeholder="문의 내용"></textarea>
                    <div style="width: 100%; margin-bottom: 50px;">
                        <input class="form-control" style="height: 38px;" type="file" multiple
                               name="files" accept="image/*">
                    </div>
                    <div style="margin-left: auto; margin-bottom: 30px;">
                        <input id="submitBtn" class="btn btn-primary" type="submit" value="작성하기" disabled>
                        <%--            <button onclick="location.href='/main'">취소하기</button>--%>
                        <input class="btn btn-danger" type="button" onclick="location.href='/main'" value="취소하기">
                    </div>
                </div>
                <div style="flex-basis: 15%; max-width: 15%;"></div>
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
