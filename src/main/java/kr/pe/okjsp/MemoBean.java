package kr.pe.okjsp;

import java.sql.Timestamp;

import kr.pe.okjsp.util.*;

/**
 * @author  kenu  Memo 정보를 담아두는 Bean
 */
public class MemoBean {
    private int seq;
    private int mseq;
    private String id;
    private String writer;
    private String bcomment;
    private Timestamp wtime;
    private String ip;
    private long sid;

	/**
	 * Returns the bcomment.
	 * @return  String
	 */
	public String getBcomment() {
		return bcomment;
	}

	/**
	 * Returns the mseq.
	 * @return  int
	 */
	public int getMseq() {
		return mseq;
	}

	/**
	 * Returns the seq.
	 * @return  int
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * Returns the writer.
	 * @return  String
	 */
	public String getWriter() {
		return writer;
	}

	/**
	 * Method getWriter.
	 * @param len
	 * @return String
	 */
	public String getWriter(int len) {
		return CommonUtil.cropByte(getWriter(), len, ".");
	}

	/**
	 * Returns the wtime.
	 * @return  Timestamp
	 */
	public Timestamp getWtime() {
		return wtime;
	}

	/**
	 * Method getWhen.
	 * @param fmt
	 * @return String
	 */
	public String getWhen(String fmt) {
		return new java.text.SimpleDateFormat(fmt).format(getWtime());
	}

	/**
	 * Sets the bcomment.
	 * @param bcomment  The bcomment to set
	 */
	public void setBcomment(String bcomment) {
		this.bcomment = bcomment;
	}

	/**
	 * Sets the mseq.
	 * @param mseq  The mseq to set
	 */
	public void setMseq(int mseq) {
		this.mseq = mseq;
	}

	/**
	 * Sets the seq.
	 * @param seq  The seq to set
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}

	/**
	 * Sets the writer.
	 * @param writer  The writer to set
	 */
	public void setWriter(String writer) {
		this.writer = writer;
	}

	/**
	 * Sets the wtime.
	 * @param wtime  The wtime to set
	 */
	public void setWtime(Timestamp wtime) {
		this.wtime = wtime;
	}

	/**
	 * 메모글 ip를 반환합니다.
	 * @return  ip
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * 메모글 ip를 설정합니다.
	 * @param  string
	 */
	public void setIp(String string) {
		ip = string;
	}

	/**
	 * id 반환
	 * @return  id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param  id
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @param sid
	 */
	public void setSid(long sid) {
		this.sid = sid;
	}

	/**
	 * @return
	 */
	public long getSid() {
		return sid;
	}

}
