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
