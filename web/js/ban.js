// 금지단어
var ban = new Array(
'카지노', 'qpr1000', '경마', 'imc100', 'dmlover', 'first-shop', 'first-dm', 'rkdrkdskarn'
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
