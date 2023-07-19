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
        @import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
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

        .card {
            height: 670px; /* 카드의 높이를 원하는 값으로 설정해주세요 */
            max-height: 53vh;
        }

        .card .card-img {
            object-fit: cover;
            height: 100%;
            width: 100%;
        }

        .col-md-2 {
            flex: 0 0 calc(16.666% - 5px);
            max-width: calc(16.666% - 5px);
            padding: 5px;
            margin-bottom: 10px;
        }

        .card-text {
            font-family: 'Jeju Gothic', sans-serif;
            font-size: 25px;
            fort-weight: bold;
            height: 35px;
            overflow: hidden;
        }

        .card-img {
            max-width: 30vh;
            max-height: 30vh;
            width: 30vh;
            height: 30vh;
        }

        .modal{
            position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
        }

        .modal_content{
            width:400px; height:200px;
            background:#fff; border-radius:10px;
            position:relative; top:50%; left:50%;
            margin-top:-100px; margin-left:-200px;
            text-align:center;
            box-sizing:border-box; padding:74px 0;
            line-height:23px; cursor:pointer;
        }
    </style>

</head>
<body>

<my:navBar></my:navBar>
<div class="container" style="margin-top: 86px;">
    <form action="/work" class="search-form" role="search">
        <input id="searchInput" value="${param.search}" name="search" class="form-control search-input"
               type="text" placeholder="Search" aria-label="search">
        <button id="search" class="btn btn-outline-success" type="submit">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </form>
    <div class="d-flex" style="margin-left: -165px;">
        <div class="dropdown" style="margin-right: 20px;">
            <button id="brandDropDown" class="btn btn-warning dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false" style="width: 300px; text-align: left;">
                모든 작품
            </button>
            <c:url value="/work" var="nikeBrandUrl">
                <c:if test="${not empty param.page}">
                    <c:param name="page" value="${param.page}"></c:param>
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}"></c:param>
                </c:if>
                <c:param name="brand" value="나이키"></c:param>
            </c:url>
            <c:url value="/work" var="adidasBrandUrl">
                <c:if test="${not empty param.page}">
                    <c:param name="page" value="${param.page}"></c:param>
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}"></c:param>
                </c:if>
                <c:param name="brand" value="아디다스"></c:param>
            </c:url>
            <c:url value="/work" var="vansBrandUrl">
                <c:if test="${not empty param.page}">
                    <c:param name="page" value="${param.page}"></c:param>
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}"></c:param>
                </c:if>
                <c:param name="brand" value="반스"></c:param>
            </c:url>
            <c:url value="/work" var="converseBrandUrl">
                <c:if test="${not empty param.page}">
                    <c:param name="page" value="${param.page}"></c:param>
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}"></c:param>
                </c:if>
                <c:param name="brand" value="컨버스"></c:param>
            </c:url>
            <c:url value="/work" var="allBrandUrl">
                <c:if test="${not empty param.page}">
                    <c:param name="page" value="${param.page}"></c:param>
                </c:if>
                <c:if test="${not empty param.search}">
                    <c:param name="search" value="${param.search}"></c:param>
                </c:if>
            </c:url>
            <ul class="dropdown-menu" style="width: 300px;">

                <li><a class="dropdown-item" href="${allBrandUrl}">모든 작품</a></li>
                <li><a class="dropdown-item ShoeBrand" href="${nikeBrandUrl}" id="nike">나이키</a></li>
                <li><a class="dropdown-item ShoeBrand" href="${adidasBrandUrl}" id="adidas">아디다스</a></li>
                <li><a class="dropdown-item ShoeBrand" href="${vansBrandUrl}" id="vans">반스</a></li>
                <li><a class="dropdown-item ShoeBrand" href="${converseBrandUrl}" id="converse">컨버스</a></li>
            </ul>
        </div>
        <div class="dropdown">
            <button class="btn btn-warning dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false" style="width: 300px; text-align: left;">
                정렬
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/work?name=최신순">최신순</a></li>
                <li><a class="dropdown-item" href="/work?order=likeCount&direction=DESC&name=좋아요순">좋아요순</a></li>
                <li><a class="dropdown-item" href="/work?order=view&direction=DESC&name=조회수순">조회수순</a></li>
                <li><a class="dropdown-item" href="/work?order=price&direction=DESC&name=높은가격순">높은가격순</a></li>
                <li><a class="dropdown-item" href="/work?order=price&direction=ASC&name=낮은가격순">낮은가격순</a></li>
            </ul>
        </div>
    </div>

    <br><br>


    <div id="workListData" class="row" style="display: flex; flex-wrap: wrap; margin-right: -275px; margin-left: -250px; justify-content: center;">
        <c:forEach items="${shoeBoardList}" var="board" varStatus="status">
            <c:choose>
                <c:when test="${brand == null || brand eq 'all' || board.brand eq brand}">
                    <div class="col-md-2" style="flex: 0 0 calc(16.666% - 5px); max-width: 30vh; max-height: 53vh; padding: 5px;">
                        <div class="card my-card" data-brand="${board.brand}" >
                            <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                                <div data-toggle="modal" data-target="#myModal" data-brand="${board.brand}" data-member-id="${board.memberId}">
                                    <img class="card-img" src="${board.imgUrlList[0]}" alt=""/>
                                    <div class="card-body">
                                        <p class="card-text">${board.title}</p>
                                        <div class="flex caption">
                                            🌄 ${board.nickName}
                                        </div>
                                        <div class="flex grey--text text--lighten-1">
                                            ―
                                        </div>
                                        <p class="card-price">${board.price}</p>

                                        <button>모달창</button>
                                        <div class="modal">
                                            <div class="modal_content"
                                                 title="클릭하면 창이 닫힙니다.">
                                                여기에 모달창 내용을 적어줍니다.<br>
                                                이미지여도 좋고 글이어도 좋습니다.
                                            </div>
                                        </div>

                                    </div>
                                    <div class="card-footer" style="margin-top: auto;">
                                        <small class="text-body-secondary">${board.likeCount}</small>
                                        <small class="text-body-secondary">${board.commentCount}</small>
                                    </div>
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
<script src="workModal.js"></script>
<script>
    document.querySelectorAll('.dropdown-menu a.dropdown-item.ShoeBrand').forEach(function (element) {
        element.addEventListener('click', function () {
            var brand = this.textContent;
            document.querySelector('#brandDropdown').textContent = brand;
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