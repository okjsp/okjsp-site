function init(){
    var content = document.getElementById("centent");
    if (content) {
        if (content.length) {
            content = content[0];
        }
	    content.innerHTML=
	        content.innerHTML.replace(/a href=/gi,"a target='_balnk' href=")   ;
	}
}

function goPage() {
    document.f1.action="/bbs";
    document.f1.act.value="LIST";
    document.f1.submit();
}

function goReply() {
    document.f1.action="/bbs";
    document.f1.act.value="REPLY";
    document.f1.submit();
}

var callback = ";";
function show_passwd_layer(cb) {
	lobj = document.getElementById('passwd_layer');
	var yyy = document.body.scrollTop + 150;
	lobj.style.top = yyy;
	lobj.style.left = 300;
	lobj.style.background="#D0D0FF";
	callback = cb;
	var submit_type_label = (cb == 'goModify')
		? "수정"
		: "삭제";
	document.getElementById("submit_type").value = submit_type_label;
	toggleMenu('passwd_layer');

	if (lobj.style.display != 'none') {
		document.getElementById('passwd').focus();
	} else {
		document.getElementById('passwd').value = "";
	}
}

function submit_passwd() {
	eval(callback+"()");
}

function goDelete() {
    document.f1.password.value=document.getElementById("passwd").value;
    if(document.f1.password.value.length>0 && document.f1.password.value!='null') {
        document.f1.act.value="DELETE";
        document.f1.pact.value="DELETE";
        document.f1.method="POST";
        document.f1.submit();
    }
}

function goModify() {
    document.f1.password.value=document.getElementById("passwd").value;
    if(document.f1.password.value.length>0 && document.f1.password.value!='null') {
        document.f1.act.value="MODIFY";
        document.f1.pact.value="MODIFY";
        document.f1.method="POST";
        document.f1.submit();
    }
}

function goBookmark() {
    document.f1.act.value="BOOKMARK";
    document.f1.pact.value="BOOKMARK";
    document.f1.method="POST";
    document.f1.submit();
}

function goPrint() {
    link = document.location.href;
    link = link.replace("VIEW","PRINT");
    window.open(link);
}

// 검색해제
function clearKeyword() {
    document.f1.act.value="VIEW";
    document.f1.keyword.value="";
    document.f1.method="GET";
    document.f1.submit();
}

function chk_memo(mform) {
	if (mform.mseq && mform.mseq.value != '') {
		if (sqeeze(mform.delpass.value)==0) {
			alert("입력해 주십시오.");
			mform.delpass.focus();
			return false;
		} else {
			return true;
		}
	}
	if (sqeeze(mform.writer.value)==0) {
		alert("입력해 주십시오.");
		mform.writer.focus();
		return false;
	}
	if (mform.bcomment) {
		if (sqeeze(mform.bcomment.value)==0) {
			alert("입력해 주십시오.");
			mform.bcomment.focus();
			return false;
		}
		// filtering
		banWord = filterWord(mform.bcomment.value);
		if (banWord.length > 0) {
		    alert(banWord +' word can\'t be used.');
		    return false;
		}
	}

    mform.send.disabled=true;
	return true;
}

function show_memodel(mseq) {
	lobj = document.getElementById('layer_delpass');
	var yyy = document.body.scrollTop + 150;
	lobj.style.top = yyy;
	lobj.style.left = 300;
	lobj.style.background="#D0D0FF"
	document.f0.mseq.value= mseq;
	toggleMenu('layer_delpass');
	if (lobj.style.display != 'none') {
		document.f0.delpass.focus();
	}
}

// 문자열 내의 공백 제거 후 길이 반환
function sqeeze(str) {
    str = str.replace(/ /g, "");
    return str.length;
}

// 페이지 게시물 그룹 이동
function movePage() {
    document.fmove.submit();
}

/**
 * tag script
 */
function saveTag() {
	var url = "/jsp/tag.jsp?";
	var tagObj = document.getElementById("tag");
	var params = "seq=<%= one.getSeq() %>&tag="+(tagObj.value);
	tagObj.disabled = true;

	processAjax(url, params, "doTag");
	return false;
}

function doTag(req) {
	var result = req.responseText;
	document.getElementById("tagSaveMsg").innerHTML = result;
	var tagObj = document.getElementById("tag");
	if ( 'ok' == result ) {
		tagObj.value = "";
	}
	tagObj.disabled = false;
}
