<!--
window.onresize = new Function ("window.resizeTo(530,530);");

function sendit(){

  var thisYear = document.myform.thisYear.value;
  if (CheckStr(thisYear, " ", "")==0 || CheckStr(thisYear, "&nbsp;", "")==0) {
    alert("연도를 입력해 주세요");
	  document.myform.thisYear.focus();
    return false;
  }

  var thisMonth = document.myform.thisMonth.value;
  if (CheckStr(thisMonth, " ", "")==0 || CheckStr(thisMonth, "&nbsp;", "")==0) {
    alert("월을 입력해 주세요");
	  document.myform.thisMonth.focus();
    return false;
  }

  var thisDate = document.myform.thisDate.value;
  if (CheckStr(thisDate, " ", "")==0 || CheckStr(thisDate, "&nbsp;", "")==0) {
    alert("일을 입력해 주세요");
	  document.myform.thisDate.focus();
    return false;
  }

  if(!isNumber(thisYear)){
    alert("숫자만 입력해 주세요");
		document.myform.thisYear.focus();
		return true;
	}

  if(!isNumber(thisMonth)){
    alert("숫자만 입력해 주세요");
		document.myform.thisMonth.focus();
		return true;
	}

  if(!isNumber(thisDate)){
    alert("숫자만 입력해 주세요");
		document.myform.thisDate.focus();
		return true;
	}

	if(thisMonth > 12 || thisMonth < 1){
    alert("월은 1 ~ 12 이내여야 합니다.");
		document.myform.thisMonth.focus();
		return true;
	}

	if(thisDate > 31 || thisDate < 1){
    alert("일은 1 ~ 31 이내여야 합니다.");
		document.myform.thisDate.focus();
		return true;
	}

	document.myform.submit();
}

function isNumber(ch) {
  var numUnicode = ch.charCodeAt(0);
  if ( 48 <= numUnicode && numUnicode <= 57 ) return true;
  return false;
}

function CheckStr(strOriginal, strFind, strChange){
    var position, strOri_Length;
    position = strOriginal.indexOf(strFind);

    while (position != -1){
      strOriginal = strOriginal.replace(strFind, strChange);
      position = strOriginal.indexOf(strFind);
    }

    strOri_Length = strOriginal.length;
    return strOri_Length;
  }

function go(ctx,s1,s2,s3){
  location.href = ctx+"/servlet/kr.pe.kkaok.count.IpnAgent?thisYear="+s1+"&thisMonth="+s2+"&thisDate="+s3;
}

function moveBlock(ctx,str,s1,s2,s3){
  location.href = ctx+"/servlet/kr.pe.kkaok.count.IpnAgent?thisYear="+s1+"&thisMonth="+s2+"&thisDate="+s3+"&gotoPage="+str;
}

//-->