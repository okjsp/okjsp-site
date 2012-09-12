package kr.pe.okjsp;

public class Tag {
	/**
	 * @uml.property  name="tagseq"
	 */
	int tagseq;
	/**
	 * @uml.property  name="tag"
	 */
	String tag;
	/**
	 * @uml.property  name="cnt"
	 */
	int cnt;
	/**
	 * @uml.property  name="seq"
	 */
	int seq;
	/**
	 * @uml.property  name="id"
	 */
	String id;
	/**
	 * @return
	 * @uml.property  name="cnt"
	 */
	public int getCnt() {
		return cnt;
	}
	/**
	 * @param cnt
	 * @uml.property  name="cnt"
	 */
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	/**
	 * @return
	 * @uml.property  name="id"
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id
	 * @uml.property  name="id"
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return
	 * @uml.property  name="seq"
	 */
	public int getSeq() {
		return seq;
	}
	/**
	 * @param seq
	 * @uml.property  name="seq"
	 */
	public void setSeq(int seq) {
		this.seq = seq;
	}
	/**
	 * @return
	 * @uml.property  name="tag"
	 */
	public String getTag() {
		return tag;
	}
	/**
	 * @param tag
	 * @uml.property  name="tag"
	 */
	public void setTag(String tag) {
		this.tag = tag;
	}
	/**
	 * @return
	 * @uml.property  name="tagseq"
	 */
	public int getTagseq() {
		return tagseq;
	}
	/**
	 * @param tagseq
	 * @uml.property  name="tagseq"
	 */
	public void setTagseq(int tagseq) {
		this.tagseq = tagseq;
	}
}