<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="current" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
    #navbar-brand-link {
        padding: 0;
    }

    #navbar-brand-link {
        padding: 0;
    }

    #navbar-container {
        padding-top: 15px; /* 원하는 위쪽 패딩 값을 지정 */
        padding-bottom: 15px; /* 원하는 아래쪽 패딩 값을 지정 */
        display: flex;
        align-items: center;
    }

    #navbar-padding {
        padding: 0;
    }

    .navbar-brand {
        margin-right: 20px;
    }

    .navbar-nav {
        display: flex;
        align-items: center;
        height: 100%;
    }

    .nav-item {
        margin: 0 10px;
    }


</style>
<nav class="navbar navbar-expand-lg fixed-top" style="top: -8px;">
    <div id="navbar-container" class="container-fluid" style="background-color: black;">

        <a id="navbar-brand-link" class="navbar-brand" href="/main"
           style="color: white; font-size: 25px; margin-top: -5px;">
            Zero-One
            <%-- 👟 --%>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/work" style="color: white;">작품</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/artist"
                       style="color: white;">아티스트</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/canvas"
                       style="color: white;">커스텀</a>
                </li>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/totalMyPage"
                           style="color: white;">마이페이지 </a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/logout" style="color: red;">로그아웃 </a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/login"
                           style="color: aqua;">로그인 </a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/signup" style="color: white;">회원가입 </a>
                    </li>
                </sec:authorize>
                <li class="nav-item">
                    <div class="dropdown">
                        <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
                            고객센터
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="cs">1:1 문의</a></li>
                            <li><a class="dropdown-item" href="myCs">내 문의</a></li>
                        </ul>
                    </div>
                </li>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <button class="nav-item btn btn-primary"
                                style="width: 40px; height: 40px; align-items: center; justify-content: center; display: flex; margin-right: 10px;">
                            <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/running/myPage">
                                <i class="fa-regular fa-bookmark btn btn-primary"></i>
                            </a>
                        </button>
                    </li>
                    <button id="alarmList" class="btn btn-primary position-relative" type="button"
                            data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample"
                            aria-controls="offcanvasExample">
                        <i class="fa-regular fa-bell"></i>
                        <span id="NumberOfAlarm" style="display: none;"
                              class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger""> </span>
                    </button>
                </sec:authorize>
                <button type="button" class="btn btn-warning" style="margin-left: 20px;">
                    <a href="workadd">
                        작품 등록
                    </a>
                </button>
            </ul>

        </div>
    </div>
</nav>

<%-- <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/running/runningMain" style="color: white;">러닝</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${current eq 'add' ? 'active' : '' }" href="/futsal/futsalList" style="color: white;">풋살</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/climbing/list" style="color: white;">등산</a>
				</li>
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/my_page" style="color: white;">마이페이지</a>
					</li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/logout" style="color: red;">로그아웃</a>
					</li>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item">
						<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/login" style="color: aqua;">로그인</a>
					</li>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item">
						<a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/signup" style="color: white;">회원가입</a>
					</li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<button id="alarmList" class="btn btn-primary position-relative" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
						<i class="fa-regular fa-bell"></i>
						<span id="NumberOfAlarm" style="display: none;" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger""> </span>
					</button>
				</sec:authorize>
				<li class="nav-item"><a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/list">회원목록</a></li>
			</ul>

		</div>
	</div>
</nav>
 --%>
<style>
    .btn.btn-warning a {
        text-decoration: none;
        color: white;
    }
</style>


<!-- offcanvas -->
<%--<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel"--%>
<%--     style="width: 800px;">--%>
<%--    <div class="offcanvas-header">--%>
<%--        <h5 class="offcanvas-title" id="offcanvasExampleLabel">알림 목록 🏄‍♂️</h5>--%>
<%--        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>--%>
<%--    </div>--%>
<%--    <div class="offcanvas-body">--%>
<%--        <div id="runningHostAlarm"></div>--%>
<%--        <div id="runningMemberAlarm"></div>--%>
<%--        <div id="climbingHostAlarm"></div>--%>
<%--        <div id="climbingMemberAlarm"></div>--%>
<%--    </div>--%>
<%--</div>--%>

