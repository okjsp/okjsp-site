package kr.pe.okjsp.tag;

import java.io.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * 메일을 보내는 태그
 */
public class MailTag extends BodyTagSupport
{
    /**
	 * @uml.property  name="from"
	 */
    private String from   = "";
    /**
	 * @uml.property  name="to"
	 */
    private String to     = "";
    /**
	 * @uml.property  name="subject"
	 */
    private String subject = "";
    /**
	 * @uml.property  name="body"
	 */
    private String body   = "";
    /**
	 * @uml.property  name="server"
	 */
    private String server = "localhost";
    /**
	 * @uml.property  name="type"
	 */
    private String type   = "";
    
    public int doEndTag() throws JspException {

        try {
            String text = bodyContent.getString();
            pageContext.getOut().print(text);
        } catch (IOException e) {
            throw new JspException(e.toString());
        }

        return EVAL_PAGE;
    }

	/**
	 * Sets the from.
	 * @param from  The from to set
	 * @uml.property  name="from"
	 */
	public void setFrom(String from) {
		this.from = from;
	}

	/**
	 * Sets the subject.
	 * @param subject  The subject to set
	 * @uml.property  name="subject"
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * Sets the to.
	 * @param to  The to to set
	 * @uml.property  name="to"
	 */
	public void setTo(String to) {
		this.to = to;
	}

	/**
	 * Returns the from.
	 * @return  String
	 * @uml.property  name="from"
	 */
	public String getFrom() {
		return from;
	}

	/**
	 * Returns the subject.
	 * @return  String
	 * @uml.property  name="subject"
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * Returns the to.
	 * @return  String
	 * @uml.property  name="to"
	 */
	public String getTo() {
		return to;
	}

	/**
	 * Returns the body.
	 * @return  String
	 * @uml.property  name="body"
	 */
	public String getBody() {
		return body;
	}

	/**
	 * Returns the server.
	 * @return  String
	 * @uml.property  name="server"
	 */
	public String getServer() {
		return server;
	}

	/**
	 * Sets the body.
	 * @param body  The body to set
	 * @uml.property  name="body"
	 */
	public void setBody(String body) {
		this.body = body;
	}

	/**
	 * Sets the server.
	 * @param server  The server to set
	 * @uml.property  name="server"
	 */
	public void setServer(String server) {
		this.server = server;
	}

	/**
	 * Returns the type.
	 * @return  String
	 * @uml.property  name="type"
	 */
	public String getType() {
		return type;
	}

	/**
	 * Sets the type.
	 * @param type  The type to set
	 * @uml.property  name="type"
	 */
	public void setType(String type) {
		this.type = type;
	}

}
