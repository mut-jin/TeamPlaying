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
        @import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

        *, :after, :before {
            background-repeat: no-repeat;
            box-sizing: inherit;
        }

        * {
            padding: 0;
            margin: 0;
        }

        .shadow {
            box-shadow: 0 3px 30px 0 rgba(0, 0, 0, .16) !important;
        }

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
            overflow: hidden;
            display: flex;
        }

        .profileText {
            font-size: 80%;
            height: 28px;
            padding-left: 22%;
            margin-top: 4px;
            text-decoration: none;
            color: black;
        }

        .dropdown-item {
            width: inherit;
        }


    </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="margin-top: 86px;">
    <div class="d-flex" style="margin-bottom: 16px;">
        <div class="dropdown" style="flex-grow: 0; flex-basis: 25%; max-width: 25%; font-family: 'Jeju Gothic', sans-serif;">
            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false" style="background-color: black;">
                <input type="text" value="${name}" id="typeSelect" readonly style="background-color: inherit; border: 0; color: white;">
            </button>
            <ul class="dropdown-menu" style="width: 220px; font-family: 'Jeju Gothic', sans-serif;">
                <li><a class="dropdown-item" href="/artist?name=선택">선택</a></li>
                <li><a class="dropdown-item" href="/artist?order=subscribe&name=구독자 순">구독자 순</a></li>
                <li><a class="dropdown-item" href="/artist?order=totalWork&name=최다 작품 순">최다 작품 순 </a></li>
                <li><a class="dropdown-item" href="/artist?order=totalView&name=총조회수 순">총조회수 순</a></li>
            </ul>
        </div>
        <div style="flex-grow: 1;"></div>
        <form action="/artist" class="d-flex"
              style="flex-bottom: 25%; flex-grow: 0;" role="search">
            <input value="${param.search }" name="search" type="search" style="flex-basis: 75%; max-width: 75%; flex-grow: 0; border-width: 1px 0px 1px 1px;">
            <button style="background-color: white; border-width: 1px 1px 1px 0px; flex-basis: 25%; max-width: 25%; flex-grow: 0" type="submit"><i
                    class="fa-solid fa-magnifying-glass"></i></button>
        </form>
    </div>
    <c:forEach items="${boardList}" var="list">
        <div class="d-flex" style="margin-bottom: 15px;">
            <div class="card shadow"
               style="width: 100%; padding: 24px 12px 24px; text-decoration: none;">
                <div style="display: flex; flex-wrap: wrap; align-items: center!important;">
                    <a href="/artist/${list.id}" style="text-decoration: none; color: black; display: flex; flex-basis: 50%;">
                        <div style="flex-basis: 33.3%; max-width: 33.3%; text-align: center">
                            <img style="width: 110px; height: 110px; border-radius: 50%;"
                                 src="${list.profile}"
                                 alt="">
                        </div>
                        <div class="layout" style="justify-content: center; flex-direction: column; flex-basis: 66.7%; max-width: 66.7%">
                            <div style="margin-bottom: 8px; flex: 0 0 auto; font-weight: bolder">${list.nickName}</div>
                            <div style="margin-bottom: 8px; flex: 0 0 auto;">${list.address}</div>
                            <div style="margin-bottom: 8px; flex: 0 0 auto;"><i
                                    class="fa-regular fa-star"></i>${list.subCount}
                                <i class="fa-regular fa-eye"></i> ${list.totalView}
                            </div>
                        </div>
                    </a>
                    <div class="layout" style="flex-basis: 50%; max-width: 50%; align-items: center; height: 100%;">
                        <c:forEach items="${list.shoeImgList}" var="img" varStatus="status">
                            <c:if test="${status.index < 4}">
                                <div style="width: 15vh; height: 15vh; overflow:hidden; padding: 4px; flex-basis: 25%; max-width: 25%;" class="child" onclick="view(this)"
                                     data-bs-toggle="modal" data-bs-target="#shoeModal${list.boardIdList[status.index]}" data-id="${list.boardIdList[status.index]}">
                                    <img style="width: 15vh; border-radius: 4px;"
                                         src="${img}"
                                         alt="">
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
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

<c:forEach items="${shoeBoardList}" var="board">
    <!-- Modal -->
    <div class="modal fade" id="shoeModal${board.id}" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog layout" style="max-width: 68%; margin-top: 5vh;">
            <div class="modal-content myInfo">
                <div class="modal-body layout modal-body2" style="padding: 0;">
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
                        <ul class="list-group" id="commentListContainer${board.id}" style="border-top: 1px solid black; border-radius: 0;" >
                        </ul>
                    </div>

                </div>
            </div>
            <div class="myPageOption">
                <div class="layout modal-content"
                     style="flex-direction: column; background-color: white;">
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
                            <a href="/artist/${board.memberId}" class="profileText">
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
                            <div id="boardPrice${board.id}"
                                 style="margin-left: auto;">${board.price}</div>
                        </div>
                    </div>
                    <div class="layout" style="overflow: hidden; ">
                        <button value="${board.id}" id="likeBtn${board.id}"
                                style="display: flex; justify-content: center; align-items: center; height: 44px; border-radius: 0; border: 0; margin: 0; background-color: #9e9e9e; color: white;"
                                class="myPageOption likeIcon"><i
                                style="margin-right: 5px; font-size: 150%;"
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
</c:forEach>

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
                        <div id="requestTitleView" style="margin-bottom: 10px;"></div>
                        <%--                        <div>희망 수령일</div>--%>
                        <label style="margin-bottom: 5px;" for="requestMakeTime">희망 수령일</label>
                        <input style="padding: 10px; margin-bottom: 20px;" type="date" name="makeTime" id="requestMakeTime">
                        <div style="margin-bottom: 5px;">추가 요청 사항을 알려주세요.</div>
                        <textarea style="padding: 10px;" name="body" id="" rows="7" placeholder="추가 요청 사항"></textarea>
                        <input type="hidden" name="shoeName" id="requestShoeName">
                        <input type="hidden" name="price" id="requestPrice">
                        <input type="hidden" name="brand" id="requestBrand">
                        <input type="hidden" name="memberId" id="requestMemberId">
                        <input type="hidden" name="title" id="requestTitle">
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="requestSubmitBtn" type="submit" class="btn btn-primary" disabled>의뢰하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/modal.js"></script>
</body>
</html>
