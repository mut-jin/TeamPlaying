<%--
  Created by IntelliJ IDEA.
  User: dkssu
  Date: 2023-07-20
  Time: 오후 2:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <style>
        .mb-3 {
            margin-bottom: 1rem;
        }

        .layout {
            display: flex;
            flex: 1 1 auto;
            flex-wrap: nowrap;
            min-width: 0;
        }

        .shadow {
            box-shadow: 0 3px 30px 0 rgba(0, 0, 0, .16) !important;
        }

        .myPageOption {
            flex-basis: 15%;
            max-width: 15%;
            margin-right: 12px;
        }

        .myInfo {
            flex-basis: 75%;
            max-width: 75%;
            margin-left: 12px;
            margin-bottom: 2rem;
        }

    </style>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<br>
<br>
<br>



    <my:navBar></my:navBar>
    <div class="container" style="margin-top: 100px;">
        <div class="layout" style="justify-content: center;">
            <div class="myPageOption">
                <div class="layout shadow" style="flex-direction: column">
                    <a href="/totalMyPage">회원 정보 수정</a>
                    <a href="/myRequest">의뢰 관리</a>
                    <a href="/shoppingList">주문 내역</a>
                </div>
            </div>
            <div class="row justify-content-center myInfo">
                <div class="layout shadow" style="flex-direction: column; align-items: center;">
                    <h1 style="margin-top: 10px;">주문 내역</h1>
                    <div class="layout" style="width: 100%;">
                        <form action="/myCs" class="d-flex"
                              style="margin-left: 78%;" role="search">
                            <input value="${param.search }" name="search" type="search"
                                   style="flex-basis: 75%; max-width: 75%; flex-grow: 0; border-width: 1px 0px 1px 1px;">
                            <button style="background-color: white; border-width: 1px 1px 1px 0px; flex-basis: 25%; max-width: 25%; flex-grow: 0"
                                    type="submit"><i
                                    class="fa-solid fa-magnifying-glass"></i></button>
                        </form>
                    </div>
                    <table class="table table-hover" style="text-align: center;">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 6%;">번호</th>
                            <th scope="col" style="width: 20%;">브랜드</th>
                            <th scope="col" style="width: 23%;">요청 신발</th>
                            <th scope="col" style="width: 20%;">진행 상태</th>
                            <th scope="col">자세히 보기</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${myRequestList}" var="list" varStatus="status">
                            <%--                        <tr onclick="location.href='myRequest/${list.id}'">--%>
                            <tr>
                                <th style="width: 6%;" scope="row">${status.count}</th>
                                <td style="width: 20%;">${list.brand}</td>
                                <td style="width: 23%; text-align: left;">${list.shoeName}</td>
                                <td style="width: 20%; text-align: left;">${list.progress}</td>
                                <td>
                                    <button type="button" class="btn btn-warning myRequestBtn" data-bs-toggle="modal"
                                            data-bs-target="#requestModal${list.id}" value="${list.id}">
                                        더보기
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="container-lg">
                        <div class="row">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <!-- 이전 버튼 -->
                                    <c:if test="${pageInfo.currentPageNum gt 1 }">
                                        <my:pageItem pageUrl="/myCs" pageNum="${pageInfo.currentPageNum - 1 }">
                                            <i class="fa-solid fa-angle-left"></i>
                                        </my:pageItem>
                                    </c:if>

                                    <c:forEach begin="${pageInfo.leftPageNum }" end="${pageInfo.rightPageNum }"
                                               var="pageNum">
                                        <my:pageItem pageUrl="/myCs" pageNum="${pageNum }">
                                            ${pageNum }
                                        </my:pageItem>
                                    </c:forEach>

                                    <!-- 다음 버튼 -->
                                    <c:if test="${pageInfo.currentPageNum lt pageInfo.lastPageNum }">
                                        <%-- 페이지 번호 : ${pageInfo.currentPageNum + 1 } --%>
                                        <my:pageItem pageUrl="/myCs" pageNum="${pageInfo.currentPageNum + 1 }">
                                            <i class="fa-solid fa-angle-right"></i>
                                        </my:pageItem>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:forEach items="${myRequestList}" var="list" varStatus="status">
        <div class="modal fade" id="requestModal${list.id}" tabindex="-1" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                        <%--            <form action="">--%>
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">커스텀 작품의뢰</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="layout" style="flex-direction: column">
                            <div class="mb-10">신발 정보</div>
                            <input type="text" id="brand${list.id}" style="height: 40px;" name="brand"
                                   class="mb-20" value="${list.brand}">
                            <input type="text" id="shoeName${list.id}" style="height: 40px;"
                                   name="shoeName" class="mb-20" value="${list.shoeName}">
                            <div class="mb-10">요청 사항</div>
                            <textarea name="requestBody" id="requestBody${list.id}" class="mb-20" id=""
                                      rows="7">${list.body}</textarea>
                            <div class="mb-10">희망 가격을 입력해주세요</div>
                            <input type="text" id="price${list.id}" style="height: 40px;" name="price"
                                   class="mb-20" value="${list.price}">
                            <div class="mb-10">제작 희망 기간</div>
                            <input type="date" id="makeTime${list.id}" name="makeTime"
                                   style="height: 40px;" value="${list.makeTime}">
                            <input type="hidden" id="artistUserId${list.id}"
                                   value="${list.artistUserId}">
                            <div class="mb-10">참고할 이미지</div>
                            <div>
                                <c:forEach items="${list.fileNameList}" var="file">
                                    <img src="${bucketUrl }/request/${list.id }/${file}" alt="">
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                        <%--                <c:if test="${list.progress eq '접수 대기중'} ">--%>
                    <div class="modal-footer">
                        <%--<button type="button" class="btn btn-primary" id="acceptBtn" value="작업중">
                            수락
                        </button>--%>
                            <button id="check_module" class="btn btn-primary" value="작업중" type="button">결제</button>
                        <button type="button" class="btn btn-primary" id="modifyBtn" value="조건 수정 요청">
                            조건 수정
                        </button>
                        <button type="button" class="btn btn-primary" id="refuseBtn" value="${list.id}">
                            거절
                        </button>
                    </div>
                        <%--                </c:if>--%>
                        <%--            </form>--%>
                </div>
            </div>
        </div>
    </c:forEach>


    <%--<sec:authorize access="isAuthenticated()">
        <my:chatBtn></my:chatBtn>
        <script src="/js/chat.js" charset="UTF-8"></script>
    </sec:authorize>--%>
    <script src="/js/shoppingList.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
            integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <%--<script src="/js/shoppingList.js"></script>--%>

    <script>
        $("#check_module").click(function () {
            var IMP = window.IMP; // 생략가능
            IMP.init('imp35730816');
            // i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
            // ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
            IMP.request_pay({
                pg: 'kakaopay.TC0ONETIME',
                pay_method: 'card',
                merchant_uid: 'merchant_' + new Date().getTime(),
                /*
                 *  merchant_uid에 경우
                 *  https://docs.iamport.kr/implementation/payment
                 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
                 */
                name: "아메리카노",
                // 결제창에서 보여질 이름
                // name: '주문명 : <%--${auction.a_title}',--%>
                // 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
                amount: 2000,
                // amount: <%--${bid.b_bid},--%>
                // 가격
                buyer_name: 'mason'
                // 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
                // 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
            }, function (rsp) {
                console.log(rsp);

                // 결제검증
                $.ajax({
                    type: "POST",
                    url: "makePayment", // 결제 정보를 서버로 전달
                    contentType: 'application/json;charset=utf-8',
                    data: JSON.stringify(rsp), // 결제 결과를 JSON 형태로 서버에 전송
                    success: function (response) {
                        if(response.success) {
                            // alert("결제 및 결제검증 완료");
                            // 결제 성공 시 비즈니스 로직
                        } else {
                            // alert("결제 실패");
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                })
            });
        });
    </script>
</body>
</html>
