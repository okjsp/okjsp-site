<%@ page import="java.util.*,
    java.io.*,
    javax.mail.*,
    javax.mail.internet.*"
%><%@ page contentType="text/html;charset=euc-kr"
%><%

// ���� ���
String from = "kenu@okjsp.pe.kr";
String fname = "kenu";
String host = "127.0.0.1";

// ���� ����,����
String mailSubj = request.getParameter("mailsubj");
String msgText = request.getParameter("mailbody");
mailSubj = new String(mailSubj.getBytes("8859_1"),"euc-kr");
msgText = new String(msgText.getBytes("8859_1"),"euc-kr");


Message msg = null;

// ������Ƽ �� �ν��Ͻ� ������ �⺻����(SMTP ���� ȣ��Ʈ ����)
Properties props = new Properties();
props.put("mail.smtp.host", host);

Session sess = Session.getDefaultInstance(props, null);

// csv ���� �о���̱�
FileReader testRead;
testRead = new FileReader (request.getRealPath("/")+"jsp/mail/maillist.csv");
int tempChar;
StringBuffer sbuf = new StringBuffer();
String tmp = "", tname = "", to = "";
int i = 0;

// StringBuffer sbuf �� ����
do {
    tempChar = testRead.read();
    if (tempChar == -1) break;
    sbuf.append((char)tempChar);
} while(true);

// StringBuffer �� ���پ� ���� �а� ',' �����ؼ� ���������� ���Ϻ�����
StringTokenizer sto = new StringTokenizer(sbuf.toString(),"\n");
while(sto.hasMoreElements()) {
    tmp = sto.nextElement().toString();
/*
        if( tmp.indexOf("hotmail.com") > -1
            || tmp.indexOf("dreamwiz.com") > -1
            || tmp.indexOf("netian.com") > -1
            || tmp.indexOf("empal.com") > -1 ) {
            continue;
        }
*/
    System.out.println(tmp);

    i = tmp.indexOf(",");
    tname = tmp.substring(0,i);
    to = tmp.substring(i+1);
    out.println(to+"<br>");

    // ���� ������
    try {
        // create a message

        InternetAddress[] address = {new InternetAddress(to)};
        InternetAddress fadd = new InternetAddress();
        fadd.setAddress(from); // ������ ��� email
        fadd.setPersonal(fname,"EUC-KR"); // ������ ��� �̸�

        msg = new MimeMessage(sess);
        msg.setFrom(fadd);
        msg.setRecipients(Message.RecipientType.TO, address);
        msg.setSubject(mailSubj);
        msg.setSentDate(new Date());
        msg.setContent(msgText,"text/html;charset=euc-kr"); // HTML ����

    Transport transport = sess.getTransport("smtp");
    transport.connect(host, "kenu", "gjdPqls");
    transport.sendMessage(msg, msg.getAllRecipients());
    transport.close();
        Thread.sleep(100);

    } catch (MessagingException mex) {
        out.println(mex.getMessage());
        out.println(host+"���� ������ ����׿�.\n�߼����� ���߽��ϴ�.");
    } // end try

} // end while

%>
<hr><a href='http://www.okjsp.pe.kr'>www.okjsp.pe.kr</a>

