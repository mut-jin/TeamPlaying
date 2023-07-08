$(".ShoeBrand").click(function() {
    const shoeBrand = $(this).attr("value");
    console.log(shoeBrand);
    $("#brand").val(shoeBrand);

    // AJAX 요청 보내기
    $.ajax({
        url: "/getShoeModels",
        method: "GET",
        data: { brand: shoeBrand },
        success: function(response) {
            let shoeModels = response;
            let dropdownMenu = $(this).closest(".dropdown").find(".dropdown-menu");
            dropdownMenu.empty();

            for (let i = 0; i < shoeModels.length; i++) {
                let shoeModel = shoeModels[i];
                let listItem = $("<li>");
                let link = $("<a>").addClass("dropdown-item ShoeName").text(shoeModel).attr("href", "#");
                listItem.append(link);
                dropdownMenu.append(listItem);
            }
        },
        error: function() {
            console.log("Error occurred while fetching shoe models.");
        }
    });
});

$(document).ready(function() {
    // 신발 브랜드 선택 시 해당 브랜드의 신발 모델만 표시
    $('.ShoeBrand').click(function() {
        var brand = $(this).attr('id');
        $('#brand').val($(this).text());
        $('.ShoeName').hide();
        $('.ShoeName.' + brand + '-model').show();
    });

    // 신발 모델 선택 시 입력 필드에 선택한 모델명 표시
    $('.ShoeName').click(function() {
        var shoeModel = $(this).text();
        $('#shoeModel').val(shoeModel);
    });
});

$(".dropdown-item").click(function() {
    $(".dropdown-item").removeClass("active"); // 모든 아이템에서 active 클래스 제거
    $(this).addClass("active"); // 선택한 아이템에 active 클래스 추가
});


