<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
.logo-container {
	display: flex;
	justify-content: center;
	margin-top: 2rem;
}

.login-title {
	margin-top: 2rem;
	margin-left: 1rem;
}

/* Modified styles */
input[type="text"], input[type="password"] {
	width: 80%;
}
</style>
</head>
<body>

	<my:navBar></my:navBar>

	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
				<br />
				<br />
				<h1 class="login-title" style="margin-left:200px;"><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/login/%EB%A1%9C%EA%B7%B8%EC%9D%B8.png" alt="" /></h1>
				<br />
				<form method="post">
					<div class="mb-3" style="margin-left:120px;">
						<label for="" class="form-label"><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/login/%EC%95%84%EC%9D%B4%EB%94%94.png" alt="" /></label>
						<input class="form-control" type="text" name="username" />
					</div>
					<div class="mb-3" style="margin-left:120px;">
						<label for="" class="form-label"><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/login/%ED%8C%A8%EC%8A%A4%EC%9B%8C%EB%93%9C.png" alt="" /></label>
						<input class="form-control" type="password" name="password" />
					</div>
					<br />
					<div class="mb-3" style="margin-left:120px;">
						<input class="btn btn-dark" style="width: 412.8px; height: 39px;" type="submit" value="Login">
					</div>
				</form>
				<h2>Kakao Login</h2>
				<button id="loginBtn">Kakao 로그인</button>
			</div>
		</div>
	</div>

	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
	// 1603e23f210e1265c0074871a6496f28
		/*window.Kakao.init("1603e23f210e1265c0074871a6496f28");

		function loginWithKakao() {
			window.Kakao.Auth.login({
				scope: 'profile_nickname, account_email, gender, birthday',
				success: function (authObj) {
					console.log(authObj);
					window.Kakao.API.request({
						url:'/v2/user/me',
						success: res => {
							const kakao_account = res.kakao_account;
							console.log(kakao_account);
							var accessToken = authObj.access_token;
							console.log(accessToken);
						}
					});
				}
			})
		};*/

	Kakao.init("1603e23f210e1265c0074871a6496f28")

	// Kakao 로그인 버튼 클릭 이벤트 처리
	document.getElementById('loginBtn').addEventListener('click', function() {
		Kakao.Auth.login({
			success: function(authObj) {
				var accessToken = authObj.access_token;
				// 로그인 성공 시, Spring 컨트롤러로 액세스 토큰 전송
				window.location.href = '/kakao-login?accessToken=' + accessToken;
			},
			fail: function(error) {
				// 로그인 실패 시 처리할 내용을 작성합니다.
			}
		});
	});



	</script>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=582f704fa0e967e05cc4fbdd7327de24&libraries=services"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script src="/js/navBar.js"></script>
</body>
</html>