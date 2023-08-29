$(document).ready(function () {
    $("#findIdForm").submit(function (event) {
        event.preventDefault();
        var name = $("#inputUsername").val();
        var email = $("#inputEmail").val();

        $.post("/findId", { name: name, email: email }, function (data) {
            $("#result").html("<p>찾은 아이디: " + data + "</p>");
        });
    });
});