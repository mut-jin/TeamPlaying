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

    </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="margin-top: 86px;">
    <div class="d-flex mb-4">
        <div class="dropdown" style="flex-grow: 0; flex-basis: 25%;">
            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                Dropdown button
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Action</a></li>
                <li><a class="dropdown-item" href="#">Another action</a></li>
                <li><a class="dropdown-item" href="#">Something else here</a></li>
            </ul>
        </div>
        <div style="flex-grow: 1;"></div>
        <input type="text" style="flex-grow: 0; flex-basis: 25%;">
    </div>
    <div id="todayListData">
        <c:forEach items="${boardList}" var="board">
            <div class="col-md-2">
                <div class="card my-card" style="width: 18rem; margin-bottom: 20px;">
                    <div onclick="openModal(${board.id})">
                        <div class="card-body">
                            <c:forEach items="${board.imgUrlList }" var="img" varStatus="status">
                                <c:if test="${status.count lt 2 }">
                                    <div>
                                        <img class="img-thumbnail" src="${img}" alt="" style="width: 285px; height: 260px !important;" />
                                    </div>
                                </c:if>
                            </c:forEach>
                            <h5 class="card-title d-flex justify-content-between">
                                <span>  ${board.nickName}</span>
                                <p style="font-size: medium;">${board.inserted}</p>
                            </h5>
                            <p class="card-text">${board.title}</p>
                            <p class="card-text">
                                <i class="fa-solid fa-heart"></i> ${board.likeCount } <i class="fa-regular fa-comments"></i> ${board.commentCount }
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="container-lg">
    <div class="row">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <!-- 이전 버튼 -->
                <c:if test="${pageInfo.currentPageNum gt 1 }">
                    <my:pageItem pageNum="${pageInfo.currentPageNum - 1 }">
                        <i class="fa-solid fa-angle-left"></i>
                    </my:pageItem>
                </c:if>

                <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
                    <my:pageItem pageNum="${pageNum }">
                        ${pageNum }
                    </my:pageItem>
                </c:forEach>

                <!-- 다음 버튼 -->
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                    <%-- 페이지 번호 : ${pageInfo.currentPageNum + 1 } --%>
                    <my:pageItem pageNum="${pageInfo.currentPageNum + 1 }">
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
</body>
</html>
