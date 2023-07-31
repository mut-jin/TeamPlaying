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
                    <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/canvas1"
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
                        <a class="nav-link ${current eq 'logout' ? 'active' : '' }" href="/logout" style="color: red;">로그아웃 </a>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAuthority('admin')">
                    <!-- memberType이 admin인 경우에만 회원 관리 메뉴를 표시 -->
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'adminMenu' ? 'active' : '' }" href="/members"
                           style="color: white;">회원 관리</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'login' ? 'active' : '' }" href="/login"
                           style="color: aqua;">로그인 </a>
                    </li>
                </sec:authorize>
                <%--                <sec:authorize access="isAnonymous()">--%>
                <%--                    <li class="nav-item">--%>
                <%--                        <a class="nav-link ${current eq 'adminLogin' ? 'active' : '' }" href="/adminLogin"--%>
                <%--                           style="color: aqua;">관리자 로그인 </a>--%>
                <%--                    </li>--%>
                <%--                </sec:authorize>--%>
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item">
                        <a class="nav-link ${current eq 'list' ? 'active' : '' }" href="/signup" style="color: white;">회원가입 </a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <div class="dropdown">
                            <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown"
                                    aria-expanded="false" style="color: white;">
                                고객센터
                            </button>
                            <ul class="dropdown-menu" style="min-width: 0; width: -webkit-fill-available;">
                                <li><a class="dropdown-item" href="/cs">1:1 문의</a></li>
                                <li><a class="dropdown-item" href="/myCs">내 문의</a></li>
                            </ul>
                        </div>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAuthority('artist')">
                    <li class="nav-item">
                        <a class="btn btn-warning" href="/workadd" style="color: white; margin-left: 10px;">
                            작품 등록
                        </a>
                    </li>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>

<style>
    .btn.btn-warning a {
        text-decoration: none;
        color: white;
    }
</style>

<div>
    <sec:authentication property="principal"/>
</div>

