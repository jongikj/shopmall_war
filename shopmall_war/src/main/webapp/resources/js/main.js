var app = (function(){
	var init = function(context) {
		session.init(context);
	};
	var context = function(){return session.getContextPath();};
	var js = function(){return session.getJavascriptPath('js');};
	var css = function(){return session.getCssPath('css');};
	var img = function(){return session.getImagePath('img');};
	
	return {
		init : init,
		context : context,
		js : js,
		css : css,
		img : img
	}
})();

var session = (function() {
	var init = function(context){
		sessionStorage.setItem('context', context);
		sessionStorage.setItem('js', context + '/resources/js');
		sessionStorage.setItem('css', context + '/resources/css');
		sessionStorage.setItem('img', context + '/resources/img');
	};
	var getContextPath = function(){return sessionStorage.getItem('context');};
	var getJavascriptPath = function(){return sessionStorage.getItem('js');};
	var getCssPath = function(){return sessionStorage.getItem('js');};
	var getImagePath = function(){return sessionStorage.getItem('img');};
	
	return {
		init : init,
		getContextPath : getContextPath,
		getJavascriptPath : getJavascriptPath,
		getCssPath : getCssPath,
		getImagePath : getImagePath
	};
})();

/*이미지 슬라이드*/


/*price range*/

 $('#sl2').slider();

	var RGBChange = function() {
	  $('#RGB').css('background', 'rgb('+r.getValue()+','+g.getValue()+','+b.getValue()+')')
	};	
		
/*scroll to top*/

$(document).ready(function(){
	$(function () {
		$.scrollUp({
	        scrollName: 'scrollUp', // Element ID
	        scrollDistance: 300, // Distance from top/bottom before showing element (px)
	        scrollFrom: 'top', // 'top' or 'bottom'
	        scrollSpeed: 300, // Speed back to top (ms)
	        easingType: 'linear', // Scroll to top easing (see http://easings.net/)
	        animation: 'fade', // Fade, slide, none
	        animationSpeed: 200, // Animation in speed (ms)
	        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
					//scrollTarget: false, // Set a custom target element for scrolling to the top
	        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
	        scrollTitle: false, // Set a custom <a> title if required.
	        scrollImg: false, // Set true to use image
	        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
	        zIndex: 2147483647 // Z-Index for the overlay
		});
	});
});

function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
}

var member = {
	flag : flag = 0,
	checkId : function(){
		var id = $('#sign_up_id').val();
		var reg = /^[A-Za-z0-9]{4,20}$/;
		
		if(id == ""){
			alert("아이디를 입력해주세요.");
		} else {
			if(!reg.test(id)){
				alert("아이디는 영어 대, 소문자 숫자를 혼용한 4자에서 20자 까지 사용 가능합니다.");
			} else {
				$.ajax({
					url : app.context() + '/member/checkId/' + id,
					type : 'post',
					success : function(data){
						if(data.flag == 1){
							alert("중복되는 아이디 입니다.");
							flag = 0;
						} else {
							alert("사용 가능한 아이디 입니다.");
							flag = 1;
						}
					},
					error : function(x, s, m){
						alert("아이디 중복 체크중 오류 발생");
					}
				});
			}
		}
	},  // checkId 끝
	signUp : function(){
		var id = $('#sign_up_id').val();
		var pw = $('#sign_up_pw').val();
		var email = $('#sign_up_email').val();
		var pwConfirm = $('#sign_up_pw_confirm').val();
		var phone1 = $('#sign_up_phone1').val();
		var phone2 = $('#sign_up_phone2').val();
		var phone3 = $('#sign_up_phone3').val();
		var phone = phone1 + "-" + phone2 + "-" + phone3;
		var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		var regEmail = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
		
		if(flag == 0){
			alert("아이디 중복 체크를 해주세요.");
		} else {
			if(id == "" || pw == "" || email == "" || phone1 == "" || phone2 == "" || phone3 == "") {
				alert("정보를 전부 입력 해주세요");
			} else {
				if(pw != pwConfirm){
					alert("비밀번호가 일치하지 않습니다.");
				} else if(!regEmail.test(email)) {
					alert("이메일 양식에 맞게 입력해주세요.");
				} else if(email.length > 40) {
					alert("이메일은 40자 이내만 사용 가능합니다.");
				} else if(!regPhone.test(phone)) { 
					alert("전화번호는 숫자만 이용해 정확히 입력해주세요.");
				} else {
					var signUp_info = {
							id : id,
							pw : pw,
							email : email,
							phone : phone
					};
					
					$.ajax({
						url : app.context() + '/member/signUp',
						type : 'post',
						contentType : 'application/json',
						data : JSON.stringify(signUp_info),
						success : function(data){
							alert("회원가입이 완료되었습니다.")
							location.href = app.context() + '/member/goLogin';
						},
						error : function(x, s, m){
							alert("회원가입중 에러 발생" + x);
							alert(s);
							alert(m);
						}
					});
				}
			}
		}
	}, // signUp 끝
	update : function() {
		var pw = $('#mypage_pw').val();
		var pw_check = $('#mypage_pw_check').val();
		var email = $('#mypage_email').val();
		var phone1 = $('#mypage_phone1').val();
		var phone2 = $('#mypage_phone2').val();
		var phone3 = $('#mypage_phone3').val();
		var phone = phone1 + '-' + phone2 + '-' + phone3;
		var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		var regEmail = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
		
		if(pw === '' || email === '' || phone1 === '' || phone2 === '' || phone3 === '') {
			alert('정보를 전부 입력해주세요');
		} else {
			if(pw !== pw_check) {
				alert('비밀번호가 일치하지 않습니다');
			} else if(!regEmail.test(email)) {
				alert('이메일 양식에 맞게 입력해주세요');
			} else if(email.length > 40) {
				alert('이메일은 40자 이내로 등록해주세요')
			} else if(!regPhone.test(phone)) {
				alert('전화번호는 숫자만 이용해 정확히 입력해주세요');
			} else {
				var update_info = {
						pw : pw,
						email : email,
						phone : phone
				}
				
				$.ajax({
					url : '/web/member/update',
					type : 'POST',
					contentType : 'application/json',
					data : JSON.stringify(update_info),
					success : function(data) {
						alert('정보가 변경되었습니다.');
						location.reload();
					},
					error : function(x, s, m) {
						alert('정보변경 중 에러발생');
						alert(JSON.stringify(x));
						alert(s);
						alert(m);
					}
				}); 
			}
		}
	}	// update 끝
} // member 멤버함수  끝

function login(){
	$.ajax({
		url : app.context() + '/member/login',
		type : 'POST',
		data : {
				'id' : $('#login_id').val(),
				'pw' : $('#login_pw').val()
			   },
		dataType : 'JSON',
		success : function(data){
			if(data.id == '') {
				alert("아이디나 비밀번호가 일치하지 않습니다.");
			} else {
				location.href = app.context() + "/";
			}
		}
	});
}

function go_genre(genre_eng, pgNum){
	location.href = '/web/shop/goGenre/' + genre_eng + '/' + pgNum;
}

function go_faq(pgNum){
	location.href = '/web/faq/goFaq/' + pgNum;
}

function go_my_faq(pgNum){
	$.getJSON('/web/member/session', function(session){
		if(session.id == null) {
			alert('로그인이 필요합니다.');
		} else {
			location.href = '/web/faq/goMyFaq/' + pgNum;
		}
	});
}

function go_faq_one(){
	$.getJSON('/web/member/session', function(session){
		if(session.id == null) {
			alert('로그인이 필요합니다.');
		} else {
			location.href = '/web/faq/goFaqOne';
		}
	});
}

function goFaqArticle(pgNum, seq) {
	location.href = '/web/faq/faqArticle/'+ pgNum + '/' + seq;
}

function goMyFaqArticle(pgNum, seq) {
	location.href = '/web/faq/MyFaqArticle/'+ pgNum + '/' + seq;
}

function goFaqUpdate(seq, title, article) {
	location.href ='/web/faq/updateFaq/' + seq;
}

function goSellLog(pgNum) {
	location.href ='/web/member/goSellLog/' + pgNum;
}

function findFaq(page) {
	if($('#faq_search').val() === '') {
		alert('검색어를 입력해주세요');
	} else { 
		location.href = '/web/faq/find/' + $('#faq_keyfield').val() + '/' + $('#faq_search').val() + '/' + page;
	}
}

function pageFindFaq(keyfield, keyword, page) {
	location.href = '/web/faq/find/' + keyfield + '/' + keyword + '/' + page;
}

function addBuy(seq, count) {
	$.cookie('seq' + seq, ''+ seq +', '+ count +'', {path : '/web/shop'});
}

function removeBuy(seq) {
	$.removeCookie(seq, {path:'/web/shop'})
	location.reload();
}

function priceCount(flag, seq) {
	var regNumber = /^[0-9]*$/;
	var result = 0;
	var price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();

	$('[data-toggle="tooltip'+flag+'"]').tooltip('show');
	
	$.ajax({
		url : '/web/shop/checkCount',
		data : {seq : seq},
		success : function(data) {
			if($('#buy_count'+flag+'').val() !== "") {
				if(data.count < $('#buy_count'+flag+'').val()) {
					$('#buy_count'+flag+'').val(data.count);
					price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();
					$('#buy_price'+flag+'').text(priceComma(price));
					
					} else if($('#buy_count'+flag+'').val() == 0) {
						$('#buy_count'+flag+'').val(1);
						price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();
						$('#buy_price'+flag+'').text(priceComma(price));
						
					} else if((!regNumber.test($('#buy_count'+flag+'').val()))) {
						alert('숫자만 입력해주세요.');
						$('#buy_count'+flag+'').val(1);
						price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();
						$('#buy_price'+flag+'').text(priceComma(price));
						
						$('#shop_buy_price').text(priceComma(result) + '원');
						$('#hd_buy_price').val(priceComma(result));
						
					} else {
						$('#buy_price'+flag+'').text(priceComma(price));
					}
					
					for(i=1; i<=$('#shop_buy_tbody tr').length; i++){
						result += parseInt(rmComma($('#buy_price'+i+'').text()));
					}
					
					$.cookie('seq' + seq, ''+seq+', '+$('#buy_count'+flag+'').val()+'', {path : '/web/shop'});
					
					$('#shop_buy_price').text(priceComma(result) + '원');
					$('#hd_buy_price').val(priceComma(result));
			}
			
		 	$.ajax({
				url : '/web/shop/resultPrice',
				data : {price : rmComma($('#hd_buy_price').val())},
				error : function(x ,s ,m) {
					alert('error : Session price');
				}
			}); 
		},
		error : function(x, s, m) {
			alert('에러 발생');
		}
	});
}

function priceComma(num) {
	var len, point, str;
	
	num = num + "";
	point = num.length % 3;
	len = num.length;
	str = num.substring(0, point);
	
	while(point < len) {
		if(str != "")
			str += ",";
		str += num.substring(point, point + 3);
		point += 3;
	}
	return str;
}

function rmComma(num) {
	   var number = num + "";
	   return number.replace(/,/gm, "");
}

function countMinus(flag, seq) {
	var price = 0;
	var result  = 0;
	
	$('[data-toggle="tooltip'+flag+'"]').tooltip('show');
	
	if($('#buy_count'+flag+'').val() > 1) {
		$('#buy_count'+flag+'').val($('#buy_count'+flag+'').val() - 1);
		price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();
		$('#buy_price'+flag+'').text(priceComma(price));
		
		for(i=1; i<=$('#shop_buy_tbody tr').length; i++){
			result += parseInt(rmComma($('#buy_price'+i+'').text()));
		}
		
		$.cookie('seq' + seq, ''+seq+', '+$('#buy_count'+flag+'').val()+'', {path : '/web/shop'});

		$('#shop_buy_price').text(priceComma(result) + '원');
		$('#hd_buy_price').val(priceComma(result));
		
	 	$.ajax({
			url : '/web/shop/resultPrice',
			data : {price : rmComma($('#hd_buy_price').val())},
			error : function(x ,s ,m) {
				alert('error : Session price');
			}
		}); 
	}
}

function countPlus(flag, seq) {
	var price = 0;
	var result = 0;
	
	$('[data-toggle="tooltip'+flag+'"]').tooltip('show');
	
	if($('#buy_count'+flag+'').val() === '') {
		$('#buy_count'+flag+'').val(0);
	}
	
	$('#buy_count'+flag+'').val(parseInt($('#buy_count'+flag+'').val()) + 1);
	
	price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();
	$('#buy_price'+flag+'').text(priceComma(price));
	
	$.ajax({
		url : '/web/shop/checkCount',
		data : {seq : seq},
		success : function(data) {
			if(data.count < $('#buy_count'+flag+'').val()) {
				$('#buy_count'+flag+'').val(data.count);
				
				price = $('#buy_count'+flag+'').val() * $('#hd_price'+flag+'').val();
				$('#buy_price'+flag+'').text(priceComma(price));
			}
			
			for(i=1; i<=$('#shop_buy_tbody tr').length; i++){
				result += parseInt(rmComma($('#buy_price'+i+'').text()));
			}
			
			$.cookie('seq' + seq, ''+seq+', '+$('#buy_count'+flag+'').val()+'');
			
			$('#shop_buy_price').text(priceComma(result) + '원');
			$('#hd_buy_price').val(priceComma(result));
			
		 	$.ajax({
				url : '/web/shop/resultPrice',
				data : {price : rmComma($('#hd_buy_price').val())},
				error : function(x ,s ,m) {
					alert('error : Session price');
				}
			}); 
		},
		error : function(x, s, m) {
			alert('에러 발생');
		}
	});
}

function returnPrice() {
	var price;
	
 	$.ajax({
		url : '/web/shop/getResultPrice',
		async : false,
		success : function(data) {
			price = data.count;
		},
		error : function(x ,s ,m) {
			alert('error : Session price');
		}
	}); 
 	
 	return price;
}

var finBuyList = {
		buy_arr : buy_arr = new Array(),
		setBuyArr : function(param) {
			buy_arr = param;
		},
		getBuyArr : function() {
			return buy_arr;
		}
}

function addWishlist(seq) {
	$.ajax({
		url : '/web/member/session',
		async : false,
		success : function(session) {
			if(session.id == null) {
				alert('로그인을 해주세요.');
			} else {
				$.ajax({
					url : '/web/shop/selectWishOne',
					async : false,
					type : 'post',
					data : {
						seq : seq,
						id : session.id
					},
					success : function(wish) {
						if(wish.seq_sell_list === undefined) {
							$.ajax({
								url : '/web/shop/addWishlist',
								async : false,
								type : 'post',
								data : {
									seq : seq,
									id : session.id	
								},
								success : function() {
									alert('위시리스트에 추가되었습니다.');
								},
								error : function() {
									alert('위시리스트 추가 중 에러 발생');
								}
							});
						} else {
							alert('이미 위시리스트에 있는 상품입니다.');
						}
					},
					error : function() {
						alert('위시리스트 중복 체크중 에러 발생');
					}
				});	
			}
		},
		error : function() {
			alert('세션 읽는중 에러 발생');
		}
	});
}

function removeWish(id, seq) {
	$.ajax({
		url : '/web/shop/deleteWish',
		async : false,
		type : 'post',
		data : {
			id : id,
			seq : seq
		},
		success : function() {
			location.reload();
		},
		error : function() {
			alert('위시리스트 삭제중 에러 발생');
		}
	});
}

function checkAdmin() {
	if($('#whatsthis').val().length == 8) {
		$.ajax({
			url : '/web/member/check',
			async : false,
			type : 'post',
			data : {value : $('#whatsthis').val()},
			success : function(retval) {
				if(retval.flag === 1) {
					location.href = '/web/admin/';
				} else {
					// 관리자 코드가 일치하지 않을 경우 수행
				}
			},
			error : function() {
				alert('admin check error');
			}
		});
		$('#whatsthis').val('');
	}
}

function remove_image(num) {
	$('#image_tr'+num+'').remove();
}

function change_file(num) {
	$('#admin_image'+num+'').attr('type', 'file');
}

function change_url(num) {
	$('#admin_image'+num+'').attr('type', 'text');
	$('#admin_image'+num+'').attr('placeholder', '예) http://www.naver.com/image1');
}