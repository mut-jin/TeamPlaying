$(".acceptBtn").click(function () {
    const progress = "결제 대기중";
    const id = $(this).val();
    const data = {id : id, progress : progress}
    $.ajax("/acceptRequest", {
        method: "put",
        contentType: "application/json",
        data: JSON.stringify(data),
        complete: function (jqXHR) {
            location.reload();
            $(".toast-body").text(jqXHR.responseJSON.message);
            toast.show();
        }
    })
})
$(".modifyBtn").click(function () {
    const progress = '수정 요청';
    const id = $(this).val();
    const shoeName = $("#shoeName" + id).val();
    const brand = $("#brand" + id).val();
    const body = $("#body" + id).text();
    const price = $("#price" + id).val();
    const data = {
        id : id,
        shoeName : shoeName,
        brand : brand,
        body : body,
        price : price,
        progress : progress
    };
    $.ajax("/modifyRequest", {
        method: "put",
        contentType: "application/json",
        data: JSON.stringify(data),
        complete: function (jqXHR) {
            location.reload();
            $(".toast-body").text(jqXHR.responseJSON.message);
            toast.show();
        }
    })
})
$(".refuseBtn").click(function () {
    var id = $(this).val()
    $.ajax("/removeRequest/" + id , {
        success: function () {
            location.reload();
        }
    })
})

