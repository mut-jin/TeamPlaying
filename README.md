# 신발 커스텀 플랫폼 Zero-One

<p>나만의 신발을 가질 수 있는 신발 커스텀 플랫폼 팀 프로젝트입니다.</p>
<p>css 참조 : 커스팬텀</p>

<br/>

<h1>개발인원</h1>
<div>
    <ul>
        <li>3명(팀장)</li>
    </ul>
</div>
<br/>
<h1>배포환경</h1>
<div>
    <ul>
        <li>AWS EC2</li>
    </ul>
</div>
<br/>
<h1>개발환경</h1>
<div>
  <h3>Front-end</h3>
    <ul>
        <li>HTML</li>
        <li>CSS</li>
        <li>JavaScript</li>
        <li>jQuery</li>
        <li>Bootstrap</li>
        <li>AJAX</li>
    </ul>

  <h3>Back-end</h3>
    <ul>
        <li>Java17</li>
        <li>Spring Framework</li>
        <li>Spring Boot</li>
        <li>MariaDB</li>
        <li>MyBatis</li>
    </ul>
</div>
<br/>
<br/>
<h1>구현 기능</h1>
<div>
    <ul>
        <li>
            <strong>회원가입 및 로그인</strong>
            <ul>
                <li>회원가입, 로그인</li>
                <li>ID, 비밀번호, 이메일 중복 및 유효성 검사</li>
                <li>다음 우편번호 서비스</li>
                <li>회원가입시 이메일 인증</li>
                <li>ID찾기</li>
            </ul>
        </li>
        <li>
            <strong>작품 페이지</strong>
            <ul>
                <li>작품 페이지 CRUD</li>
                <li>댓글, 대댓글 CRUD 및 좋아요, 조회수 확인</li>
                <li>작품 검색 및 필터, 정렬</li>
                <li>작품 의뢰</li>
            </ul>
        </li>
        <li>
            <strong>아티스트 페이지</strong>
            <ul>
                <li>아티스트 정렬 및 검색</li>
                <li>아티스트 페이지 이동</li>
                <li>아티스트 별 작품 확인 및 의뢰</li>
                <li>커스텀 작품 의뢰</li>
            </ul>
        </li>
        <li>
            <strong>커스텀 페이지</strong>
            <ul>
                <li>대표 신발 커스텀</li>
                <li>커스텀한 이미지 로컬에 저장</li>
            </ul>
        </li>
        <li>
            <strong>마이페이지</strong>
            <ul>
                <li>회원정보 수정</li>
                <li>주문 내역 및 진행상황 확인</li>
                <li>요청된 의뢰 내역 확인(아티스트)</li>
                <li>테스트 결제(카카오페이)</li>
            </ul>
        </li>
        <li>
            <strong>고객센터 및 ADMIN 페이지</strong>
            <ul>
                <li>문의 게시판 CRUD</li>
                <li>회원 관리</li>
                <li>문의 답변</li>
            </ul>
        </li>
    </ul>
</div>
<br/>
<br/>
<h1>실제 페이지</h1>
<div>
    <ul>
        <li>
            <strong>메인 페이지</strong>
            <ul>
                <li>브랜드 별 작품 확인</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/afdcd193-5fab-434e-bcc3-935acef62745">
            </ul>
        </li>
        <br/>
        <li>
            <strong>회원가입</strong>
            <ul>
                <li>아이디, 패스워드 닉네임 중복 및 유효성 검사</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/1c3a0d2f-0b70-4a97-a41d-67c1dec293e0">
                <li>다음 우편번호 서비스, 비동기 처리 이메일 인증</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/f877a174-86f7-4fdb-aa99-e41ee2296195">
            </ul>
        </li>
        <br/>
        <li>
            <strong>로그인</strong>
            <ul>
                <li>로그인 구현</li>
                <li>비동기 처리로 아이디 찾기 기능 구현</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/cd20af36-506e-4335-a784-419d6f080d31">
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/4be410a0-8e62-412f-b6e7-d8eb188cbdfd">
            </ul>
        </li>
        <br/>
        <li>
            <strong>작품 페이지</strong>
            <ul>
                <li>브랜드별 필터링</li>
                <li>좋아요, 조회수, 가격순 정렬</li>
                <li>검색 기능</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/e95f6c6e-cf9e-4d2a-b46f-1cbf0d0e81af">
                <li>작품 클릭시 상품 상세정보 모달</li>
                <li>댓글 CRUD, 좋아요 기능</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/9cfe42ba-aac6-4638-934e-8238702b4685">
                <li>등록한 작품을 의뢰 요청</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/2055e291-212e-4f7c-b146-273d1f4d5025">
            </ul>
        </li>
        <br/>
        <li>
            <strong>아티스트 페이지</strong>
            <ul>
                <li>전체 아티스트 프로필 조회 기능</li>
                <li>작품 등록순, 총 조회수 순으로 조회</li>
                <li>아티스트 검색 기능</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/0106f721-3ad3-4534-9bf6-6470ea186741">
                <li>아티스트 프로필 클릭 시 아티스트 상세 페이지로 이동</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/74c8240f-1b1d-4a1e-9884-4ac8ca220bec">
                <li>커스텀 작품 아티스트에게 직접 의뢰</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/4d31578d-f6b4-4079-8674-48bd3ab75486">
            </ul>
        </li>
        <br/>
        <li>
            <strong>커스텀 페이지</strong>
            <ul>
                <li>대표적 커스텀 신발 도면 제공</li>
                <li>그림판 드로잉 스티커 회전 및 삭제 기능</li>
                <li>커스텀 이미지 로컬에 저장</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/92a944b6-b34a-41d6-9c53-50c49a15601b">
            </ul>
        </li>
        <br/>
        <li>
            <strong>마이페이지</strong>
            <ul>
                <li>고객과 아티스트의 기능이 다르게 구현</li>
                <li>회원정보 수정 및 탈퇴 기능(공통)</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/50d99cd3-993b-4403-81d5-a9ff982424aa">
                <li>의뢰 요청 상세정보 리스트 및 상세정보(공통)</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/cbca0f14-2c6f-40bf-b4d9-0d4b65d18102">
                <li>받은 의뢰 관리(아티스트)</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/4fe8061c-7749-4ce2-8e1d-cbd8ab9ce423">
            </ul>
        </li>
        <br/>
        <li>
            <strong>결제 기능</strong>
            <ul>
                <li>카카오 페이 모바일 테스트 결제</li>
                <li>마이페이지 -> 주문 내역에서 결제 진행</li>
                <li>작업 수락 및 의뢰 수정 단계 이후 진행</li>
                <li>결제 후 작업 단계로 진행</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/1a1e9ab4-44f9-4175-a474-b483b28317e3">
            </ul>
        </li>
        <br/>
        <li>
            <strong>고객센터</strong>
            <ul>
                <li>게시판 CRUD</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/9416b0e7-6f40-472d-bedf-e6b8a5ca94bb">
            </ul>
        </li>
        <br/>
        <br/>
        <li>
            <strong>ADMIN 페이지</strong>
            <ul>
                <li>고객 문의 답변 기능</li>
                <li>회원 탈퇴 관리</li>
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/3692d363-3a20-4914-b5b8-3338a580f3d2">
                <img src="https://github.com/mut-jin/TeamPlaying/assets/112159785/eb34fd6e-4fa7-44f3-aa27-38762be03234">
            </ul>
        </li>
<br/>
<br/>
