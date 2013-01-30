package kr.pe.okjsp.rss;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import kr.pe.okjsp.util.StringHelper;

/**
 * RSS Feed �� local�� �������ִ� ���
 * @author kenu
 *
 */
public class RSSProxy {
	private static final long CACHE_TIME = 60 * 60 * 1000L;
	static Map<String, String> pool = new HashMap<String, String>();
	/**
	 * RSS feed�� �����ɴϴ�. �⺻charset�� utf-8 �Դϴ�. cached
	 *
	 * @param urlPath RSS URL path
	 * @return feed String
	 * @throws IOException
	 */
	public static String getCachedXML(String urlPath, String refresh) throws IOException {
		return getCachedXML(urlPath, "utf-8", refresh);
	}

	/**
	 * RSS feed�� ���ǿ� ���� Cache �Ǵ� ���� ȣ���� �´�.
	 * ���� 1. feed�� null�� ��� /
	 * ���� 2. CACHE_TIME ���� ������ ��� /
	 * ���� 3. ��� ���� �Ķ���� refresh���� "1"�� ���
	 * @param urlPath
	 * @param charset
	 * @param refresh "1" for refresh data
	 * @return feed String
	 * @throws IOException
	 */
	public static String getCachedXML(String urlPath, String charset, String refresh) throws IOException {
		String feed = (String)pool.get(urlPath);
		String lastTime = (String)pool.get(urlPath+"t");

		long now = System.currentTimeMillis();
		boolean isRefresh = (feed == null) 
						|| isOverCacheTime(lastTime, now)
						|| "1".equals(refresh);
		if (isRefresh) {
			feed = getXML(urlPath, "utf-8");
			if (feed.length() != 0) {
				pool.put(urlPath, feed);
				pool.put(urlPath+"t", String.valueOf(now));
			}
		}
		return feed;
	}

	/**
	 * urlParh�� ĳ�õ� �ð��� �����ֱ� CacheTime�� ������ true
	 * @param urlPath
	 * @param now
	 * @return
	 */
	private static boolean isOverCacheTime(String lastTime, long now) {
		if (lastTime == null) lastTime = "0";
		long diff = now - Long.parseLong(lastTime);
		boolean isOverPeriod = diff > CACHE_TIME;
		return isOverPeriod;
	}

	/**
	 * charset�� ���� RSS feed�� �����ɴϴ�.
	 *
	 * @param urlPath
	 * @param charset
	 * @return feed
	 * @throws IOException
	 */
	public static String getXML(String urlPath, String charset) throws IOException {
		InputStream openStream = new URL(StringHelper.getURLString(urlPath)).openStream();
		InputStreamReader isr = new InputStreamReader(openStream, charset);

		StringBuffer sb = new StringBuffer();
		int c;
		while ((c = isr.read()) != -1) {
			sb.append((char) c);
		}
		isr.close();
		openStream.close();
		return sb.toString();
	}
}
