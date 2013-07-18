// 금지단어
var ban = new Array(
'중고차', '카지노', 'qpr1000', '경마', 'imc100', 'dmlover', 'first-shop', 'first-dm', 'rkdrkdskarn', 
'jjr8858', '승부존', 'clippers', '부업', 'hyejin000', 'caspinmsn', '사내하청'
);
// 금지단어 판단
function filterWord(content) {
	for (prop in ban) {
		if(content.toLowerCase().indexOf(ban[prop]) > -1) {
			return ban[prop];
		}
	}
	return '';
}
