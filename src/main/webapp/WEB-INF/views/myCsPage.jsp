<%--
  Created by IntelliJ IDEA.
  User: 윤보상
  Date: 2023-07-14
  Time: 오후 4:41
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
        }

        .shadow {
            box-shadow: 0 3px 30px 0 rgba(0, 0, 0, .16) !important;
        }


    </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="margin-top: 84px;">
    <div class="layout shadow" style="flex-direction: column">
        <div class="layout" style="margin: 0; padding: 15px 0 15px 20px; border-top: 2px solid limegreen;">
            <h2>의뢰</h2>
            <c:if test="${csBoard.answer == null}">
                <form action="/csModify">
                    <input type="hidden" name="id" value="${csBoard.id}">
                    <button class="btn btn-primary" style="margin-left: auto;" type="submit">수정</button>
                </form>
                <button type="button" data-bs-toggle="modal" style="margin-right: 2%;" class="btn btn-danger"
                        data-bs-target="#confirmModal">삭제
                </button>
            </c:if>

        </div>
        <div class="layout" style="flex-direction: column; margin: 0px 20px 0px; border-top: 1px solid black;">
            <div class="layout" style="align-items: baseline; align-items: baseline; padding: 10px 20px 10px;">
                <h3 style="margin: 0; color: limegreen">
                    Q ${csBoard.title}
                </h3>
                <div style="margin-left: auto;">
                    ${csBoard.inserted}
                </div>
            </div>
            <div style="border-top: 1px solid #0000003b; border-bottom: 1px solid #0000003b; padding: 10px 20px 10px;">
                문의 유형: ${csBoard.category}</div>
            <div style="padding: 30px 20px 30px;">${csBoard.body}</div>
            <div class="layout" style="padding-bottom: 30px;">
                <c:forEach items="${files}" var="file">
                    <img src="${bucketUrl }/csBoard/${csBoard.id }/${file}" alt="">
                </c:forEach>
            </div>
            <c:if test="${csBoard.answer != null}">
                <div class="layout"
                     style="background-color: #f7f7f7; padding: 30px 10px 30px; border-top: 1px solid #e7e7e7;">
                    <div class="layout" style="max-width: 48px;">
                        <div style="margin-top: 3px; color: #b9b9b9">┗</div>
                        <h4 style="padding: 0 7px 0; font-weight: bolder;">A</h4>
                    </div>
                    <div>${csBoard.answer}</div>
                </div>
            </c:if>
            <c:if test="${csBoard.answer == null}">
                <form action="/csAnswer" method="post">
                    <input type="hidden" value="${csBoard.id}" name="id">
                    <textarea id="answer" name="answer" id="" cols="30" rows="10"></textarea>
                    <button type="submit">등록</button>
                </form>
            </c:if>
        </div>
    </div>
</div>

<!-- 삭제 확인Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="removeForm" action="/csRemove" method="post">
                    해당 문의를 삭제하시겠습니까?
                    <input type="hidden" name="id" value="${csBoard.id}"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
                <button type="submit" form="removeForm" class="btn btn-danger">예</button>
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
</body>
</html>
