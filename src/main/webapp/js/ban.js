// 금지단어
var ban = new Array(
'ab88', '카지노', 'qpr1000', '경마', 'imc100', 'dmlover', 'first-shop', 'first-dm', 'rkdrkdskarn', 
'baekhee', '.lu.to', 'jjr8858', '택알바', '승부존', 'clippers', '부업', 'hyejin000', 'caspinmsn'
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
