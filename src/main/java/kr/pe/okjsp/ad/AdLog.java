package kr.pe.okjsp.ad;

import java.util.Date;

public class AdLog {
	private long lseq;
	private Date credate;
	private String url;
	private String referer;
	private long sid;
	private String ip;
	public long getLseq() {
		return lseq;
	}
	public void setLseq(long lseq) {
		this.lseq = lseq;
	}
	public Date getCredate() {
		return credate;
	}
	public void setCredate(Date credate) {
		this.credate = credate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getReferer() {
		return referer;
	}
	public void setReferer(String referer) {
		this.referer = referer;
	}
	public long getSid() {
		return sid;
	}
	public void setSid(long sid) {
		this.sid = sid;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}

}
