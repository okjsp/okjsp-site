function opt(n,v){
for (i=0;i<n.length;i++)
 if(n.options[i].value==v)
   n.options[i].selected = true;
}

function opt2(n,v){
for (i=0;i<n.length;i++)
 if(n[i].value==v)
   n[i].checked = true;
}
function sendval(n) {
var vchk = false;
	for(var i=0; i<n.c.length; i++) {
		vchk = vchk || n.c[i].checked;
	}
	return vchk;
}

/*/
/ script from http://www.kimho.pe.kr 의 TTBoard [ http://ttboard.com ] java script
/*/
function msgposit(){
	message.style.posLeft = 100 //event.x + 40 + document.body.scrollLeft
	message.style.posTop = event.y + 10 + document.body.scrollTop
}
function msgset(str,str2){
	var text
	text ='<table border="0" width="300" cellpadding="6" cellspacing="0" bgcolor="#F0F0F0" style="font-size:9pt; border-width:1; border-color:black; border-style:solid;">'
	text += '<tr><td><p><b>' + str + '<br><br></b>' + str2 + '</td></tr></table>'
	message.innerHTML=text
}
function msghide(){
	message.innerHTML=''
	//message.style.visibility='hidden'
}

function del_memo() {
	fmemo.act.value='del';
	if(fmemo.c.length>1) {
		for(var i=0;i<fmemo.c.length;i++) {
			if(fmemo.c[i].checked)
				if(confirm("삭제하시겠습니까?")) {
					fmemo.submit();
					break;
				}
		}
	} else {
		if(fmemo.c.checked);
			if(confirm("삭제하시겠습니까?"))
				fmemo.submit();
	}
}

// 게시물 depth 표시
function space(n){
    for (var i=0;i< n;i++) document.write("&nbsp;");
}


/*
  문자열의 공백을 모두 제거한 뒤에
  문자열을 검사해서 http:// , https://, ftp:// 로 시작하지 않을 경우
  http:// 를 맨앞에 붙여서 반환
*/
function getRightURL(n) {
    var tmp = n.replace(/\s/g, "");
    if( tmp.indexOf("http://") == 0 ||
        tmp.indexOf("https://") == 0 ||
        tmp.indexOf("ftp://") == 0)
            return tmp;
    else
            return "http://"+tmp;
}

