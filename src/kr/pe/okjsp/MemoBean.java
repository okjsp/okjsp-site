package kr.pe.okjsp;

import java.sql.Timestamp;

import kr.pe.okjsp.util.*;

/**
 * @author  kenu  Memo 정보를 담아두는 Bean
 */
public class MemoBean {
    /**
	 * @uml.property  name="seq"
	 */
    private int seq;
    /**
	 * @uml.property  name="mseq"
	 */
    private int mseq;
    /**
	 * @uml.property  name="id"
	 */
    private String id;
    /**
	 * @uml.property  name="writer"
	 */
    private String writer;
    /**
	 * @uml.property  name="bcomment"
	 */
    private String bcomment;
    /**
	 * @uml.property  name="wtime"
	 */
    private Timestamp wtime;
    /**
	 * @uml.property  name="ip"
	 */
    private String ip;

	/**
	 * Returns the bcomment.
	 * @return  String
	 * @uml.property  name="bcomment"
	 */
	public String getBcomment() {
		return bcomment;
	}

	/**
	 * Returns the mseq.
	 * @return  int
	 * @uml.property  name="mseq"
	 */
	public int getMseq() {
		return mseq;
	}

	/**
	 * Returns the seq.
	 * @return  int
	 * @uml.property  name="seq"
	 */
	public int getSeq() {
		return seq;
	}

	/**
	 * Returns the writer.
	 * @return  String
	 * @uml.property  name="writer"
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
	 * @uml.property  name="wtime"
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
	 * @uml.property  name="bcomment"
	 */
	public void setBcomment(String bcomment) {
		this.bcomment = bcomment;
	}

	/**
	 * Sets the mseq.
	 * @param mseq  The mseq to set
	 * @uml.property  name="mseq"
	 */
	public void setMseq(int mseq) {
		this.mseq = mseq;
	}

	/**
	 * Sets the seq.
	 * @param seq  The seq to set
	 * @uml.property  name="seq"
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}

	/**
	 * Sets the writer.
	 * @param writer  The writer to set
	 * @uml.property  name="writer"
	 */
	public void setWriter(String writer) {
		this.writer = writer;
	}

	/**
	 * Sets the wtime.
	 * @param wtime  The wtime to set
	 * @uml.property  name="wtime"
	 */
	public void setWtime(Timestamp wtime) {
		this.wtime = wtime;
	}

	/**
	 * 메모글 ip를 반환합니다.
	 * @return  ip
	 * @uml.property  name="ip"
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * 메모글 ip를 설정합니다.
	 * @param  string
	 * @uml.property  name="ip"
	 */
	public void setIp(String string) {
		ip = string;
	}

	/**
	 * id 반환
	 * @return  id
	 * @uml.property  name="id"
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param  id
	 * @uml.property  name="id"
	 */
	public void setId(String id) {
		this.id = id;
	}

}
