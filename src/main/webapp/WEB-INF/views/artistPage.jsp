<%--
  Created by IntelliJ IDEA.
  User: 윤보상
  Date: 2023-07-07
  Time: 오후 2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            transition-property: box-shadow,opacity;
            word-wrap: break-word;
            position: relative;
            white-space: normal;
        }

        .hrLine {
            border-color: rgba(0,0,0,.12);
        }

    </style>
    <title>Title</title>
</head>
<body>
    <div class="layout" style="flex-wrap: wrap;">
        <div style="flex-basis: 25%; padding: 0 8px;">
            <div class="layout" style="flex-direction: column;">
                <div style="padding: 24px 16px;">
                    <div class="layout" style="flex-direction: column">
                        <div>${memberInfo.profile}</div>
                        <div>${memberInfo.nickName}</div>
                        <div>${memberInfo.address}</div>
                    </div>
                </div>
                <hr class="hrLine">
                <div style="padding: 24px 16px;">
                    <div class="layout" style="flex-direction: column">
                        <div>정보</div>
                        <div class="layout">
                            <div>등록 작품</div>
                            <div>${memberInfo.workCount}</div>
                        </div>
                        <div class="layout">
                            <div>작품 조회수</div>
                            <div>${memberInfo.totalView}</div>
                        </div>
                        <div class="layout">
                            <div>구독자</div>
                            <div>${memberInfo.subCount}</div>
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
        <div style="flex-basis: 75%;">
            <div></div>
            <div></div>
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
    </div>
</body>
</html>
