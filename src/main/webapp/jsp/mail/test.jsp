<%@ page import="javax.mail.*,
        javax.mail.internet.*,
        java.util.*"
        pageEncoding="euc-kr"
%><%
    String name ="jabook";
    String from = "kenu@okjsp.pe.kr";
    String to = "kenu@okjsp.pe.kr";
    String title = "11mail�׽�Ʈ";
    String contents = "111�ȳ��ϼ��� ������� �����̳׿�^^";
    String host = "localhost";

    Properties prop = System.getProperties();
    Session sess = Session.getInstance(prop, null);
    MimeMessage message = new MimeMessage(sess);
    message.setFrom(new InternetAddress(name+"<"+from+">"));
    message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
    message.setSubject(title, "KSC5601");
    message.setText(contents);

    Transport transport = sess.getTransport("smtp");
    transport.connect(host, "kenu", "moonlove");
    transport.sendMessage(message, message.getAllRecipients());
    transport.close();
%>