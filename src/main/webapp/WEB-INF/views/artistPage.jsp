<%--
  Created by IntelliJ IDEA.
  User: 윤보상
  Date: 2023-07-07
  Time: 오후 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <style>
        *, :after, :before {
            background-repeat: no-repeat;
            box-sizing: inherit;
        }

        * {
            padding: 0;
            margin: 0;
        }

        .mb-20 {
            margin-bottom: 20px;
        }

        .mb-10 {
            margin-bottom: 10px;
        }

        .hrLine {
            border-color: rgba(0, 0, 0);
        }

        .box {
            box-shadow: 0 3px 1px -2px rgba(0, 0, 0, .2), 0 2px 2px 0 rgba(0, 0, 0, .14), 0 1px 5px 0 rgba(0, 0, 0, .12);
        }

        .mla {
            margin-left: auto;
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
            display: flex;
            justify-content: flex-end;
        }

        .profileText {
            font-size: 80%;
            height: 28px;
            min-width: 50px;
            margin-top: 4px;
        }

        .mySetting {
            position: relative;
            overflow: hidden;
            max-width: 100%;
            display: flex;
            z-index: 0;
            align-items: flex-end !important;
            width: 100%;
        }

        .icon {
            align-items: center;
            display: inline-flex;
            font-feature-settings: "liga";
            font-size: 24px;
            justify-content: center;
            letter-spacing: normal;
            line-height: 1;
            position: relative;
            text-indent: 0;
            vertical-align: middle;
            margin-right: 4px;
            font-size: 16px;
            color: white;
        }

    </style>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="margin-top: 74px;">
    <div class="layout" style="flex-wrap: nowrap">
        <div style="flex-basis: 25%; max-width: 25%; padding: 0 8px;">
            <div class="layout box" style="margin: 8px; flex-direction: column;">
                <div style="padding: 24px 16px;">
                    <div class="layout" style="align-items: center; flex-direction: column">
                        <div class="profile" style="height: 100px; width: 100px; margin-left: 18px;">
                            <c:if test="${memberInfo.profile eq 'basic'}">
                                <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/profile_basic.jpg"
                                     style="border-radius: 50%; width: inherit; height: inherit;" alt="">
                            </c:if>
                            <c:if test="${memberInfo.profile ne 'basic'}">
                                <img src="${bucketUrl}/Member/${memberInfo.id}/${memberInfo.profile}"
                                     style="border-radius: 50%; width: inherit; height: inherit;" alt="">
                            </c:if>
                        </div>
                        <div>${memberInfo.nickName}</div>
                        <div>${memberInfo.address}</div>
                        <c:if test="${memberInfo.userId ne myUserId && myUserId ne ''}">
                            <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                    data-bs-target="#exampleModal" onclick="minSet()">
                                커스텀 의뢰
                            </button>
                        </c:if>
                    </div>
                </div>
                <hr class="hrLine">
                <div style="padding: 24px 16px;">
                    <div class="layout" style="flex-direction: column">
                        <div>정보</div>
                        <div class="layout">
                            <div>등록 작품</div>
                            <div class="mla">${memberInfo.workCount}</div>
                        </div>
                        <div class="layout">
                            <div>작품 조회수</div>
                            <div class="mla">${memberInfo.totalView}</div>
                        </div>
                        <div class="layout">
                            <div>구독자</div>
                            <div class="mla">${memberInfo.subCount}</div>
                        </div>
                    </div>
                </div>
                <hr class="hrLine">
                <div style="padding: 24px 16px;">
                    <div class="layout" style="flex-direction: column">
                        <div>소개</div>
                        <div>${memberInfo.introduce}</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layout" style="flex-wrap: wrap; flex-basis: 75%; max-width: 75%;">
            <c:forEach items="${shoeBoardList}" var="board" varStatus="status">
                <div id="shoeBoard${board.id}"
                     style="flex-basis: 33.3333333333%; flex-grow: 0; max-width: 33.3333333333%; padding: 8px;"
                     data-bs-toggle="modal" data-bs-target="#shoeModal${board.id}" data-id="${board.id}"
                     onclick="view(this)">
                    <div class="mySetting shadow">
                        <div style="margin-bottom: 100%;"></div>
                        <img style="width: 15vh; position: absolute; top: 0; left: 0; width: 100%; height: 100%;
                                background-size: cover; z-index: -1;"
                             src="${bucketUrl }/shoeBoard/${board.id }/${board.imgUrlList[0]}"
                        />
                        <div style="max-width: 100%; width: 100%; background: linear-gradient(rgba(255, 255, 255, 0) 0%, rgba(0, 0, 0, 0.9));"
                             class="icon">
                            <div class="layout" style="flex-direction: column; padding: 12px;">
                                <div style="margin-bottom: 8px; max-width: 100%; font-weight: 700; flex: 1 1 auto;">
                                    <div style="white-space: nowrap!important; overflow: hidden!important; text-overflow: ellipsis!important;">
                                            ${board.title}
                                    </div>
                                </div>
                                <div style="max-width: 100%; flex: 1 1 auto; ">
                                    <div class="layout" style="flex-wrap: wrap;">
                                        <div style="flex: 1 1 auto; max-width: 100%;">
                                                ${board.price}
                                        </div>
                                        <div style="flex-grow: 1"></div>
                                        <div style="display: flex">
                                            <i class="fa-regular fa-thumbs-up icon"></i>
                                            <span style="margin-right: 8px;">${board.likeCount}</span>
                                            <i class="fa-regular fa-comment icon"></i>
                                            <span style="margin-right: 8px;">${board.commentCount}</span>
                                            <i class="fa-regular fa-eye icon"></i>
                                            <span>${board.view}</span>
                                        </div>
                                    </div>
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
                                        <c:if test="${myUserId ne ''}">
                                            <button type="button" class="sendCommentBtn" value="${board.id}"
                                                    style="color: white; background-color: #9e9e9e; border: 0; margin-left: auto; border-radius: 28px; height: 36px; min-width: 64px; padding: 0 16px;">
                                                댓글 달기
                                            </button>
                                        </c:if>
                                    </div>
                                    <ul class="list-group" id="commentListContainer${board.id}"
                                        style="border-top: 1px solid black; border-radius: 0;">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="myPageOption">
                            <div class="layout modal-content"
                                 style="flex-direction: column; background-color: white;">
                                <div style="margin: 16px 12px 0px; flex-direction: column;" class="layout">
                                    <h1 id="boardTitle${board.id}">${board.title}</h1>
                                    <c:if test="${myUserId eq memberInfo.userId || myMemberType eq 'admin'}">
                                        <div>
                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                                    data-bs-target="#shoeBoardRemoveModal${board.id}">삭제
                                            </button>
                                        </div>
                                    </c:if>
                                </div>
                                <hr style="margin: 0.7rem 0;">
                                <div class="layout"
                                     style="min-height: 48px; padding: 0 16px;position: relative; align-items: center;">
                                    <div class="profile">
                                    <c:if test="${board.profile eq 'basic'}">
                                        <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/profile_basic.jpg"
                                             style="border-radius: 50%; width: inherit; height: inherit;" alt="">
                                    </c:if>
                                    <c:if test="${board.profile ne 'basic'}">
                                        <img src="${bucketUrl}/Member/${board.memberId}/${board.profile}"
                                             style="border-radius: 50%; width: inherit; height: inherit;" alt="">
                                    </c:if>
                                    </div>
                                    <div class="layout" style="flex-direction: column; padding: 12px 0;">
                                        <div style="font-weight: 700; margin-bottom: 2px; font-size: 90%; line-height: 1.2;">${board.nickName}</div>
                                        <div style="font-size: 90%; line-height: 1.2;">${board.address}</div>
                                    </div>
                                    <input type="hidden" id="boardBrand${board.id}" value="${board.brand}">
                                    <input type="hidden" id="boardMemberId${board.id}" value="${board.memberId}">
                                    <div class="profileBtn" style="width: 7vh;">
                                        <a href="/artist/${board.memberId}" class="profileText"
                                           style="text-decoration: none; color: black;">
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
                <!-- shoeBoardRemoveModal -->
                <div class="modal fade" id="shoeBoardRemoveModal${board.id}" tabindex="-1"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                해당 게시물을 삭제하시겠습니까?
                            </div>
                            <div class="modal-footer">
                                <form action="/shoeDelete">
                                    <input type="hidden" value="artist/${board.id}" name="url">
                                    <input type="hidden" value="${board.id}" name="boardId">
                                    <button style="margin-right: 1px;" type="submit" class="btn btn-outline-danger">삭제</button>
                                </form>
                                <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <div class="row" style="width: 100%;">
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <!-- 이전 버튼 -->
                        <c:if test="${pageInfo.currentPageNum gt 1 }">
                            <my:pageItem pageUrl="/artist/${memberInfo.id}" pageNum="${pageInfo.currentPageNum - 1 }">
                                <i style="padding-top: inherit;" class="fa-solid fa-angle-left"></i>
                            </my:pageItem>
                        </c:if>

                        <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
                            <my:pageItem pageUrl="/artist/${memberInfo.id}" pageNum="${pageNum }">
                                ${pageNum }
                            </my:pageItem>
                        </c:forEach>

                        <!-- 다음 버튼 -->
                        <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                            <%-- 페이지 번호 : ${pageInfo.currentPageNum + 1 } --%>
                            <my:pageItem pageUrl="/artist/${memberInfo.id}" pageNum="${pageInfo.currentPageNum + 1 }">
                                <i style="padding-top: inherit;" class="fa-solid fa-angle-right"></i>
                            </my:pageItem>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <%--            <form action="">--%>
            <div class="modal-header">
                <h1 style="font-weight: bolder;" class="modal-title fs-5" id="exampleModalLabel">커스텀 작품의뢰</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="layout" style="flex-direction: column">
                    <div class="mb-10">제목을 입력해주세요.</div>
                    <input placeholder="제목을 입력해주세요." type="text" id="title" style="padding: 25px 10px; height: 40px;"
                           name="title"
                           class="mb-20">
                    <div class="mb-10">커스텀할 신발을 입력해주세요.</div>
                    <input placeholder="브랜드명을 입력해주세요." type="text" id="brand" style="padding: 25px 10px; height: 40px;"
                           name="brand"
                           class="mb-20">
                    <input placeholder="신발이름을 입력해주세요." type="text" id="shoeName"
                           style="padding: 25px 10px; height: 40px;" name="shoeName"
                           class="mb-20">
                    <div class="mb-10">요청 사항을 적어주세요.</div>
                    <textarea style="padding: 10px;" placeholder="요청 사항을 입력해주세요." name="body" id="body" class="mb-20"
                              rows="7"></textarea>
                    <div class="mb-10">참고할 이미지가 있다면 등록해주세요.</div>
                    <input class="form-control mb-20" style="height: 38px;" type="file" multiple
                           name="files" id="files" accept="image/*">
                    <div class="mb-10">희망 가격을 입력해주세요</div>
                    <input placeholder="희망 가격을 입력해주세요" type="text" id="price" style="padding: 25px 10px; height: 40px;"
                           name="price"
                           class="mb-20">
                    <div class="mb-10">희망 제작 기간을 입력해주세요</div>
                    <input placeholder="희망 제작 기간을 입력해주세요." type="date" id="makeTime" name="makeTime"
                           style="padding: 25px 10px; height: 40px;">
                    <input type="hidden" id="artistUserId" value="${memberInfo.userId}">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="customRequestBtn" disabled>전송</button>
            </div>
            <%--            </form>--%>
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
                        <div id="requestTitleView" style="margin-bottom: 10px;"></div>
                        <%--                        <div>희망 수령일</div>--%>
                        <label style="margin-bottom: 5px;" for="requestMakeTime">희망 수령일</label>
                        <input style="padding: 10px; margin-bottom: 20px;" type="date" name="makeTime"
                               id="requestMakeTime">
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

<sec:authorize access="isAuthenticated()">
    <my:chatBtn></my:chatBtn>
    <script src="/js/chat.js" charset="UTF-8"></script>
</sec:authorize>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/modal.js"></script>
</body>
</html>
