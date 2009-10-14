//made by ys@lastcom.pe.kr

//초기화
function init() {
	if (TextEditor) {
		TextEditor.document.onmousedown = new Function("TextEditorEvent()");
		iText = TextEditor;
		iText.document.designMode = "On";
		TextEditView.style.display="inline";
		bLoad = true;
		initEditor();
	}
}

function changeToSource(){
    if(f1.html.checked) {
        f1.TextView.style.display = 'none';
        TextMode.style.display = 'inline';
        TextMenuView.style.display = 'inline';
    	TextEditView.style.display = 'inline';
        TextEditor.document.body.innerHTML = f1.TextView.value;
    } else {
    	TextEditView.style.display = 'none';
        TextMode.style.display = 'none';
        TextMenuView.style.display = 'none';
        f1.TextView.style.display = 'inline';
        f1.TextView.value = TextEditor.document.body.innerHTML;
    }
}

//초기화면 스타일 설정
function initEditor() {
	var bHeader = "<link rel=\"stylesheet\" href=\"/css/okjsp2007.css.jsp\" type=\"text/css\">";
	iText.document.open();
	iText.document.write(bHeader);
	iText.document.write(f1.content.value);
	iText.document.close();
	iText.document.body.style.fontSize = "9pt";
	iText.document.body.style.fontFamily = "Verdana,Dotumche";
}

function TextEditorEvent(){
if (TextEditor.event.button==2){

	var oSource = TextEditor.event.srcElement ;
    if (!oSource.isTextEdit)
        oSource = TextEditor.event.srcElement.parentTextEdit;

		var strValue = TextEditor.event.srcElement.tagName; //선택된 부분의 태그 종류
    if ((strValue == "IMG" || strValue == "HR") && oSource != null) {

        var oTextRange = oSource.createTextRange();
     }

		var selectedRange = TextEditor.document.selection.createRange();
		var edValue = selectedRange.htmlText;

	var strX = TextEditor.event.x;
	var strY = TextEditor.event.y+180;

	if (strValue == "IMG")
		strH = "180px";
	else if (strValue == "HR" || strValue == "TABLE")
		strH = "135px";
	else
		strH = "340px";

	var strParam = "dialogLeft:" + strX + ";dialogTop:" + strY + ";"
	strParam = strParam + "center:no;dialogWidth:150px; dialogHeight:" + strH + ";status:0;scroll:0; help:0;unadorned:yes;"
	}
}

function ButtonUp(param) {
	param.style.border="1px outset";
	param.style.background="#D4D4D4";
}

function ButtonOut(param) {
	param.style.border="";
	param.style.background="";

}
function MenuOver(param) {
	param.style.fontColor="white";
	param.style.backgroundColor="navy";
}

function MenuOut(param) {
	param.style.fontcolor="white";
	param.style.backgroundColor="#C0C0C0";
}


function block_style(o, cmd) {
	var ed=TextEditor.document.selection.createRange();
	ed.execCommand(cmd, false, o.value);
}


function SelectionCommand(Btn, cmd) {
	TextEditor.focus();
	var EdRange=TextEditor.document.selection.createRange();
	EdRange.execCommand(cmd);
}


function ChFontColor(param,cmd){
	var ed
	ed = TextEditor.document.selection.createRange();
	ed.execCommand(cmd, false, param);
}

function BgColor(cmd){
	TextEditor.document.body.bgColor = cmd;
	document.f1.bg_color.value = cmd;
}

//action event
function check(){
    if(f1.html.checked) {
	    document.f1.content.value = TextEditor.document.body.innerHTML;
    } else {
        document.f1.content.value = f1.TextView.value;
	}
	if (document.f1.content.value.length==0 || document.f1.content.value=="<P>&nbsp;</P>") {
	    alert("no content");
	    return false;
	}
	// filtering
	banWord = filterWord(document.f1.content.value);
	if (banWord.length > 0) {
	    alert(banWord +' word can\'t be used.');
	    return false;
	}
	if (document.f1.subject.value=="" ) {
	    alert("no subject");
	    document.f1.subject.focus();
	    return false;
    }
	if (document.f1.writer.value=="" ) {
	    alert("no writer");
	    document.f1.writer.focus();
	    return false;
    }
	if (document.f1.password.value=="" ) {
	    alert("no password");
	    document.f1.password.focus();
	    return false;
    }
    f1.send.disabled=true;
	return true;
}
