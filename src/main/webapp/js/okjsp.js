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
		alert("2���� �̻� �Է��� �ֽʽÿ�.");
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

// ���ڿ� ���� ���� ���� �� ���� ��ȯ
function squeeze(str) {
    str = str.replace(/ /g, "");
    return str.length;
}

/* @author kenu@okjsp.pe.kr
*  @date 2003-04-07 12:47����
*  @contact http://okjsp.pe.kr
*/
/*
 �����޴��� ������ �� ������ �����ϴ� �Լ�
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
 ��Ű ���� ���� �����޴��� ���̴� �Լ�
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
 �����޴��� ���̴� �Լ�
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

// �����̹��� ǥ��
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
		if (item[0] == '' || item[0] == ';') continue;
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
		if (item[0] == ';') continue;
		$("#bbslist option[value="+ item[0] +"]").prependTo("#bbslist");
	}
}


/* @author kenu@okjsp.pe.kr
*  @date 2003-01-07 4:58����
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

// �ؽ�Ʈ ����
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

// ���� ǥ���ϱ�
function displayBanner(n, col) {
    this.col = col;
    box = n;
    makeBannerContent(n, col);
    document.write(bannerContent);
    bannerContent='';
}

// ���� �ٲٱ�
function changeModeButton() {
    bannerContent+=("<div onClick='changeMode()' style='cursor:hand'><font color='white'>"+
        "<font color='red'>��</font> <b>Click to Change</b></font></div>");
}
// ���� �ٲٱ�
function changeMode() {
    col = 2-col;
    makeBannerContent(box, col);
    document.getElementById('banner2').innerHTML=bannerContent;
    bannerContent = '';
}

// ���ʼ��� �⺻ 1��
function bannerShuffle(n, count){
    bannerShuffle(n, count, 1);
}

// ���ʼ���
var box;
var col;
function bannerShuffle(n, count, col){
    // ���� �ڼ��, box �迭�� �ֱ�
    this.col = col;
    box = new Array();
    var idx = 0;
    var len = n.length;
    // ���ʵ����ͺ��� ǥ�ð����� ���� ���� �ִ밪���� ����
    if(count>len) count=len;
    // ���� �ڼ���
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
 * ��Ű�� ����
 * @param cookieName ��Ű��
 */
function getCookie( cookieName )
{
 var search = cookieName + "=";
 var cookie = document.cookie;
 // ���� ��Ű�� ������ ����
 if( cookie.length > 0 )
 {
  // �ش� ��Ű���� �����ϴ��� �˻��� �� �����ϸ� ��ġ�� ����.
  startIndex = cookie.indexOf( cookieName );
  // ���� �����Ѵٸ�
  if( startIndex != -1 )
  {
   // ���� ����� ���� ���� �ε��� ����
   startIndex += cookieName.length;
   // ���� ����� ���� ���� �ε��� ����
   endIndex = cookie.indexOf( ";", startIndex );
   // ���� ���� �ε����� ��ã�� �Ǹ� ��Ű ��ü���̷� ����
   if( endIndex == -1) endIndex = cookie.length;
   // ��Ű���� �����Ͽ� ����
   return unescape( cookie.substring( startIndex + 1, endIndex ) );
  }
  else
  {
   // ��Ű ���� �ش� ��Ű�� �������� ���� ����
   return "";
  }
 }
 else
 {
  // ��Ű ��ü�� ���� ����
  return "";
 }
}

/**
 * ��Ű ����
 * @param cookieName ��Ű��
 * @param cookieValue ��Ű��
 * @param expireDay ��Ű ��ȿ��¥
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
 * ��Ű ����
 * @param cookieName ������ ��Ű��
 */
function deleteCookie( cookieName )
{
 var expireDate = new Date();
 
 //���� ��¥�� ��Ű �Ҹ� ��¥�� �����Ѵ�.
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
 * �ڽ��� ������ ������ ��Ű ����
 */
function setMyCookie()
{
 setCookie( form.setName.value, form.setValue.value, form.expire.value );
 viewCookie(); // ��ü ��Ű ���� ����
}

/**
 * �ڽ��� ������ ��Ű������ Ȯ��
 */
function getMyCookie()
{
 alert( "��Ű �� : " + getCookie( form.getName.value ) );
}

/**
 * �ڽ��� ������ ��Ű������ ��Ű ����
 */
function deleteMyCookie()
{
 deleteCookie( form.deleteName.value );
 alert("��Ű�� �����Ǿ����ϴ�.");
 viewCookie();
}

/**
 * ��ü ��Ű ����
 */
function viewCookie()
{
 if( document.cookie.length > 0 )
  cookieOut.innerText = document.cookie;
 else
  cookieOut.innerText = "������ ��Ű�� �����ϴ�.";
}


/**
 * ��Ų ����
 */
function setSkin(skinType) {
	setCookie('skin', skinType, 100);
	document.location.reload();
}

/**
 * Ʈ�� �߰�
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
	trap(['26660', '22488', '9215', '25959', '26838']);
	trap(['27238', '27183','27354']);  // spam
});
function trap(list) {
	for(var i in list) {
		if(getCookie('sid') != list[i]) {
		    $("[alt="+list[i]+"]").parent().parent().hide();
		}
	}
}
