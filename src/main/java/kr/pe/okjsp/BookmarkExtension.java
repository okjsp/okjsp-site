package kr.pe.okjsp;

/**
 * @author  kenu
 */
public class BookmarkExtension extends Bookmark {
	/**
	 * @uml.property  name="count"
	 */
	private int count;
	/**
	 * @uml.property  name="writer"
	 */
	private String writer;

	/**
	 * @return  Returns the count.
	 * @uml.property  name="count"
	 */
	public int getCount() {
		return count;
	}
	/**
	 * @param count  The count to set.
	 * @uml.property  name="count"
	 */
	public void setCount(int count) {
		this.count = count;
	}
	/**
	 * @return  Returns the writer.
	 * @uml.property  name="writer"
	 */
	public String getWriter() {
		return writer;
	}
	/**
	 * @param writer  The writer to set.
	 * @uml.property  name="writer"
	 */
	public void setWriter(String writer) {
		this.writer = writer;
	}
}
