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

        .search-form {
            width: 500px;
            display: flex;
            margin-left: 1000px;
        }

        .search-input {
            flex: 1;
        }

    </style>

</head>
<body>

<my:navBar></my:navBar>
<div class="container" style="margin-top: 86px;">
    <form action="/work" class="search-form" role="workSearch">
        <input id="searchInput" value="${param.workSearch}" name="workSearch" class="form-control search-input"
               type="text" placeholder="Search" aria-label="workSearch">
        <button id="search" class="btn btn-outline-success" type="submit">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </form>
    <div class="d-flex">
        <div class="dropdown" style="margin-right: 20px;">
            <button id="allWork" class="btn btn-warning dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false" style="width: 300px; text-align: left;">
                모든 작품
            </button>
            <ul class="dropdown-menu" style="width: 300px;">
                <li><a class="dropdown-item" href="#" onclick="filterByBrand('all')">모든 작품</a></li>
                <li><a class="dropdown-item ShoeBrand" href="#" id="nike" onclick="filterByBrand('나이키')">나이키</a></li>
                <li><a class="dropdown-item ShoeBrand" href="#" id="adidas" onclick="filterByBrand('아디다스')">아디다스</a></li>
                <li><a class="dropdown-item ShoeBrand" href="#" id="vans" onclick="filterByBrand('반스')">반스</a></li>
                <li><a class="dropdown-item ShoeBrand" href="#" id="converse" onclick="filterByBrand('컨버스')">컨버스</a></li>
            </ul>
        </div>
        <div class="dropdown">
            <button class="btn btn-warning dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false" style="width: 300px; text-align: left;">
                정렬
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">좋아요순</a></li>
                <li><a class="dropdown-item" href="#">조회수순</a></li>
                <li><a class="dropdown-item" href="#">낮은가격순</a></li>
                <li><a class="dropdown-item" href="#">높은가격순</a></li>
            </ul>
        </div>
    </div>

    <br><br>

    <%
        // 선택한 브랜드에 따라 brand 변수에 값을 할당합니다.
        String selectedBrand = ""; // 선택한 브랜드에 따라 값을 설정해주세요.

        if (selectedBrand.equals("나이키")) {
            pageContext.setAttribute("brand", "나이키");
        } else if (selectedBrand.equals("아디다스")) {
            pageContext.setAttribute("brand", "아디다스");
        } else if (selectedBrand.equals("반스")) {
            pageContext.setAttribute("brand", "반스");
        } else if (selectedBrand.equals("컨버스")) {
            pageContext.setAttribute("brand", "컨버스");
        } else {
            pageContext.setAttribute("brand", "all"); // 모든 브랜드를 선택한 경우
        }
    %>


    <div id="workListData" class="row" style="display: flex; flex-wrap: wrap;">
        <c:forEach items="${shoeBoardList}" var="board">
            <c:choose>
                <c:when test="${brand == null || brand eq 'all' || board.brand eq brand}">
                    <div class="col-md-2" style="flex: 0 0 calc(16.666% - 5px); max-width: calc(16.666% - 5px); padding: 5px;">
                        <div class="card my-card" data-brand="${board.brand}"
                             style="width: 250px; height: 100%; display: block;">
                            <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                                <div onclick="location.href='artist/${board.memberId}'">
                                    <div class="card-body">
                                        <h5 class="card-title d-flex justify-content-between">
                                            <span>🌄 ${board.nickName}</span>
                                            <span>${board.brand}</span>
                                            <p style="font-size: medium;">${board.inserted}</p>
                                        </h5>
                                        <p class="card-text">${board.title}</p>
                                    </div>
                                    <c:forEach items="${board.imgUrlList}" var="imgUrl" varStatus="status">
                                        <c:if test="${status.count < 6}">
                                            <div>
                                                <img class="img-thumbnail" src="${imgUrl}" alt=""
                                                     style="width: 100%; height: 100%;"/>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </c:forEach>
    </div>


</div>

<br>

<div class="container-lg">
    <div class="row">
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <!-- 이전 버튼 -->
                <c:if test="${pageInfo.currentPageNum gt 1 }">
                    <my:pageItem pageUrl="/work" pageNum="${pageInfo.currentPageNum - 1 }">
                        <i class="fa-solid fa-angle-left"></i>
                    </my:pageItem>
                </c:if>

                <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
                    <my:pageItem pageUrl="/work" pageNum="${pageNum }">
                        ${pageNum }
                    </my:pageItem>
                </c:forEach>

                <!-- 다음 버튼 -->
                <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                    <%-- 페이지 번호 : ${pageInfo.currentPageNum + 1 } --%>
                    <my:pageItem pageUrl="/work" pageNum="${pageInfo.currentPageNum + 1 }">
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
<script>
    // 드롭다운 메뉴 항목 선택 시 버튼 텍스트 변경
    document.querySelectorAll('.dropdown-menu a.dropdown-item').forEach(function (element) {
        element.addEventListener('click', function () {
            var dropdownButton = this.closest('.dropdown').querySelector('.dropdown-toggle');
            dropdownButton.textContent = this.textContent;
        });
    });
</script>

<script>
    function filterByBrand(brand) {
        $('.my-card').each(function () {
            var cardBrand = $(this).data('brand');
            if (brand === 'all' || cardBrand === brand) {
                $(this).parent().show();
            } else {
                $(this).parent().hide();
            }
        });
    }
</script>


<style>
    .btn.btn-warning.dropdown-toggle::after {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
    }
</style>


</body>
</html>
