$("#kaobtn").click(function () {

    $.ajax({
        type: 'get',
        url: '/pay/ready',
        data:{
            item_name: "아이폰 14 pro",
            quantity: "1",
            total_amount: "1400000",
            tax_free_amount: "0"
        },
        success:function (res) {
            location.href = res.next_redirect_pc_url;
        }
    })
})