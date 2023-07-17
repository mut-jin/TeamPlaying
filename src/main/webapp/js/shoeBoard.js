    function handleDropdownSelection(value) {
    // 선택된 값을 서버로 전송하는 로직 작성
    // 예: AJAX 요청을 사용하여 선택된 값 전송
    $.ajax({
        url: "/work",
        type: "GET",
        data: { type: value },
        success: function(response) {
            // 서버로부터 받은 데이터를 사용하여 화면 업데이트
            // 예: 새로운 데이터로 작품 목록을 갱신
            $("#workListData").html(response);
        },
        error: function(error) {
            console.log(error);
        }
    });
}
