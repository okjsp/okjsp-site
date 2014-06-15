package kr.pe.okjsp;

import java.util.Date;

/**
 * @author  kenu
 */
public class Bookmark {
	/**
	 * @uml.property  name="seq"
	 */
	int seq;
	/**
	 * @uml.property  name="subject"
	 */
	String subject;
	/**
	 * @uml.property  name="credate"
	 */
	Date credate;
	/**
	 * @return  Returns the credate.
	 * @uml.property  name="credate"
	 */
	public Date getCredate() {
		return (Date) credate.clone();
	}
	/**
	 * @param credate  The credate to set.
	 * @uml.property  name="credate"
	 */
	public void setCredate(Date credate) {
		this.credate = (Date) credate.clone();
	}
	/**
	 * @return  Returns the seq.
	 * @uml.property  name="seq"
	 */
	public int getSeq() {
		return seq;
	}
	/**
	 * @param seq  The seq to set.
	 * @uml.property  name="seq"
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}
	/**
	 * @return  Returns the subject.
	 * @uml.property  name="subject"
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * @param subject  The subject to set.
	 * @uml.property  name="subject"
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
}
