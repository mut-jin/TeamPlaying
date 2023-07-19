// // // Card 클릭 시 모달 열기
// // $(document).on('click', '[data-toggle="modal"]', function() {
// //     var brand = $(this).data('brand');
// //     var memberId = $(this).data('member-id');
// //
// //     // 모달 내용을 업데이트
// //     // 필요한 데이터를 가져와서 모달 내용을 동적으로 설정하는 작업을 수행합니다.
// //     // 예: AJAX 요청을 통해 데이터를 가져와 모달 내용을 업데이트할 수 있습니다.
// //     var imageUrl = '이미지 URL'; // 이미지 URL 가져오기
// //     var description = '설명'; // 설명 가져오기
// //
// //     // 모달 내용 업데이트
// //     var modalBody = $('#myModal').find('.modal-body');
// //     modalBody.empty(); // 모달 내용 초기화
// //     modalBody.append('<img src="' + imageUrl + '" alt=""/>'); // 이미지 추가
// //     modalBody.append('<p>' + description + '</p>'); // 설명 추가
// //
// //     // 모달 열기
// //     $('#myModal').modal('show');
// // });
//
// <!DOCTYPE html>
// <html lang="en">
// <head>
//     <meta charSet="UTF-8">
//         <meta http-equiv="X-UA-Compatible" content="IE=edge">
//             <meta name="viewport" content="width=device-width, initial-scale=1.0">
//                 <title>Modal</title>
//                 <style>
//                     #modal.modal-overlay {
//                     width: 100%;
//                     height: 100%;
//                     position: absolute;
//                     left: 0;
//                     top: 0;
//                     display: flex;
//                     flex-direction: column;
//                     align-items: center;
//                     justify-content: center;
//                     background: rgba(255, 255, 255, 0.25);
//                     box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
//                     backdrop-filter: blur(1.5px);
//                     -webkit-backdrop-filter: blur(1.5px);
//                     border-radius: 10px;
//                     border: 1px solid rgba(255, 255, 255, 0.18);
//                 }
//                     #modal .modal-window {
//                     background: rgba( 69, 139, 197, 0.70 );
//                     box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
//                     backdrop-filter: blur( 13.5px );
//                     -webkit-backdrop-filter: blur( 13.5px );
//                     border-radius: 10px;
//                     border: 1px solid rgba( 255, 255, 255, 0.18 );
//                     width: 400px;
//                     height: 500px;
//                     position: relative;
//                     top: -100px;
//                     padding: 10px;
//                 }
//                     #modal .title {
//                     padding - left: 10px;
//                     display: inline;
//                     text-shadow: 1px 1px 2px gray;
//                     color: white;
//
//                 }
//                     #modal .title h2 {
//                     display: inline;
//                 }
//                     #modal .close-area {
//                     display: inline;
//                     float: right;
//                     padding-right: 10px;
//                     cursor: pointer;
//                     text-shadow: 1px 1px 2px gray;
//                     color: white;
//                 }
//
//                     #modal .content {
//                     margin - top: 20px;
//                     padding: 0px 10px;
//                     text-shadow: 1px 1px 2px gray;
//                     color: white;
//                 }
//                 </style>
// </head>
// <body>
// <div id="container">
//     <h2>모달창 예제</h2>
//     <div id="">모달창 예제 입니다.</div>
// </div>
//
// <div id="modal" className="modal-overlay">
//     <div className="modal-window">
//         <div className="title">
//             <h2>모달</h2>
//         </div>
//         <div className="close-area">X</div>
//         <div className="content">1. 첫번쨰 공지사항</div>
//         <div className="content">2. 두번째 공지사항</div>
//         <div className="content">3. 세번째 공지사항</div>
//         <div className="content">4. 네번째 공지사항</div>
//     </div>
// </div>
//
// <script>
//     const modal = document.getElementById("modal")
//     function modalOn() {
//     modal.style.display = "flex"
// }
//     function isModalOn() {
//     return modal.style.display === "flex"
// }
//     function modalOff() {
//     modal.style.display = "none"
// }
//
//     const closeBtn = modal.querySelector(".close-area")
//     closeBtn.addEventListener("click", e => {
//     modalOff();
// })
//     })
// </script>
//
// </body>
// </html>

$(function(){

    $("button").click(function(){
        $(".modal").fadeIn();
    });

    $(".modal_content").click(function(){
        $(".modal").fadeOut();
    });

});