<%@ page import="com.example.teamplaying.domain.Member" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.teamplaying.domain.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Member List</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<my:navBar></my:navBar>

<div class="container">
    <table class="table table-striped">
        <br><br>
        <thead>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Member Type</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="member" items="${members}">
            <tr>
                <td>${member.id}</td>
                <td>${member.userId}</td>
                <td>${member.name}</td>
                <td>${member.address}</td>
                <td>${member.phone}</td>
                <td>${member.email}</td>
                <td>${member.memberType}</td>
                <td>
                    <c:if test="${member.status == 1}">
                        <button class="btn btn-danger" onclick="deleteMember(${member.id})">회원탈퇴</button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    function deleteMember(memberId) {
        // AJAX 요청 보내기
        $.ajax({
            type: "DELETE",
            url: "/members/" + memberId,
            success: function (response) {
                // 비활성화 성공 시에 수행할 동작
                alert(response);
                location.reload(); // 페이지 새로고침
            },
            error: function () {
                // 비활성화 실패 시에 수행할 동작
                alert("Failed to deactivate member.");
            }
        });
    }
</script>

</body>
</html>
