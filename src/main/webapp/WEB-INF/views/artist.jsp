<%--
  Created by IntelliJ IDEA.
  User: 윤보상
  Date: 2023-07-04
  Time: 오후 2:47
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
            flex-wrap: nowrap;
            min-width: 0;
            flex-direction: column;
        }

    </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="margin-top: 86px;">
    <div class="d-flex mb-4">
        <div class="dropdown" style="flex-grow: 0; flex-basis: 25%;">
            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                <input type="text" value="${name}" id="typeSelect" readonly>
            </button>
            <ul class="dropdown-menu" style="width: 228.92px;">
                <li><a class="dropdown-item" href="/artist?name=선택">선택</a></li>
                <li><a class="dropdown-item" href="/artist?order=subscribe&name=구독자 순">구독자 순</a></li>
                <li><a class="dropdown-item" href="/artist?order=totalWork&name=최다 작품 순">최다 작품 순 </a></li>
                <li><a class="dropdown-item" href="/artist?order=totalView&name=총조회수 순">총조회수 순</a></li>
            </ul>
        </div>
        <div style="flex-grow: 1;"></div>
        <form action="/artist" class="d-flex"
              style="flex-bottom: 25%; flex-grow: 0;" role="search">
            <input value="${param.search }" name="search" type="search" style="flex-basis: 75%; flex-grow: 0; border-width: 1px 0px 1px 1px;">
            <button style="background-color: white; border-width: 1px 1px 1px 0px; flex-basis: 25%; flex-grow: 0" type="submit"><i
                    class="fa-solid fa-magnifying-glass"></i></button>
        </form>
    </div>
    <c:forEach items="${boardList}" var="list">
        <div class="d-flex mb-4">
            <a href="/artist/${list.id}" class="card"
               style="width: 100%; padding: 24px 12px 24px; text-decoration: none; outline: ridge;">
                <div style="display: flex; flex-wrap: wrap; align-items: center!important;">
                    <div style="display: flex; flex-basis: 50%;">
                        <div style="flex-basis: 33.3%; max-width: 33.3%; text-align: center">
                            <img style="width: 110px; height: 110px; border-radius: 50%;"
                                 src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/runningMate/%EB%8B%AC%EB%A6%AC%EA%B8%B04.jpg"
                                 alt="">
                        </div>
                        <div class="layout" style="flex-basis: 66.7%; max-width: 66.7%">
                            <div style="margin-bottom: 8px; flex: 0 0 auto; font-weight: bolder">${list.nickName}</div>
                            <div style="margin-bottom: 8px; flex: 0 0 auto;">${list.address}</div>
                            <div style="margin-bottom: 8px; flex: 0 0 auto;"><i
                                    class="fa-regular fa-star"></i>${list.subCount}
                                <i class="fa-regular fa-eye"></i> ${list.totalView}
                            </div>
                        </div>
                    </div>
                    <div class="layout" style="flex-basis: 50%; flex-wrap: wrap;">
                        <c:forEach items="${list.shoeImgList}" var="img">
                            <div style="padding: 4px; flex-basis: 25%;">
                                <img style="width: 110px; height: 110px; border-radius: 4px;"
                                     src="${img}"
                                     alt="">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
</div>
<div class="container-lg">
    <div class="row">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <!-- 이전 버튼 -->
                <c:if test="${pageInfo.currentPageNum gt 1 }">
                    <my:pageItem pageUrl="/artist" pageNum="${pageInfo.currentPageNum - 1 }">
                        <i class="fa-solid fa-angle-left"></i>
                    </my:pageItem>
                </c:if>

                <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
                    <my:pageItem pageUrl="/artist" pageNum="${pageNum }">
                        ${pageNum }
                    </my:pageItem>
                </c:forEach>

                <!-- 다음 버튼 -->
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                    <%-- 페이지 번호 : ${pageInfo.currentPageNum + 1 } --%>
                    <my:pageItem pageUrl="/artist" pageNum="${pageInfo.currentPageNum + 1 }">
                        <i class="fa-solid fa-angle-right"></i>
                    </my:pageItem>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="../../js/cs.js"></script>
</body>
</html>
