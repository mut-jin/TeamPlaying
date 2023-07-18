var removeFileArr = [];

$(".dropdown-item").click(function () {
    $("#category").val($(this).val());
})

$(".removeFile").click(function () {
    const file = $(this).attr("data-board-file");
    const fileId = $(this).attr("data-board-fileId");
    $("#" + fileId).hide();
    removeFileArr.push(file);
    $("#removeFileList").val(removeFileArr);
    console.log($("#removeFileList").val())
})

