$("#acceptBtn").click(function () {
    var progress = $(this).val();
    var id = $(".myRequestBtn").val();
    $.ajax("/acceptRequest?id=" + id + "&progress=" + progress, {
        success: function () {
            location.reload();
        }
    })
})
$("#modifyBtn").click(function () {
    var progress = $(this).val();
    var id = $(".myRequestBtn").val();
    $.ajax("/modifyRequest")
})
$("#refuseBtn").click(function () {
    var id = $(this).val()
    $.ajax("/removeRequest/" + id , {
        success: function () {
            location.reload();
        }
    })
})
