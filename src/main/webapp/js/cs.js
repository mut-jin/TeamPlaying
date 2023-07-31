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

function updateCsBtnStatus() {
    if($("#name").val().trim() === '' || $("#category").val().trim() === '' || $("#body").val().trim() === '') {
        $("#submitBtn").prop('disabled', true);
    } else {
        $("#submitBtn").prop('disabled', false);
    }
}

$("#name, #body, #category").on('input', updateCsBtnStatus);
