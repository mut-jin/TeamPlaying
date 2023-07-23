<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>

<style>
    @import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

    .custom-pa-4 {
        padding-left: 80px;
        padding-right: 80px;
        padding-top: 20px;
        padding-bottom: 20px;
    }

    .headline {
        display: flex;
        font-size: 25px;
        font-weight: bold;
    }

    /*.card {*/
    /*    height: 670px; !* 카드의 높이를 원하는 값으로 설정해주세요 *!*/
    /*    max-height: 53vh;*/
    /*}*/

    /*.card .card-img {*/
    /*    object-fit: cover;*/
    /*    height: 100%;*/
    /*    width: 100%;*/
    /*}*/

    /*.col-md-2 {*/
    /*    flex: 0 0 calc(16.666% - 5px);*/
    /*    max-width: calc(16.666% - 5px);*/
    /*    padding: 5px;*/
    /*    margin-bottom: 10px;*/
    /*}*/


    .card-img {
        max-width: 28.75vh;
        max-height: 30vh;
        width: 28.75vh;
        height: 30vh;
    }

    .card-text {
        font-family: 'Jeju Gothic', sans-serif;
        font-size: 22px;
        fort-weight: bold;
        height: 35px;
        overflow: hidden;
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

    .profileBtn{
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


<my:navBar></my:navBar>
<br/>


<div class="flex" style="background-color: black; height: 650px;">
    <div class="layout" style="flex-direction: column">
        <div class="flex text-center" style="margin: 30px 0px;">
            <br><br>
            <h1 class="white--text font-weight-black display-4"
                style="color: white; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8); font-size: 90px; font-weight: 800;">
                꿈꾸던 디자인을
                <br>
                현실로 만들어보세요.
            </h1>
        </div>
        <div class="flex text-center" style="margin-bottom: 30px;">
            <a href="/work">
                <button type="button" class="btn btn-warning btn-lg" style="font-weight: bolder">작품 보러가기</button>
            </a>
        </div>
        <br>
        <div class="flex px-3" style="display: flex; justify-content: center; align-items: center;">
            <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/work/work1.jpeg" height="210px"
                 width="210px" style="margin-right: 20px;">
            <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/work/work2.jpeg" height="210px"
                 width="210px" style="margin-right: 20px;">
            <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/work/work3.jpeg" height="210px"
                 width="210px" style="margin-right: 20px;">
            <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/work/work4.jpg" height="210px"
                 width="210px">
        </div>
    </div>
</div>
<br><br>
<div class="flex px-3" style="margin-bottom: 80px; display: flex; justify-content: center; align-items: center">
    <div class="custom-pa-4 v-card v-sheet theme--light" style="box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);">
        <div class="layout wrap align-center">
            <div class="flex xs12 md4 lg5 order-md-2 text-center">
                <div style="background-color: white; display: flex; flex-direction: column; align-items: center;">
                    <span style="font-size: 25px; margin-bottom: 10px;">당신의 신발을 변신시킬 아티스트들을 구경해보세요.</span>
                    <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/work/work5.png"
                         style="max-width: 100%; max-height: 100px;">
                    <a href="/artist">
                        <button type="button" class="btn btn-warning" style="margin-top: 15px;">아티스트 보러가기</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="layout column">
    <div class="flex headline" style="margin-left: 300px;">
        Zero-One 신발 만들기
    </div>
    <br>
    <div class="flex px-3" style="margin-bottom: 80px; display: flex; justify-content: center; align-items: center">
        <a href="/canvas1">
            <img src="https://bucket0503-mason.s3.ap-northeast-2.amazonaws.com/TeamPlay/work/work8.jpg">
        </a>
    </div>
</div>

<div class="flex headline" style="margin-left: 130px;">
    나이키
</div>
<br>
<div id="workListData" class="row"
     style="display: flex; flex-wrap: wrap; margin-right: -275px; margin-left: -250px; justify-content: center;">
    <c:forEach items="${nike}" var="board" varStatus="status">
        <c:choose>
            <c:when test="${brand == null || brand eq 'all' || board.brand eq brand}">
                <div class="col-md-2"
                     style="flex: 0 0 calc(16.666% - 5px); max-width: 30vh; max-height: 53vh; padding: 5px;"
                     data-bs-toggle="modal" data-bs-target="#shoeModal${board.id}">
                    <div class="card my-card" data-brand="${board.brand}">
                        <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                            <div data-toggle="modal" data-target="#myModal" data-brand="${board.brand}"
                                 data-member-id="${board.memberId}">
                                <img class="card-img" src="${board.fileName}" alt=""/>
                                <div class="card-body">
                                    <p class="card-text">${board.title}</p>
                                    <div class="flex caption">
                                        🌄 ${board.nickName}
                                    </div>
                                    <div class="flex grey--text text--lighten-1">
                                        ―
                                    </div>
                                    <p class="card-price">${board.price}</p>

                                </div>
                                <div class="card-footer" style="margin-top: auto;">
                                    <small class="text-body-secondary">${board.likeCount}</small>
                                    <small class="text-body-secondary">${board.commentCount}</small>
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
                                        <img style="width: inherit; max-width: inherit" src="${bucketUrl }/shoeBoard/${board.id }/${file}" alt="">
                                    </c:forEach>
                                </div>
                                <div style="margin: 0 20px 40px;">${board.body}</div>
                                <div class="layout" style="margin-bottom: 12px; justify-content: center;">
                                    <span>${board.view} Views</span>
                                    &nbsp&nbsp&nbsp
                                    <span>${board.likeCount} Likes</span>
                                    &nbsp&nbsp&nbsp
                                    <span>${board.commentCount} Comments</span>
                                </div>
                                <div class="layout" style="flex-direction: column; margin: 20px 20px 0">
                                    <div class="layout">
                                        <div>
                                            <div style="background-color: #9e9e9e; border-radius: 50%; text-align: center; min-width: 48px; width: 48px; height: 48px; overflow: hidden;">
                                                <i style="color: white; margin-top: 15px; width: inherit; height:inherit;" class="fa-regular fa-user"></i>
                                            </div>
                                        </div>
                                        <div style="padding-left: 12px; width: 100%;">
                                            <textarea name="" id="shoeComment${board.id}" style="min-height: 130px; max-width: 100%; width: 100%; line-height: 1.75rem; padding-right: 12px;" placeholder="작품에 대한 댓글을 남겨주세요."></textarea>
                                        </div>
                                    </div>
                                    <div class="layout" style="margin: 15px 0 10px;">
                                        <button type="button" class="commentBtn" value="${board.id}" style="color: white; background-color: #9e9e9e; border: 0; margin-left: auto; border-radius: 28px; height: 36px; min-width: 64px; padding: 0 16px;">댓글 달기</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="myPageOption">
                            <div class="layout modal-content" style="flex-direction: column; background-color: white;">
                                <div style="margin: 16px 12px 0px;">
                                    <h1>${board.title}</h1>
                                </div>
                                <hr style="margin: 0.7rem 0;">
                                <div class="layout" style="min-height: 48px; padding: 0 16px;position: relative;">
                                    <div class="profile">
                                        <img src="${board.profile}" alt="" style="width: inherit; height: inherit;">
                                    </div>
                                    <div class="layout" style="flex-direction: column; padding: 12px 0;">
                                        <div style="font-weight: 700; margin-bottom: 2px; font-size: 90%; line-height: 1.2;">${board.nickName}</div>
                                        <div style="font-size: 90%; line-height: 1.2;">${board.address}</div>
                                    </div>
                                    <div class="profileBtn">
                                        <a href="/artistPage/${board.memberId}" class="profileText">
                                            프로필
                                        </a>
                                    </div>
                                </div>
                                <hr style="margin: 0.7rem 0;">
                                <div class="layout" style="flex-direction: column; margin: 12px;">
                                    <div class="layout">
                                        <div style="font-weight: 700; margin-right: auto;">사용신발</div>
                                        <div style="margin-left: auto;">${board.shoeName}</div>
                                    </div>
                                    <div class="layout">
                                        <div style="font-weight: 700; margin-right: auto;">작업기간</div>
                                        <div style="margin-left: auto;">${board.makeTime}</div>
                                    </div>
                                    <div class="layout">
                                        <div style="font-weight: 700; margin-right: auto;">작업비용</div>
                                        <div style="margin-left: auto;">${board.price}</div>
                                    </div>
                                </div>
                                <div class="layout" style="overflow: hidden;">
                                    <button style="height: 44px; border-radius: 0; border: 0; margin: 0; color: white;" class="myPageOption"><i class="fa-regular fa-thumbs-up"></i></button>
                                    <button style="height: 44px; border-radius: 0; border: 0; margin: 0; background-color: orange; color: white" class="myInfo">커스텀 작업 의뢰하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>
    </c:forEach>
</div>
<br><br><br>
<div class="flex headline" style="margin-left: 130px;">
    아디다스
</div>
<br>
<div id="workListData" class="row"
     style="display: flex; flex-wrap: wrap; margin-right: -275px; margin-left: -250px; justify-content: center;">
    <c:forEach items="${adidas}" var="board" varStatus="status">
        <c:choose>
            <c:when test="${brand == null || brand eq 'all' || board.brand eq brand}">
                <div class="col-md-2"
                     style="flex: 0 0 calc(16.666% - 5px); max-width: 30vh; max-height: 53vh; padding: 5px;">
                    <div class="card my-card" data-brand="${board.brand}">
                        <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                            <div data-toggle="modal" data-target="#myModal" data-brand="${board.brand}"
                                 data-member-id="${board.memberId}">
                                <img class="card-img" src="${board.fileName}" alt=""/>
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
<br><br><br>
<div class="flex headline" style="margin-left: 130px;">
    반스
</div>
<br>
<div id="workListData" class="row"
     style="display: flex; flex-wrap: wrap; margin-right: -275px; margin-left: -250px; justify-content: center;">
    <c:forEach items="${vans}" var="board" varStatus="status">
        <c:choose>
            <c:when test="${brand == null || brand eq 'all' || board.brand eq brand}">
                <div class="col-md-2"
                     style="flex: 0 0 calc(16.666% - 5px); max-width: 30vh; max-height: 53vh; padding: 5px;">
                    <div class="card my-card" data-brand="${board.brand}">
                        <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                            <div data-toggle="modal" data-target="#myModal" data-brand="${board.brand}"
                                 data-member-id="${board.memberId}">
                                <img class="card-img" src="${board.fileName}" alt=""/>
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
<br><br><br>
<div class="flex headline" style="margin-left: 130px;">
    컨버스
</div>
<br>
<div id="workListData" class="row"
     style="display: flex; flex-wrap: wrap; margin-right: -275px; margin-left: -250px; justify-content: center;">
    <c:forEach items="${converse}" var="board" varStatus="status">
        <c:choose>
            <c:when test="${brand == null || brand eq 'all' || board.brand eq brand}">
                <div class="col-md-2"
                     style="flex: 0 0 calc(16.666% - 5px); max-width: 30vh; max-height: 53vh; padding: 5px;">
                    <div class="card my-card" data-brand="${board.brand}">
                        <div onclick="console.log('data-brand:', this.getAttribute('data-brand'))">
                            <div data-toggle="modal" data-target="#myModal" data-brand="${board.brand}"
                                 data-member-id="${board.memberId}">
                                <img class="card-img" src="${board.fileName}" alt=""/>
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
<sec:authorize access="isAuthenticated()">
    <my:chatBtn></my:chatBtn>
    <script src="/js/groupChat.js"></script>
    <script src="/js/chat.js" charset="UTF-8"></script>
</sec:authorize>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
        integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script scr="/js/main.js"></script>
<script src="/js/navBar.js"></script>
</body>
</html>