const toast = new bootstrap.Toast(document.querySelector("#liveToast"));
listComment();
var currentBoardId;

$(".likeIcon").click(function() {
    // 게시물 번호 request body에 추가
    const boardId = $(this).val();
//	const data = {boardId : boardId};
    const data = {boardId};
    $.ajax("/like", {
        method: "post",
        contentType: "application/json",
        data: JSON.stringify(data),

        success: function(data) {
            if(data.like) {
                $("#likeBtn" + boardId).html(`<i style="margin-right: 5px; font-size: 150%;" class="fa-solid fa-thumbs-up"></i> ${data.count}`);
            } else {
                $("#likeBtn" + boardId).html(`<i style="margin-right: 5px; font-size: 150%;" class="fa-regular fa-thumbs-up"></i> ${data.count}`);
            }
                $("#like" + boardId).html(data.count + " Likes");
        },
        error: function(jqXHR) {
//			console.log("좋아요 실패");
//			console.log(jqXHR);
//			console.log(jqXHR.responseJSON)
//			$("body").prepend(jqXHR.responseJSON.message);
            $(".toast-body").text(jqXHR.responseJSON.message);
            toast.show();
        }

    });
});

function view(button) {
    currentBoardId = $(button).data("id");
    console.log(currentBoardId);
    listComment();
    $.ajax("/viewCount?id=" + currentBoardId, {
        success: function (data) {
            $("#view" + currentBoardId).html(data.view + " Views");
        }
    })
}

$(".sendCommentBtn").click(function() {
    const boardId = $(this).val();
    const content = $("#shoeComment" + boardId).val();
    const data = { boardId, content };

    $.ajax("/commentAdd", {
        method: "post",
        contentType: "application/json",
        data: JSON.stringify(data),
        complete: function(jqXHR) {
            $(".toast-body").text(jqXHR.responseJSON.message);
            toast.show();
            listComment();

            $("#shoeComment" + boardId).val("");
        }
    })
})

function listComment() {
    $.ajax("/commentList?boardId=" + currentBoardId, {
        success: function(comments) {
            		console.log(comments);
            $("#commentListContainer" + currentBoardId).empty();
            for (const comment of comments) {
                const editButton = `
					<button 
						id="commentDeleteBtn${comment.id}" 
						class="commentDeleteButton btn btn-danger"
						data-bs-toggle="modal"
						data-bs-target="#deleteCommentConfirmModal"
						data-comment-id="${comment.id}">
							<i class="fa-regular fa-trash-can"></i>
						</button>
					<button
						id="commentUpdateBtn${comment.id}"
						class="commentUpdateButton btn btn-secondary"
						data-bs-toggle="modal" data-bs-target="#commentUpdateModal"
						data-comment-id="${comment.id}">
							<i class="fa-regular fa-pen-to-square"></i>
						</button>
				`
                //			console.log(comment);
                $("#commentListContainer" + currentBoardId).append(`
				<li class="list-group-item d-flex justify-content-between align-items-start">
					<div class="ms-2 me-auto">
						<div class="fw-bold"> <i class="fa-solid fa-user"></i> ${comment.memberId} </div> 
						<div style="white-space: pre-wrap;">${comment.content}</div>
					</div>
					<div>
						<span class="badge bg-primary rounded-pill"> ${comment.inserted}</span>
						<div class="text-end mt-2">
							${comment.editable ? editButton : ''}
						</div>
					</div>
				
				</li>
			`);
            };

            $(".commentUpdateButton").click(function() {
                const id = $(this).attr("data-comment-id");
                $.ajax("/commentId/" + id, {
                    success: function(data) {
                        $("#commentUpdateIdInput").val(data.id);
                        $("#commentUpdateTextArea").val(data.content);
                    }
                })
            })

            $(".commentDeleteButton").click(function() {
                const commentId = $(this).attr("data-comment-id");
                $("#deleteCommentModalButton").attr("data-comment-id", commentId);
            })
        }
    });
}

$("#updateCommentBtn").click(function() {
    const commentId = $("#commentUpdateIdInput").val();
    const content = $("#commentUpdateTextArea").val();
    const data = {
        id : commentId,
        content : content
    }
    $.ajax("/commentUpdate", {
        method: "put",
        contentType: "application/json",
        data: JSON.stringify(data),
        complete: function(jqXHR) {
            listComment();
            $("#shoeBoard" + currentBoardId).click();
            $(".toast-body").text(jqXHR.responseJSON.message);
            toast.show();
        }
    })
})



$("#deleteCommentModalButton").click(function() {
    const commentId = $(this).attr("data-comment-id");
    $.ajax("/commentId/" + commentId, {
        method: "delete",
        complete: function(jqXHR) {
            listComment();
            $("#shoeBoard" + currentBoardId).click();
            $(".toast-body").text(jqXHR.responseJSON.message);
            toast.show();
        }
    })
})

$(".cancel").click(function () {
    $("#shoeBoard" + currentBoardId).click();
})

$(".requestBtn").click(function () {
    const title = $(this).val();
    $("#requestTitleView").html(title + "에 대한 커스텀을 의뢰합니다.");
    $("#requestTitle").val($("#boardTitle" + currentBoardId).text());
    $("#requestMemberId").val($("#boardMemberId" + currentBoardId).val());
    $("#requestBrand").val($("#boardBrand" + currentBoardId).val());
    $("#requestPrice").val($("#boardPrice" + currentBoardId).text());
    $("#requestShoeName").val($("#boardShoeName" + currentBoardId).text());
})