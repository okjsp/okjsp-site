package kr.pe.okjsp.util;

public class HttpLinker {

	/**
	 * url 링크가 된 소스를 반환한다.
	 * 
	 * @param source
	 * @return
	 */
	public static String getLinkedSource(String source) {
		int lastIdxStart = 0;
		String pre = source;
		String output = "";
		while ((lastIdxStart = source.toLowerCase().lastIndexOf("http://")) > -1) {
			if (lastIdxStart == -1) {
				return source;
			}
			int lastIdxEndTag = source.indexOf("<", lastIdxStart);
			int lastIdxEnd = source.indexOf(" ", lastIdxStart);
			if (lastIdxEnd == -1) {
				lastIdxEnd = source.indexOf("\n", lastIdxStart);
			}
			if (lastIdxEnd != -1 && lastIdxEndTag != -1) {
				lastIdxEnd = Math.min(lastIdxEnd, lastIdxEndTag);
			}
			if (lastIdxEnd == -1) {
				lastIdxEnd = source.length();
			}
			boolean hasLink = source.indexOf("</a>", lastIdxStart) != -1;
			boolean hasIframe = source.indexOf("</iframe>", lastIdxStart) != -1;
			boolean hasEmbed = source.indexOf("</embed>", lastIdxStart) != -1;
			if (hasLink) {
				String tag = "a";
				int lastIndexOf = source.lastIndexOf("<" + tag + " ");
				pre = source.substring(0, lastIndexOf);
				output = source.substring(lastIndexOf) + output;
				source = pre;

			} else if (hasIframe) {
				String tag = "iframe";
				int lastIndexOf = source.lastIndexOf("<" + tag + " ");
				pre = source.substring(0, lastIndexOf);
				output = source.substring(lastIndexOf) + output;
				source = pre;

			} else if (hasEmbed) {
				String tag = "embed";
				int lastIndexOf = source.lastIndexOf("<" + tag + " ");
				pre = source.substring(0, lastIndexOf);
				output = source.substring(lastIndexOf) + output;
				source = pre;
				
			} else {
				String url = source.substring(lastIdxStart, lastIdxEnd).trim();
				pre = source.substring(0, lastIdxStart);
				String post = source.substring(lastIdxEnd);

				output = "<a href=\"" + url + "\" target=\"_blank\">" + url
						+ "</a>" + post + output;
				source = pre;
			}
		}
		return pre + output;
	}
}