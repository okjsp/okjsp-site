/**
 * Setup JS for OKJSP with jQueryMobile.
 * @author KUAHN
 * 
 */

$("#btn_hasmore").live("click", function (event) {
    $.mobile.pageLoading();
    
    var rel = $(this).attr('rel');
    var bbs = $(this).attr('bbs');
    
    $.get(rel, function(data) {
    	$('.li_btn_hasmore').remove();
		$("#listview_"+bbs).append(data);
		$("#listview_"+bbs).listview('refresh');
		$.mobile.pageLoading(true);
    });
});

