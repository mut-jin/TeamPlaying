<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Find ID Result</title>
</head>
<body>
<div style="text-align: center; margin-top: 2rem;">
  <c:if test="${foundID != null}">
    <h2>Your ID: ${foundID}</h2>
  </c:if>
  <c:if test="${foundID == null}">
    <h2>Sorry, your ID was not found.</h2>
  </c:if>
</div>
</body>
</html>
