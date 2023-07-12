$(document).ready(function() {
    // 모든 작품 눌렀을 때
    $('#allWork').on('click', function() {
        getWorks('all');
    });

    // 좋아요한 작품 눌렀을 때
    $('#likedWork').on('click', function() {
        getWorks('liked');
    });

    // 나이키 눌렀을 때
    $('#nike').on('click', function() {
        getWorks('nike');
    });

    // 아디다스 눌렀을 때
    $('#adidas').on('click', function() {
        getWorks('adidas');
    });

    // 반스 눌렀을 때
    $('#vans').on('click', function() {
        getWorks('vans');
    });

    // 컨버스 눌렀을 때
    $('#converse').on('click', function() {
        getWorks('converse');
    });
});

function getWorks(filter, pageNum = 1) {
    // AJAX 호출을 통해 작품 목록을 가져오고 업데이트하는 로직을 구현하세요.
    $.ajax({
        url: '/getWorks',  // 실제 작품 목록을 가져올 URL로 변경해야 합니다.
        method: 'GET',
        data: {
            filter: filter,
            page: pageNum
        },
        success: function(response) {
            // AJAX 호출이 성공한 경우, 가져온 작품 목록을 화면에 업데이트합니다.
            updateWorkList(response);
        },
        error: function(xhr, status, error) {
            // AJAX 호출이 실패한 경우, 오류 처리 로직을 추가하세요.
            console.log('AJAX Error:', error);
        }
    });
}

function updateWorkList(works) {
    // 작품 목록을 받아와서 화면을 업데이트하는 로직을 작성하세요.
    // 예를 들어, `todayListData`라는 ID를 가진 엘리먼트를 찾아 작품 카드를 생성하고 추가할 수 있습니다.
    var todayListData = $('#todayListData');
    todayListData.empty();

    works.forEach(function(work) {
        var card = $('<div>').addClass('col-md-2');
        var cardInner = $('<div>').addClass('card my-card').css('width', '18rem').css('margin-bottom', '20px');
        var cardBody = $('<div>').addClass('card-body').attr('onclick', 'openModal(' + work.id + ')');

        work.imgUrlList.forEach(function(img, index) {
            if (index < 2) {
                var imgElement = $('<img>').addClass('img-thumbnail').attr('src', img).attr('alt', '').css('width', '285px').css('height', '260px');
                cardBody.append($('<div>').append(imgElement));
            }
        });

        var titleElement = $('<h5>').addClass('card-title d-flex justify-content-between');
        titleElement.append($('<span>').text(work.nickName));
        titleElement.append($('<p>').text(work.inserted).css('font-size', 'medium'));

        var cardText = $('<p>').addClass('card-text');
        cardText.append($('<i>').addClass('fa-solid fa-heart'));
        cardText.append(' ' + work.likeCount + ' ');
        cardText.append($('<i>').addClass('fa-regular fa-comments'));
        cardText.append(' ' + work.commentCount);

        cardBody.append(titleElement);
        cardBody.append($('<p>').addClass('card-text').text(work.title));
        cardBody.append(cardText);

        cardInner.append(cardBody);
        card.append(cardInner);
        todayListData.append(card);
    });
}
