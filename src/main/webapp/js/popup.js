var pop = "/pop/oracle/20050314/oracle_400x300.jsp|oracle0314|400|324|20050516|20050525";
var one = pop.split( "\|" );

var today = new Date();
var year = today.getFullYear();
var month = today.getMonth()+1;
var date = today.getDate();
if (month < 10) month = '0' + month;
if (date < 10) date = '0' + date;
today = year + month + date;

var isValid = one[4] <= today && today <= one[5];

if ( !getCookie(one[1]) && isValid ) {
    var popwin = window.open(one[0],one[1],
                     'width='+one[2]+',height='+one[3]+',status=no');
    popwin.blur();
    this.focus();
}
