function bt(id,after)
{
eval(id+'.filters.blendTrans.stop();');
eval(id+'.filters.blendTrans.Apply();');
eval(id+'.src="'+after+'";');
eval(id+'.filters.blendTrans.Play();');
}

function m_stop(n) {
	n.stop();
}

function m_start(n) {
	n.start();
}

function goSearch(formObj) {
	if (squeeze(formObj.keyword.value)<2) {
		alert("2글자 이상 입력해 주십시오.");
		formObj.keyword.focus();
		return false;
	}
    if (formObj.bbs.value=='memo') {
        formObj.act.value="MEMORECENT";
    } else if (formObj.bbs.value=='site') {
        formObj.act.value="SITESEARCH";
    } else {
        formObj.act.value="LIST";
    }
}

// 문자열 내의 공백 제거 후 길이 반환
function squeeze(str) {
    str = str.replace(/ /g, "");
    return str.length;
}

/* @author kenu@okjsp.pe.kr
*  @date 2003-04-07 12:47오전
*  @contact http://okjsp.pe.kr
*/
/*
 서브메뉴를 보였다 안 보였다 토글하는 함수
*/
function toggleMenu(currMenu) {
	if (document.all) {
        thisMenu = eval("document.all." + currMenu + ".style")
    } else {
		thisMenu = document.getElementById(currMenu).style
    }
	thisMenu.display = (thisMenu.display == "block")
						? "none"
						: "block";
    setCookie(currMenu, thisMenu.display, 30);
	return false
}

/*
 쿠키 값에 따라 서브메뉴를 보이는 함수
*/
function setMenuDefault(currMenu) {
    if (document.all) {
        thisMenu = eval("document.all." + currMenu)
    } else {
        thisMenu = document.getElementById(currMenu)
    }
    var state = getCookie(currMenu);
    if (thisMenu && state != null) {
        thisMenu.style.display = state;
        setCookie(currMenu, thisMenu.style.display, 30);
    }
    return false
}

var oldMenu = null;
/*
 서브메뉴를 보이는 함수
*/
function showMenu(currMenu) {
	if (document.all) {
        thisMenu = eval("document.all." + currMenu + ".style")
    } else {
		thisMenu = document.getElementById(currMenu).style
    }
    if (oldMenu != null) {
        oldMenu.display = "none";
    }
	thisMenu.display = "block"; // show
	oldMenu = thisMenu;
	return false;
}

// 에러이미지 표시
function errImage(n) {
    n.src = "/images/bnr_okjsp.gif";
}

function jumpto(e) {
	if (e.value === "") {
		return false;
	}
	saveBbslist("bbslist", e.value);
	document.location.href='/bbs?act=LIST&bbs='+e.value;
}

function saveBbslist(key, v) {
	var saved = getCookie(key);
	var changed = '';
	var isNew = true;
	var list = saved.split(',');
	for(var idx in list) {
		var item = list[idx].split(':');
		if (item[0] == '') continue;
		if (parseInt(item[1]).toString() == 'NaN') {
			item[1] = 1;
		}
		if (item[0] == v) {
			item[1] = parseInt(item[1]) + 1;
			isNew = false;
		}
		changed += item[0] + ':' + item[1] + ',';
	}
	if (isNew) {
		changed += v + ":1,";
	}
	changed = changed.substring(0,changed.length - 1);
	// sort array
	var array = changed.split(',');
	array.sort(function(a, b) {
		return parseInt(b.split(':')[1]) - parseInt(a.split(':')[1]);
	});
	
	changed = array.join(',');

	setCookie(key, changed, 365);
}

function customizedList() {
	var saved = getCookie("bbslist");
	var list = saved.split(",").reverse();
	for (idx in list) {
		var item = list[idx].split(':');
		$("#bbslist option[value="+ item[0] +"]").prependTo("#bbslist");
	}
}


/* @author kenu@okjsp.pe.kr
*  @date 2003-01-07 4:58오전
*  @contact http://okjsp.pe.kr
*/
var item;
var bannerContent='';
function showBanner(n) {
    item = n.split(",,");
    switch (item[0]) {
        case "0":
            var altText = item[5];
            if(!altText)  altText = item[2];
            bannerContent+=("<a href='"+item[2]+"' target=_blank title='"+altText+"'>");
            bannerContent+=("<img src='"+item[1]+"' border=0 width="+item[3]+", height="+item[4] );
            bannerContent+=(" onerror='errImage(this)' style='margin:1'></a>");
        break;
        case "1":
            bannerContent+=('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="'+item[3]+'" height="'+item[4]+'">');
            bannerContent+=('<param name="movie" value="'+item[1]+'"><param name="quality" value="high">');
            bannerContent+=('<embed src="'+item[1]+'" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="'+item[3]+'" height="'+item[4]+'" style="margin:1"></embed></object>');
        break;
        default:
        break;
    }
}

// 텍스트 배너
function showTextBanner(n) {
    item = n.split(",,");
    bannerContent+=("<a href='"+item[2]+"' target=_blank class='banner'>");
    bannerContent+=(item[2].substring(7)+"</a><br>");
}

function makeBannerContent(n, col) {
    if ( n == banner2 ) {
        changeModeButton();
    }
    for(var i=0;i<n.length;i++) {
        if (col>0) {
            showBanner(n[i]);
            if(i%col==(col-1)) bannerContent+=("<br/>");
        } else {
            showTextBanner(n[i]);
        }
    }
}

// 배너 표시하기
function displayBanner(n, col) {
    this.col = col;
    box = n;
    makeBannerContent(n, col);
    document.write(bannerContent);
    bannerContent='';
}

// 배너 바꾸기
function changeModeButton() {
    bannerContent+=("<div onClick='changeMode()' style='cursor:hand'><font color='white'>"+
        "<font color='red'>■</font> <b>Click to Change</b></font></div>");
}
// 배너 바꾸기
function changeMode() {
    col = 2-col;
    makeBannerContent(box, col);
    document.getElementById('banner2').innerHTML=bannerContent;
    bannerContent = '';
}

// 배너섞기 기본 1줄
function bannerShuffle(n, count){
    bannerShuffle(n, count, 1);
}

// 배너섞기
var box;
var col;
function bannerShuffle(n, count, col){
    // 배너 뒤섞어서, box 배열에 넣기
    this.col = col;
    box = new Array();
    var idx = 0;
    var len = n.length;
    // 배너데이터보다 표시갯수가 많을 경우 최대값으로 한정
    if(count>len) count=len;
    // 배너 뒤섞기
    for(var i=0; i<count; i++) {
        idx = Math.floor(Math.random()*(len-i));
        box[i] = n[idx];
        for(var j=idx; j<len-1-i; j++){
            n[j] = n[j+1];
        }
    }
    displayBanner(box, col);
    document.write(bannerContent);
    bannerContent='';
}

/**
 * 쿠키값 추출
 * @param cookieName 쿠키명
 */
function getCookie( cookieName )
{
 var search = cookieName + "=";
 var cookie = document.cookie;
 // 현재 쿠키가 존재할 경우
 if( cookie.length > 0 )
 {
  // 해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴.
  startIndex = cookie.indexOf( cookieName );
  // 만약 존재한다면
  if( startIndex != -1 )
  {
   // 값을 얻어내기 위해 시작 인덱스 조절
   startIndex += cookieName.length;
   // 값을 얻어내기 위해 종료 인덱스 추출
   endIndex = cookie.indexOf( ";", startIndex );
   // 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정
   if( endIndex == -1) endIndex = cookie.length;
   // 쿠키값을 추출하여 리턴
   return unescape( cookie.substring( startIndex + 1, endIndex ) );
  }
  else
  {
   // 쿠키 내에 해당 쿠키가 존재하지 않을 경우
   return "";
  }
 }
 else
 {
  // 쿠키 자체가 없을 경우
  return "";
 }
}

/**
 * 쿠키 설정
 * @param cookieName 쿠키명
 * @param cookieValue 쿠키값
 * @param expireDay 쿠키 유효날짜
 */
function setCookie( cookieName, cookieValue, expireDate ) {
 var today = new Date();
 today.setDate( today.getDate() + parseInt( expireDate ) );
 document.cookie = cookieName + "=" + escape( cookieValue ) + "; expires=" + today.toGMTString() 
    + "; path=/; domain=okjsp.pe.kr;";
 document.cookie = cookieName + "=" + escape( cookieValue ) + "; expires=" + today.toGMTString() 
    + "; path=/; domain=okjsp.net;";
}

/**
 * 쿠키 삭제
 * @param cookieName 삭제할 쿠키명
 */
function deleteCookie( cookieName )
{
 var expireDate = new Date();
 
 //어제 날짜를 쿠키 소멸 날짜로 설정한다.
 expireDate.setDate( expireDate.getDate() - 1 );
 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() 
    + "; path=/; domain=okjsp.pe.kr";
 // temporarily
 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() 
 + "; path=/; domain=www.okjsp.pe.kr";

 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() 
 + "; path=/; domain=okjsp.net";
 // temporarily
 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() 
 + "; path=/; domain=www.okjsp.net";
}

/**
 * 자신이 지정한 값으로 쿠키 설정
 */
function setMyCookie()
{
 setCookie( form.setName.value, form.setValue.value, form.expire.value );
 viewCookie(); // 전체 쿠키 출력 갱신
}

/**
 * 자신이 지정한 쿠키명으로 확인
 */
function getMyCookie()
{
 alert( "쿠키 값 : " + getCookie( form.getName.value ) );
}

/**
 * 자신이 지정한 쿠키명으로 쿠키 삭제
 */
function deleteMyCookie()
{
 deleteCookie( form.deleteName.value );
 alert("쿠키가 삭제되었습니다.");
 viewCookie();
}

/**
 * 전체 쿠키 출력
 */
function viewCookie()
{
 if( document.cookie.length > 0 )
  cookieOut.innerText = document.cookie;
 else
  cookieOut.innerText = "저장된 쿠키가 없습니다.";
}


/**
 * 스킨 설정
 */
function setSkin(skinType) {
	setCookie('skin', skinType, 100);
	document.location.reload();
}

/**
 * 트림 추가
 */
String.prototype.trim = function() {
	return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

//action event
function check(){
    if(document.f1.html.checked) {
	    document.f1.content.value = TextEditor.document.body.innerHTML;
    } else if(document.getElementById("TextView")){
        document.f1.content.value = f1.TextView.value;
	}
	if (document.f1.content.value.length==0 || document.f1.content.value=="<P>&nbsp;</P>"
		|| document.f1.content.value.trim().length == 0) {
	    alert("no content");
	    return false;
	}
	// filtering
	banWord = filterWord(document.f1.content.value);
	if (banWord.length > 0) {
	    alert(banWord +' word can\'t be used.');
	    return false;
	}
	if (document.f1.subject.value.trim()=="" ) {
	    alert("no subject");
	    document.f1.subject.focus();
	    return false;
    }
	if (document.f1.writer.value.trim()=="" ) {
	    alert("no writer");
	    document.f1.writer.focus();
	    return false;
    }
	if (document.f1.password.value=="" ) {
	    alert("no password");
	    document.f1.password.focus();
	    return false;
    }
    document.f1.send.disabled=true;
	return true;
}

$(function(){
	customizedList();
});
