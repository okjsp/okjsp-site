
okjsp-site 소스
kenu@okjsp.pe.kr

2004-08-09 2:17오전
다운로드
(동영상 http://okjsp.pe.kr/lecture/viewlet/okjsp/okjsp_site_01.html)
아래 사이트에서 쉽게 구할 수 있고, OS와 버전에 따라서 이 문서와 상이할 수
있으며, 권장하는 방법은 해당 프로그램의 설치 매뉴얼을 시간과 노력을 들여서
읽어보는 것이다.

j2sdk 1.4.2_05 http://java.sun.com/
mysql 4.0.20b http://www.mysql.com/
eclipse 3.0 http://www.eclipse.org/
lomboz 3.0.1 http://www.objectlearn.com/
emf-sdo-runtime 2.0.0 http://www.objectlearn.com/
tomcat5 http://jakarta.apache.org/

프로그램 설치
(동영상 http://okjsp.pe.kr/lecture/viewlet/okjsp/okjsp_site_02.html)

java 관련 프로그램은 c:\java 라는 디렉토리를 기준으로 설치한다. j2sdk, eclipse,
tomcat 등이 이에 해당된다. mysql은 c:\mysql에 설치한다. 그 이외의 디렉토리에
설치한다면 my.ini파일을 만들어서 mysql이 설치된 디렉토리와 data파일이 저장되는
디렉토리를 기록하고, 윈도우 디렉토리(c:\windows 또는 c:\winnt 등)에 놓아둔다.



okjsp 소스 구하기
(동영상 http://okjsp.pe.kr/lecture/viewlet/okjsp/okjsp_site_03.html)
http://okjsp.pe.kr/cvs/ 에 cvs서버의 주소를 기록해놓았다. (현재 접속은
안정적이지 않다.)

eclipse의 CVS Repositories 를 통해서 접근한다.
CVS에서 checkout을 완료하면 Java Perspective로 layout을 바꾼다. 프로젝트
상위디렉토리에 있는 build.xml을 열어서 Outline view에서 db target을 실행한다.
이후 build.properties 파일에 있는 톰캣이 설치된 경로를 확인하고, build.xml 의
publish target을 실행한다.

브라우저를 열어서 http://localhost:8080/manager/html 을 입력하고 Tomcat을 설치할
때 입력했던 id와 password를 입력한다. manager 화면에서 default context (/) 의
reload 링크를 클릭한다.
이후 / 를 클릭해서 화면을 확인할 수 있다.








version beta
2003-04-29 2:20오전

http://ant.apache.org 에서 1.5.3 바이너리 버전 다운받아서 압축풀고
c:\java\ant 같은 곳으로 이동한 후에 ANT_HOME 환경변수에 c:\java\ant 집어넣고,
Path 에 %ANT_HOME%\bin 추가하면 설치 완료입니다.

도스창 띄워서 okjsp 소스 압축 풀린 곳에서

build.properties 의 E:/java/jakarta-tomcat-4.1.24 을 자신의 디렉토리에 맞게
수정해야 됩니다.

/docs디렉토리에 있는 okjsp-board-mysql.sql과 okjsp-member-mysql.sql을
수정합니다.
/src/kr/pe/okjsp/DB.properties 파일을 적절하게 수정합니다.

build.xml파일이 있는 디렉토리에서
ant db
명령으로 계정과 테이블을 생성합니다.

ant deploy하면 톰캣(E:/java/jakarta-tomcat-4.1.24)의 webapps\ROOT 에 자동으로

다 복사되고, 컴파일되어서 들어갑니다.

ROOT/WEB-INF/web.xml 덮어씌우니 주의하시길...



매뉴얼은 특별히 만들지 않았습니다.

가능하면 추가하도록 할 것 입니다.



mvc로 개발되었고, tomcat이 리로딩이 잘 되는 관계로 개발시 크게 불편함이 줄었습니다.

jdc-pool을 사용했으며 5분이상 사용되지 않은 커넥션은 강제로 끊어줍니다.

www.lastcom.pe.kr에서 가져온 html 편집기 기능을 조금 수정했습니다.

www.kkaok.pe.kr의 까오기 카운터 mysql 버전 2.4 수정본이 포함되었습니다.


