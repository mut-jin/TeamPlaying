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
<html>
<head>
    <style>
        .layout {
            display: flex;
            flex: 1 1 auto;
            flex-wrap: nowrap;
            min-width: 0;
        }

        .v-card {
            border-width: thin;
            display: block;
            max-width: 100%;
            outline: none;
            text-decoration: none;
            transition-property: box-shadow, opacity;
            word-wrap: break-word;
            position: relative;
            white-space: normal;
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
<div class="container" style="margin-top: 86px;">
    <div class="layout" style="flex-wrap: nowrap">
        <div style="flex-basis: 25%; max-width: 25%; padding: 0 8px;">
            <div class="layout box" style="flex-direction: column;">
                <div style="padding: 24px 16px;">
                    <div class="layout" style="align-items: center; flex-direction: column">
                        <img src="${memberInfo.profile}">
                        <div>${memberInfo.nickName}</div>
                        <div>${memberInfo.address}</div>
                        <button type="button" class="btn btn-warning customRequestBtn" data-bs-toggle="modal"
                                data-bs-target="#exampleModal" value="${memberInfo.id}">
                            커스텀 의뢰
                        </button>
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
        <div style="flex-basis: 75%; max-width: 75%;">
            <div></div>
            <div class="layout">
                <c:forEach items="${memberInfo.shoeImgList}" var="list">
                    <img src="${list}" alt="">
                </c:forEach>
            </div>
            <div class="row">
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <!-- 이전 버튼 -->
                        <c:if test="${pageInfo.currentPageNum gt 1 }">
                            <my:pageItem pageUrl="/artist/${memberInfo.id}" pageNum="${pageInfo.currentPageNum - 1 }">
                                <i class="fa-solid fa-angle-left"></i>
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
                                <i class="fa-solid fa-angle-right"></i>
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
            <form action="">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">커스텀 작품의뢰</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="layout" style="flex-direction: column">
                        <div class="mb-10">커스텀할 신발을 입력해주세요.</div>
                        <input type="text" style="height: 40px;" name="brand" class="mb-20">
                        <input type="text" style="height: 40px;" name="shoeName" class="mb-20">
                        <div class="mb-10">요청 사항을 적어주세요.</div>
                        <textarea name="requestBody" class="mb-20" id="" rows="7"></textarea>
                        <div class="mb-10">참고할 이미지가 있다면 등록해주세요.</div>
                        <input class="form-control" style="height: 38px;" type="file" multiple
                               name="files" accept="image/*">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Save changes</button>
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
<script src="../../js/artistPage.js"></script>
</body>
</html>
