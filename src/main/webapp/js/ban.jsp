<%@page import="kr.pe.okjsp.util.Spam"%>
<%@ page pageEncoding="utf-8" %>
// 금지단어
var ban = JSON.parse('<%= Spam.getBannedWords() %>');

// 금지단어 판단
function filterWord(content) {
	for (prop in ban) {
		if(content.toLowerCase().indexOf(ban[prop]) > -1) {
			return ban[prop];
		}
	}
	return '';
}
