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
/ script from http://www.kimho.pe.kr �� TTBoard [ http://ttboard.com ] java script
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
				if(confirm("�����Ͻðڽ��ϱ�?")) {
					fmemo.submit();
					break;
				}
		}
	} else {
		if(fmemo.c.checked);
			if(confirm("�����Ͻðڽ��ϱ�?"))
				fmemo.submit();
	}
}

// �Խù� depth ǥ��
function space(n){
    for (var i=0;i< n;i++) document.write("&nbsp;");
}


/*
  ���ڿ��� ������ ��� ������ �ڿ�
  ���ڿ��� �˻��ؼ� http:// , https://, ftp:// �� �������� ���� ���
  http:// �� �Ǿտ� �ٿ��� ��ȯ
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

