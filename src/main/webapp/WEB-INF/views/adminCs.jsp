<%--
  Created by IntelliJ IDEA.
  User: 윤보상
  Date: 2023-07-13
  Time: 오후 12:35
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

    m

  </style>
</head>
<body>
<my:navBar></my:navBar>
<div class="container" style="padding-top: 84px;">
  <div class="layout shadow" style="flex-direction: column; align-items: center;">
    <h1 style="margin-top: 10px;">문의 목록</h1>
    <div class="layout" style="width: 100%;">
      <%--<form action="/myCs" class="d-flex"
            style="margin-left: 78%;" role="search">
        <input value="${param.search }" name="search" type="search" style="flex-basis: 75%; max-width: 75%; flex-grow: 0; border-width: 1px 0px 1px 1px;">
        <button style="background-color: white; border-width: 1px 1px 1px 0px; flex-basis: 25%; max-width: 25%; flex-grow: 0" type="submit"><i
                class="fa-solid fa-magnifying-glass"></i></button>
      </form>--%>
    </div>
    <table class="table table-hover" style="text-align: center;">
      <thead>
      <tr>
        <th scope="col" style="width: 6%;">번호</th>
        <th scope="col" style="width: 15%;">문의 유형</th>
        <th scope="col">제 목</th>
        <th scope="col">작성자</th>
        <th scope="col">작성일</th>
        <th scope="col">답변 여부</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${csBoardList}" var="csBoard" varStatus="status">
        <tr onclick="location.href='myCs/${csBoard.id}'">
          <th style="width: 6%;" scope="row">${status.count}</th>
          <td style="width: 15%;">${csBoard.category}</td>
          <td style="text-align: center;">${csBoard.title}</td>
          <td style="text-align: center;">${csBoard.writer}</td>
          <td>${csBoard.inserted}</td>
          <c:if test="${not empty csBoard.answer}">
              <td> 답변완료 </td>
          </c:if>
          <c:if test="${empty csBoard.answer}">
            <td> 미답변 </td>
          </c:if>
        </tr>
      </c:forEach>
      </tbody>
    </table>
    <div class="container-lg">
      <div class="row">
        <%--<nav aria-label="Page navigation example">
          <ul class="pagination justify-content-center">
            <!-- 이전 버튼 -->
            <c:if test="${pageInfo.currentPageNum gt 1 }">
              <my:pageItem pageUrl="/adminCs" pageNum="${pageInfo.currentPageNum - 1 }">
                <i class="fa-solid fa-angle-left"></i>
              </my:pageItem>
            </c:if>

            <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }" var="pageNum">
              <my:pageItem pageUrl="/adminCs" pageNum="${pageNum }">
                ${pageNum }
              </my:pageItem>
            </c:forEach>

            <!-- 다음 버튼 -->
            <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
              &lt;%&ndash; 페이지 번호 : ${pageInfo.currentPageNum + 1 } &ndash;%&gt;
              <my:pageItem pageUrl="/adminCs" pageNum="${pageInfo.currentPageNum + 1 }">
                <i class="fa-solid fa-angle-right"></i>
              </my:pageItem>
            </c:if>
          </ul>
        </nav>--%>
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
