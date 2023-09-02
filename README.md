# 신발 커스텀 플랫폼 Zero-One

<p>나만의 신발을 가질 수 있는 신발 커스텀 플랫폼 팀 프로젝트입니다.</p>

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
<p>( 이미지는 aws s3에 저장하고 사용하는데 비용문제로 사용 중단하면서 이미지가 없습니다. )</p>
<p>( 그래서 임시 이미지로 대체했습니다. )</p>
<br/>
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
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150129225-9668ed2b-21ea-4f2d-87f5-d25ceeda701f.png ">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>로그인</strong>
            <ul>
                <li>카카오 로그인 구현</li>
                <li>프론트, 서버 모두 유효성 검사</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150129246-d77023e6-d76b-4950-af5b-b0f1523dd198.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>작품 페이지</strong>
            <ul>
                <li>주문, QnA버튼 클릭시 비동기로 내용 가져오게끔 구현</li>
                <li>회원탈퇴 기능</li>
                <li>주문상세보기 클릭시 해당 주문 관련 정보들 표시</li>
                <li>더보기 버튼 (noOffset 페이징)</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150294134-9774bb46-ac1d-49c5-b94f-6f51b576bd9d.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>아티스트 페이지</strong>
            <ul>
                <li>주문, QnA버튼 클릭시 비동기로 내용 가져오게끔 구현</li>
                <li>회원탈퇴 기능</li>
                <li>주문상세보기 클릭시 해당 주문 관련 정보들 표시</li>
                <li>더보기 버튼 (noOffset 페이징)</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150294134-9774bb46-ac1d-49c5-b94f-6f51b576bd9d.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>커스텀 페이지</strong>
            <ul>
                <li>주문, QnA버튼 클릭시 비동기로 내용 가져오게끔 구현</li>
                <li>회원탈퇴 기능</li>
                <li>주문상세보기 클릭시 해당 주문 관련 정보들 표시</li>
                <li>더보기 버튼 (noOffset 페이징)</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150294134-9774bb46-ac1d-49c5-b94f-6f51b576bd9d.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>마이페이지</strong>
            <ul>
                <li>주문, QnA버튼 클릭시 비동기로 내용 가져오게끔 구현</li>
                <li>회원탈퇴 기능</li>
                <li>주문상세보기 클릭시 해당 주문 관련 정보들 표시</li>
                <li>더보기 버튼 (noOffset 페이징)</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150294134-9774bb46-ac1d-49c5-b94f-6f51b576bd9d.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>결제 기능</strong>
            <ul>
                <li>주문, QnA버튼 클릭시 비동기로 내용 가져오게끔 구현</li>
                <li>회원탈퇴 기능</li>
                <li>주문상세보기 클릭시 해당 주문 관련 정보들 표시</li>
                <li>더보기 버튼 (noOffset 페이징)</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150294134-9774bb46-ac1d-49c5-b94f-6f51b576bd9d.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>고객센터</strong>
            <ul>
                <li>기본적인 CRUD</li>
                <li>댓글, 대댓글 CRUD, 비공개 여부 설정가능</li>
                <li>작성자 아이디 마스킹처리</li>
                <li>페이징</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150129443-4f43da01-8ed8-450f-87b6-c6c994d6e3d4.png">
                </li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150262071-b6dbc5ee-1fb8-46b5-85bc-457b2a449e39.png">
                </li>
            </ul>
        </li>
        <br/>
        <br/>
        <li>
            <strong>ADMIN 페이지</strong>
            <ul>
                <li>수량 변경 가능</li>
                <li>리뷰 : 상품 구매시에만 리뷰 작성 가능, 정렬 기능</li>
                <li>QnA : 비공개여부 선택 가능, 관리자만 답글 가능</li>
                <li>일반 페이징, noOffset 페이징</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150293680-55db76f0-9ec8-49d9-bef9-94cfbf829d99.png">
                </li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150261169-4ba3f6dc-fee5-4d9c-b6d9-e4d894225d3f.png">
                </li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150261150-4780b106-e5df-49d8-89a4-d5f920f0b506.png">
                </li>
            </ul>
        </li>
        <br/>
        <br/>
        <li>
            <strong>장바구니</strong>
            <ul>
                <li>개별 혹은 선택주문</li>
                <li>비동기 수량변경, 삭제 가능</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150293781-519e646c-c017-4f9a-aaf9-202f531c702f.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>주문 정보</strong>
            <ul>
                <li>주문한 상품에 대한 기본 정보들</li>
                <li>가상계좌 구매시 유효기간과, 계좌번호도 표시</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150293700-fbaec84b-3cc9-4fa2-9c59-cecd61f2a756.png">
                </li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150294626-c3d1b4cf-1517-4e89-bfca-524b3e6dcb37.png">
                </li>
            </ul>
        </li>
        <li>
            <strong>상품 주문</strong>
            <ul>
                <li>구매하려는 상품 목록 표시</li>
                <li>구매 클릭시 서버에서 배송정보 유효성검사후 결제 진행</li>
                <li>카카오페이, 가상계좌 결제 가능</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150293743-7034ca49-43d5-41c5-8a3d-eaf673efef3d.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 페이지 메인</strong>
            <ul>
                <li>최근 가입한 유저목록, 주문 목록 조회</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150129475-eaef4772-64d6-42bb-9f7f-9cd55950756b.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 페이지 주문목록</strong>
            <ul>
                <li>주문상태 변경 기능</li>
                <li>동적 검색</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150129493-4f176fcb-e4a3-4b90-a39f-5d5a3a83a6d6.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 페이지 상품배송</strong>
            <ul>
                <li>입금 완료된 주문만 표시</li>
                <li>운송장 입력후 배송시 해당 주문 배송상태 변경</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150293811-24e6beaa-9b10-430d-9dbe-d4c64ea7fa51.png">
                </li>
            </ul>
        </li>
        <br/>
        <li>
            <strong>관리자 페이지 상품 목록</strong>
            <ul>
                <li>상품 동적 검색 및 삭제</li>
                <li>
                    <img src="https://user-images.githubusercontent.com/89326946/150293851-7689a098-f254-4fbd-b6ed-b31fd2d0a299.png">
                </li>
            </ul>
        </li>
    </ul>
</div>
<br/>
<br/>
