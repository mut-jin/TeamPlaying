let checkId = false;
let checkEmail = false;
let checkInputCode= false;

function enableSubmit() {
    if (checkId && checkEmail && checkInputCode) {
        $("#findPW").removeAttr("disabled");
    } else {
        $("#findPW").attr("disabled", "");
    }
}

$("#checkIdBtn").click(function() {
    const userId = $("#inputUserId").val();
    // 입력한 ID와 ajax 요청 보내서
    $.ajax("/IDCheck/" + userId, {
        success: function(data) {
            // `{"available": true}`

            if (data.available) {
                // 아이디가 없다는 메세지 출력 (실패)
                $("#notExistIdMessage").removeClass("d-none");
                $("#existIdMessage").addClass("d-none");
                checkId = false;
            } else {
                // 아이디가 있다는 메세지 출력
                $("#notExistIdMessage").addClass("d-none");
                $("#existIdMessage").removeClass("d-none");
                checkId = true;
            }
        },
        complete: enableSubmit
    })
});

// 이메일 중복확인 버튼이 클릭되면
$("#emailAuth").click(function() {
    const userId = $("#inputUserId").val();
    const email = $("#inputEmail").val();
    $.ajax("/checkExistEmail/" + userId+ "/" + email, {
        success: function (data) {
            `{"available": true}`
            $("#availableEmailMessage").removeClass("d-none");
            $("#notAvailableEmailMessage").addClass("d-none");

            if(data.available) {
                // 이메일 발송 ajax 처리
                $.ajax({
                    url : '/EmailAuthPW',
                    data : {
                        userId : userId,
                        email : email
                    },
                    type : 'POST',
                    dataType : 'json',
                    success : function(result) {
                        checkEmail = true;
                        console.log("result : " + result);
                        $("#authCode").attr("disabled", false);
                        code = result;
                        alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
                    },
                    error : function (xhr, ajaxSetting, thrownError) {
                        alert("이메일 인증에 오류가 발생하였습니다.");
                    }
                }); //End Ajax

            } else {
                $("#availableEmailMessage").addClass("d-none");
                $("#notAvailableEmailMessage").removeClass("d-none");
            }
        },
        error : function (xhr, ajaxSetting, thrownError) {
            checkEmail = false;
            alert("이메일 인증에 오류가 발생하였습니다.");
            $("#availableEmailMessage").addClass("d-none");
            $("#notAvailableEmailMessage").removeClass("d-none");
        }
    })
});

//인증 코드 비교
$("#authCode").on("focusout", function() {
    const inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기

    // console.log("입력코드 : " + inputCode);
    // console.log("인증코드 : " + code);

    if(Number(inputCode) === code){
        checkInputCode = true;
        $("#emailAuthWarn").html('인증번호가 일치합니다.');
        $("#emailAuthWarn").css('color', 'green');
        $("#findPW").attr("disabled", false);
        //$("#inputEmail").prop("readonly", true);
        $("#authCode").attr("disabled", true);
    }else{
        checkInputCode = false;
        $("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
        $("#emailAuthWarn").css('color', 'red');
        $("#findPW").attr("disabled", true);
    }
});

$("#findId").click(function () {
    const userId = $("#inputUserId").val();
    const email = $("#inputEmail").val();
    $.ajax({
        url: "/sendPW",
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify({
                "userId" : userId,
                "email" : email
            }),
        success : function (data) {
            if(data == "success") {
                console.log(data)
                alert("임시 비밀번호를 발송했습니다.");
            } else {
                console.log(data)
                alert("임시 비밀번호 발송에 실패했습니다.")
            }
        },
        error : function (xhr, ajaxSetting, thrownError) {
            alert("임시 비밀번호 발송에 실패했습니다.")
        }
    })
})

