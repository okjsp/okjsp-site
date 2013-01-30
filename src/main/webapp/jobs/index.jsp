<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>OKJSP Jobs</title>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0">
<style type="text/css">
/* 
CSS from: http://css-tricks.com/responsive-data-tables/
Generic Styling, for Desktops/Laptops 
*/
table { 
	width: 100%; 
	border-collapse: collapse; 
}
/* Zebra striping */
tr:nth-of-type(odd) { 
	background: #eee; 
}
th { 
	background: #333; 
	color: white; 
	font-weight: bold; 
}
td, th { 
	padding: 6px; 
	border: 1px solid #ccc; 
	text-align: left; 
}


/* 
CSS from: http://css-tricks.com/responsive-data-tables/

Max width before this PARTICULAR table gets nasty
This query will take effect for any screen smaller than 760px
and also iPads specifically.
*/
@media 
only screen and (max-width: 760px),
(min-device-width: 768px) and (max-device-width: 1024px)  {

	/* Force table to not be like tables anymore */
	table, thead, tbody, th, td, tr { 
		display: block; 
	}
	
	/* Hide table headers (but not display: none;, for accessibility) */
	thead tr { 
		position: absolute;
		top: -9999px;
		left: -9999px;
	}
	
	tr { border: 1px solid #ccc; }
	
	td { 
		/* Behave  like a "row" */
		border: none;
		border-bottom: 1px solid #eee; 
		position: relative;
		padding-left: 50%; 
	}
	
	td:before { 
		/* Now like a table header */
		position: absolute;
		/* Top/left values mimic padding */
		top: 6px;
		left: 6px;
		width: 45%; 
		padding-right: 10px; 
		white-space: nowrap;
	}
	
	/*
	Label the data
	*/
	td:nth-of-type(1):before { content: "기술"; }
	td:nth-of-type(2):before { content: "지역"; }
	td:nth-of-type(3):before { content: "경력"; }
	td:nth-of-type(4):before { content: "연봉"; }
}
</style>
</head>
<body>
<h1>OKJSP Jobs</h1>
<nav>
<ul>
<li><a href="/jobs/addDev">구직등록</a></li>
<li><a href="/jobs/addJob">구인등록</a></li>
</ul>
</nav>
<section>
<h3>구직</h3>
<table>
	<thead>
	<tr>
		<th>기술</th>
		<th>지역</th>
		<th>경력</th>
		<th>연봉</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>자바</td>
		<td>서울</td>
		<td>4년 6개월</td>
		<td>6,000만원(월500)</td>
	</tr>
	<tr>
		<td>JSP</td>
		<td>서울</td>
		<td>통합관리 시스템구축</td>
		<td>4,800만원(월400)</td>
	</tr>
	<tr>
		<td>JSP</td>
		<td>서울</td>
		<td>통합관리 시스템구축</td>
		<td>3,600만원(월300)</td>
	</tr>
	</tbody>
</table>
</section>

<section>
<h3>구인</h3>
<table>
	<thead>
	<tr>
		<th>기술</th>
		<th>지역</th>
		<th>프로젝트명</th>
		<th>연봉</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>자바</td>
		<td>서울</td>
		<td>통합관리 시스템구축</td>
		<td>6,000만원(월500)</td>
	</tr>
	<tr>
		<td>JSP</td>
		<td>서울</td>
		<td>통합관리 시스템구축</td>
		<td>4,800만원(월400)</td>
	</tr>
	<tr>
		<td>JSP</td>
		<td>서울</td>
		<td>통합관리 시스템구축</td>
		<td>3,600만원(월300)</td>
	</tr>
	</tbody>
</table>
</section>

</body>
</html>