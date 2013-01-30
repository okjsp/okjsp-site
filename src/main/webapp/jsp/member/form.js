function check_value(n) {

	if (!check_id(n)) return false;
	if (!check_pass(n)) return false;

	if (n.password.value != n.password2.value ) {
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		n.password.focus();
		return false;
	}

	var tmp_name = n.name.value;

	tmp_name = tmp_name.replace(" ", "");
	if (tmp_name.length < 1 ) {
		alert("�̸��� �Է����ֽʽÿ�.");
		n.name.focus();
		return false;
	}
    f1.pact.value="modify";

	return true;
} // end check_value func


function check_id(n) {
	var T = "abcdefghijklmnopqrstuvwxyz0123456789_";
	tmp_id = n.id.value.toLowerCase();

	if (n.id.value != tmp_id) n.id.value=tmp_id;

	if (tmp_id.length<4 && tmp_id > 12) {
		alert("id�� ���� �Ǵ� ���� 4~12 �ڸ��Դϴ�. ");
		n.id.focus();
		return false;
	}

	for(var i=0; i<tmp_id.length; i++) {
		if(T.indexOf(tmp_id.charAt(i))==-1) {
			alert("id �� ���� �ҹ��ڿ� ���ڸ�\n����� �� �ֽ��ϴ�."+tmp_id.charAt(i));
			n.id.focus();
			return false;
		}
	}

	return true;
} // end check_id func


function check_pass(n) {
	if (n.password.value.length <3 ) {
		alert("��й�ȣ�� 3���̻��Դϴ�.");
		n.password.focus();
		return false;
	}

	return true;
} // end check_pass func

function isEmail(s)
{
    // source from www.taeyo.pe.kr
  return s.search(/^\s*[\w\~\-\.]+\@[\w\~\-]+(\.[\w\~\-]+)+\s*$/g)>=0;
}

function id_from_email() {
	var tmp = f1.email.value;
	var idx = isEmail(tmp);
	if (idx==true) {
		f1.id.value = tmp.substring(0,tmp.indexOf("@"));
		idpop();
/*		alert(
			f1.email.value+"\n"+
			f1.id.value+"\n"+
			"id_from_email()"
		);
*/
	} else {
		alert("�߸��� �����ּ��Դϴ�.");
		f1.email.focus();
		return false;
	} // end if

} // end id_from_email

function idpop() {
	window.open('idCheck.jsp','idpop','status=yes,width=300,height=200');
}

function valid_id() {
	opener.f1.id.value = f1.id.value;
	opener.f1.name.focus();
	self.close();
}

function check_login(n) {
	if (!check_id(n)) return false;
	if (!check_pass(n)) return false;
	return true;
}

function resign() {
    if( check_value(f1) ) {
        if (confirm("Ż���Ͻðڽ��ϱ�?")) {
            f1.pact.value="delete";
            f1.submit();
        }
    }

}