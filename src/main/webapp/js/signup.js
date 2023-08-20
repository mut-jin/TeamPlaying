let checkId = false;
let checkEmail = false;
let checkNickName = false;
let checkPassword = false;

function enableSubmit() {
    if (checkId && checkEmail && checkNickName && checkPassword) {
        $("#signupSubmit").removeAttr("disabled");
    } else {
        $("#signupSubmit").attr("disabled", "");
    }
}

// input 아이디에 키보드 입력 발생시
$("#inputId").keyup(function() {
    // 아이디 중복확인 다시
    checkId = false;
    $("#availableIdMessage").addClass("d-none")
    $("#notAvailableIdMessage").addClass("d-none")

    // submit 버튼 비활성화
    enableSubmit();
});

// nickName 인풋에 키보드 입력 발생시
$("#inputNickName").keyup(function() {
    // 별명 중복확인 다시
    checkNickName = false;
    $("#availableNickNameMessage").addClass("d-none")
    $("#notAvailableNickNameMessage").addClass("d-none")

    // submit 버튼 비활성화
    enableSubmit();
})

// email 인풋에 키보드 입력 발생시
$("#inputEmail").keyup(function() {
    // 이메일 중복확인 다시
    checkEmail = false;
    $("#availableEmailMessage").addClass("d-none")
    $("#notAvailableEmailMessage").addClass("d-none")

    // submit 버튼 비활성화
    enableSubmit();
})


// 이메일 중복확인 버튼이 클릭되면
$("#checkEmailBtn").click(function() {
    const email = $("#inputEmail").val();
    $.ajax("/member/checkEmail/" + email, {
        success: function(data) {

            if (data.available) {
                $("#availableEmailMessage").removeClass("d-none");
                $("#notAvailableEmailMessage").addClass("d-none");
                checkEmail = true;
            } else {
                $("#availableEmailMessage").addClass("d-none");
                $("#notAvailableEmailMessage").removeClass("d-none");
                checkEmail = false;
            }
        },
        complete: enableSubmit
    });
});

// 별명 중복확인 버튼이 클릭되면
$("#checkNickNameBtn").click(function() {
    const nickName = $("#inputNickName").val();

    $.ajax("/checkNickName/" + nickName, {
        success: function(data) {
            `{"available": true}`

            if (data.available) {
                $("#availableNickNameMessage").removeClass("d-none");
                $("#notAvailableNickNameMessage").addClass("d-none");
                checkNickName = true;
            } else {
                $("#availableNickNameMessage").addClass("d-none");
                $("#notAvailableNickNameMessage").removeClass("d-none");
                checkNickName = false;
            }
        },
        complete: enableSubmit
    });
});

// id 중복확인 버튼이 클릭되면
$("#checkIdBtn").click(function() {
    const userId = $("#inputId").val();
    // 입력한 ID와 ajax 요청 보내서
    $.ajax("/IDCheck/" + userId, {
        success: function(data) {
            // `{"available": true}`

            if (data.available) {
                // 사용가능하다는 메세지 출력
                $("#availableIdMessage").removeClass("d-none");
                $("#notAvailableIdMessage").addClass("d-none");
                checkId = true;
            } else {
                // 사용가능하지 않다는 메세지 출력
                $("#availableIdMessage").addClass("d-none");
                $("#notAvailableIdMessage").removeClass("d-none");
                checkId = false;
            }
        },
        complete: enableSubmit
    })
});


// 패스워드, 패스워드체크 인풋에 키업 이벤트 발생하면
$("#inputPassword, #inputPasswordCheck").keyup(function() {
    // 패스워드에 입력한 값
    const pw1 = $("#inputPassword").val();
    // 패스워드확인에 입력한 값이
    const pw2 = $("#inputPasswordCheck").val();

    if (pw1 === pw2) {
        // 같으면
        // submit 버튼 활성화
        $("#signupSubmit").removeAttr("disabled");
        // 패스워드가 같다는 메세지 출력
        $("#passwordSuccessText").removeClass("d-none");
        $("#passwordFailText").addClass("d-none");

        checkPassword = true;
    } else {
        // 그렇지 않으면
        // submit 버튼 비활성화
        $("#signupSubmit").attr("disabled", "");
        // 패스워드가 다르다는 메세지 출력
        $("#passwordFailText").removeClass("d-none");
        $("#passwordSuccessText").addClass("d-none");

        checkPassword = false;
    }

    enableSubmit();
})

//인증하기 버튼을 눌렀을 때 동작
$("#emailAuth").click(function() {
    const inputEmail = $("#inputEmail").val(); //사용자가 입력한 이메일 값 얻어오기

    //Ajax로 전송
    $.ajax({
        url : '/EmailAuth',
        data : {
            email : inputEmail
        },
        type : 'POST',
        dataType : 'json',
        success : function(result) {
            console.log("result : " + result);
            $("#authCode").attr("disabled", false);
            code = result;
            alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
        }
    }); //End Ajax
});

//인증 코드 비교
$("#authCode").on("focusout", function() {
    const inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기

    console.log("입력코드 : " + inputCode);
    console.log("인증코드 : " + code);

    if(Number(inputCode) === code){
        $("#emailAuthWarn").html('인증번호가 일치합니다.');
        $("#emailAuthWarn").css('color', 'green');
        $('#emailAuth').attr('disabled', true);
        $('#email').attr('readonly', true);
        $("#signupSubmit").attr("disabled", false);
        //$("#inputEmail").prop("readonly", true);
        $("#authCode").attr("disabled", true);
    }else{
        $("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
        $("#emailAuthWarn").css('color', 'red');
        $("#signupSubmit").attr("disabled", true);
    }
});