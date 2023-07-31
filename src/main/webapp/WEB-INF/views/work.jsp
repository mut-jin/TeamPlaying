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
            max-height: 56vh;
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
            margin-bottom: 40px;
        }

        .card-text {
            font-family: 'Jeju Gothic', sans-serif;
            font-size: 17.5px;
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

        /*.modal{*/
        /*    position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;*/
        /*}*/

        .shadow {
            box-shadow: 0 3px 30px 0 rgba(0, 0, 0, .16) !important;
        }


        /*.card-img {*/
        /*    max-width: 28.75vh;*/
        /*    max-height: 30vh;*/
        /*    width: 28.75vh;*/
        /*    height: 30vh;*/
        /*}*/

        .layout {
            display: flex;
            flex: 1 1 auto;
            flex-wrap: nowrap;
            min-width: 0;
        }

        .myPageOption {
            flex-basis: 33.33333%;
            max-width: 33.33333%;
            /*margin-right: 12px;*/
            border-radius: 4px;
            margin: 0 5px;
            overflow: hidden;
        }

        .myInfo {
            flex-basis: 66.666666%;
            max-width: 66.666666%;
            margin: 0 5px;
            border-radius: 4px;
            /*margin-left: 12px;*/
            /*margin-bottom: 2rem;*/
        }

        .modal-body2 {
            flex-direction: column;
            padding: 0;
            border-radius: inherit;
            overflow: hidden;
            max-width: 100%;
            width: 100%;
        }

        .profile {
            height: 50px;
            min-width: 50px;
            width: 50px;
            margin: 8px 16px 8px 0;
        }

        .profileBtn {
            background-color: white;
            border: 1px solid black;
            border-radius: 24px;
            height: 28px;
            margin: 8px 0 8px 16px;
        }

        .profileText {
            font-size: 80%;
            height: 28px;
            min-width: 50px;
            padding: 0 12.4444444444px;
            margin-top: 4px;
        }

    </style>

</head>
<body>

<my:navBar></my:navBar>

<div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
    <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"></div>
            <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

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
                    <div id="shoeBoard${board.id}" class="shadow" style="flex: 0 0 calc(16.666% - 5px); max-width: 30vh; max-height: 58vh; padding: 5px;"
                         onclick="view(this)"
                         data-bs-toggle="modal" data-bs-target="#shoeModal${board.id}" data-id="${board.id}">
                        <div class="card my-card" data-brand="${board.brand}">
                            <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                                <div data-toggle="modal" data-target="#myModal" data-brand="${board.brand}" data-member-id="${board.memberId}">
                                    <img class="card-img" src="${bucketUrl }/shoeBoard/${board.id }/${board.imgUrlList[0]}" alt=""/>
                                    <div class="card-body">
                                        <p class="card-text">${board.title}</p>
                                        <div class="flex caption">
                                            👟 ${board.nickName}
                                        </div>
                                        <div class="flex grey--text text--lighten-1">
                                            ―
                                        </div>
                                        <p class="card-price">₩${board.price}</p>
                                    </div>
                                    <div class="card-footer" style="margin-top: auto;">
                                        <small class="text-body-secondary"><i class="fa-regular fa-thumbs-up"></i> ${board.likeCount}</small>
                                        <span class="mx-2"></span>
                                        <small class="text-body-secondary"><i class="fa-regular fa-comment"></i> ${board.commentCount}</small>
                                        <span class="mx-2"></span>
                                        <small class="text-body-secondary float-right"><i class="fa-regular fa-eye"></i> ${board.view}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="shoeModal${board.id}" tabindex="-1" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog layout" style="max-width: 68%; margin-top: 5vh;">
                            <div class="modal-content myInfo">
                                <div class="modal-body layout modal-body2">
                                    <div style="margin-bottom: 40px; max-width: 100%; width: 100%;">
                                        <c:forEach items="${board.imgUrlList}" var="file">
                                            <img style="width: inherit; max-width: inherit"
                                                 src="${bucketUrl }/shoeBoard/${board.id }/${file}" alt="">
                                        </c:forEach>
                                    </div>
                                    <div style="margin: 0 20px 40px;">${board.body}</div>
                                    <div class="layout" style="margin-bottom: 12px; justify-content: center;">
                                        <span id="view${board.id}">${board.view} Views</span>
                                        &nbsp&nbsp&nbsp
                                        <span id="like${board.id}">${board.likeCount} Likes</span>
                                        &nbsp&nbsp&nbsp
                                        <span id="comment${board.id}">${board.commentCount} Comments</span>
                                    </div>
                                    <div class="layout" style="flex-direction: column; margin: 20px 20px 0">
                                        <div class="layout">
                                            <div>
                                                <div style="background-color: #9e9e9e; border-radius: 50%; text-align: center; min-width: 48px; width: 48px; height: 48px; overflow: hidden;">
                                                    <i style="color: white; margin-top: 15px; width: inherit; height:inherit;"
                                                       class="fa-regular fa-user"></i>
                                                </div>
                                            </div>
                                            <div style="padding-left: 12px; width: 100%;">
                                            <textarea name="" id="shoeComment${board.id}"
                                                      style="min-height: 130px; max-width: 100%; width: 100%; line-height: 1.75rem; padding-right: 12px;"
                                                      placeholder="작품에 대한 댓글을 남겨주세요."></textarea>
                                            </div>
                                        </div>
                                        <div class="layout" style="margin: 15px 0 10px;">
                                            <button type="button" class="sendCommentBtn" value="${board.id}"
                                                    style="color: white; background-color: #9e9e9e; border: 0; margin-left: auto; border-radius: 28px; height: 36px; min-width: 64px; padding: 0 16px;">
                                                댓글 달기
                                            </button>
                                        </div>
                                        <ul class="list-group" id="commentListContainer${board.id}">
                                        </ul>
                                    </div>

                                </div>
                            </div>
                            <div class="myPageOption">
                                <div class="layout modal-content" style="flex-direction: column; background-color: white;">
                                    <div style="margin: 16px 12px 0px;">
                                        <h1 id="boardTitle${board.id}">${board.title}</h1>
                                    </div>
                                    <hr style="margin: 0.7rem 0;">
                                    <div class="layout"
                                         style="min-height: 48px; padding: 0 16px;position: relative; align-items: center;">
                                        <div class="profile">
                                            <img src="${board.profile}" alt="" style="width: inherit; height: inherit;">
                                        </div>
                                        <div class="layout" style="flex-direction: column; padding: 12px 0;">
                                            <div style="font-weight: 700; margin-bottom: 2px; font-size: 90%; line-height: 1.2;">${board.nickName}</div>
                                            <div style="font-size: 90%; line-height: 1.2;">${board.address}</div>
                                        </div>
                                        <input type="hidden" id="boardBrand${board.id}" value="${board.brand}">
                                        <input type="hidden" id="boardMemberId${board.id}" value="${board.memberId}">
                                        <div class="profileBtn" style="width: 7vh;">
                                            <a href="/artistPage/${board.memberId}" class="profileText">
                                                프로필
                                            </a>
                                        </div>
                                    </div>
                                    <hr style="margin: 0.7rem 0;">
                                    <div class="layout" style="flex-direction: column; margin: 12px;">
                                        <div class="layout">
                                            <div style="font-weight: 700; margin-right: auto;">사용신발</div>
                                            <div id="boardShoeName${board.id}"
                                                 style="margin-left: auto;">${board.shoeName}</div>
                                        </div>
                                        <div class="layout">
                                            <div style="font-weight: 700; margin-right: auto;">작업기간</div>
                                            <div style="margin-left: auto;">${board.makeTime}</div>
                                        </div>
                                        <div class="layout">
                                            <div style="font-weight: 700; margin-right: auto;">작업비용</div>
                                            <div id="boardPrice${board.id}" style="margin-left: auto;">${board.price}</div>
                                        </div>
                                    </div>
                                    <div class="layout" style="overflow: hidden; ">
                                        <button value="${board.id}" id="likeBtn${board.id}"
                                                style="display: flex; justify-content: center; align-items: center; height: 44px; border-radius: 0; border: 0; margin: 0; background-color: #9e9e9e; color: white;"
                                                class="myPageOption likeIcon"><i style="margin-right: 5px; font-size: 150%;"
                                                                                 class="fa-regular fa-thumbs-up"></i> ${board.likeCount}
                                        </button>
                                        <button data-bs-toggle="modal" data-bs-target="#requestModal"
                                                style="height: 44px; border-radius: 0; border: 0; margin: 0; background-color: orange; color: white"
                                                onclick="minSet()"
                                                class="myInfo requestBtn" value="${board.title}">커스텀 작업 의뢰하기
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </c:forEach>
    </div>

    <!-- 댓글 삭제 Modal -->
    <div class="modal fade" id="deleteWorkConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel2"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">게시글 삭제 확인</h1>
                    <button class="btn-close cancel" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">삭제 하시겠습니까?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary cancel" type="button" data-bs-dismiss="modal">닫기</button>
                    <button id="deleteWorkModalButton" data-bs-dismiss="modal" type="submit" class="btn btn-danger">삭제
                    </button>
                </div>
            </div>
        </div>
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

<c:forEach items="${shoeBoardList}" var="board" varStatus="status">
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dism    iss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<!-- 댓글 삭제 Modal -->
<div class="modal fade" id="deleteCommentConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel2"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">댓글 삭제 확인</h1>
                <button class="btn-close cancel" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">삭제 하시겠습니까?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary cancel" type="button" data-bs-dismiss="modal">닫기</button>
                <button id="deleteCommentModalButton" data-bs-dismiss="modal" type="submit" class="btn btn-danger">삭제
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 댓글 수정 모달 -->
<div class="modal fade" id="commentUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel3" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">댓글 수정</h1>
                <button type="button" class="btn-close cancel" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="updateCommentContainer">
                    <input type="hidden" id="commentUpdateIdInput"/>
                    <textarea class="form-control" id="commentUpdateTextArea"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary cancel" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="updateCommentBtn" data-bs-dismiss="modal">수정</button>
            </div>
        </div>
    </div>
</div>

<!-- requestModal -->
<div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="requestModalLabel">커스텀 작업 의뢰하기</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/addRequest" method="post">
                <div class="modal-body">
                    <div class="layout" style="flex-direction: column;">
                        <div id="requestTitleView"></div>
                        <div>희망 수령일</div>
                        <input type="date" name="makeTime" id="requestMakeTime">
                        <div>추가 요청 사항을 알려주세요.</div>
                        <textarea name="body" id="" rows="7" placeholder="추가 요청 사항"></textarea>
                        <input type="hidden" name="shoeName" id="requestShoeName">
                        <input type="hidden" name="price" id="requestPrice">
                        <input type="hidden" name="brand" id="requestBrand">
                        <input type="hidden" name="memberId" id="requestMemberId">
                        <input type="hidden" name="title" id="requestTitle">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">의뢰하기</button>
                </div>
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
<script src="/js/modal.js"></script>
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