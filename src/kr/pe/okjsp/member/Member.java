package kr.pe.okjsp.member;

import java.util.ArrayList;
import java.util.Date;

import kr.pe.okjsp.util.CommonUtil;

/**
 * @author  kenu
 */
public class Member {
	/**
	 * @uml.property  name="id"
	 */
	private String id;
	/**
	 * @uml.property  name="name"
	 */
	private String name;
	/**
	 * @uml.property  name="password"
	 */
	private String password;
	/**
	 * @uml.property  name="email"
	 */
	private String email;
	/**
	 * @uml.property  name="homepage"
	 */
	private String homepage;
	/**
	 * @uml.property  name="joindate"
	 */
	private Date   joindate;
	/**
	 * @uml.property  name="profile"
	 */
	private String profile;
	/**
	 * @uml.property  name="mailing"
	 */
	private String mailing;
	/** 
	 * @uml.property name="point"
	 */
	private long point;
	/**
	 * @uml.property  name="sid"
	 */
	private long sid;
	/**
	 * @uml.property  name="role"
	 */
	private ArrayList<String>   role;
	

	public Member() {}

// setters
	/**
	 * @param id
	 * @uml.property  name="id"
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @param name
	 * @uml.property  name="name"
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @param role
	 * @uml.property  name="role"
	 */
	public void setRole(ArrayList<String> role) {
		this.role = role;
	}

	/**
	 * @param email
	 * @uml.property  name="email"
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * Sets the homepage.
	 * @param homepage  The homepage to set
	 * @uml.property  name="homepage"
	 */
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	/**
	 * Sets the password.
	 * @param password  The password to set
	 * @uml.property  name="password"
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @param  date
	 * @uml.property  name="joindate"
	 */
	public void setJoindate(Date date) {
		joindate = (Date) date.clone();
	}
	/**
	 * @param  profile
	 * @uml.property  name="profile"
	 */
	public void setProfile(String profile) {
		this.profile = profile;
	}


// getters
	/**
	 * @return
	 * @uml.property  name="id"
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * @return
	 * @uml.property  name="name"
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * @return
	 * @uml.property  name="role"
	 */
	public ArrayList<String> getRole() {
		return this.role;
	}

	/**
	 * @return
	 * @uml.property  name="email"
	 */
	public String getEmail() {
		return this.email;
	}

	/**
	 * Returns the homepage.
	 * @return  String
	 * @uml.property  name="homepage"
	 */
	public String getHomepage() {
		return homepage;
	}


	/**
	 * Returns the password.
	 * @return  String
	 * @uml.property  name="password"
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Returns the joindate.
	 * @return  Date
	 * @uml.property  name="joindate"
	 */
	public String getJoindate() {
		return CommonUtil.formatDate(joindate, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * @return  profile
	 * @uml.property  name="profile"
	 */
	public String getProfile() {
		return profile;
	}


	/**
	 * @return
	 * @uml.property  name="mailing"
	 */
	public String getMailing() {
		return (mailing == null) ? "N" : mailing;
	}

	/**
	 * @param mailing
	 * @uml.property  name="mailing"
	 */
	public void setMailing(String mailing) {
		this.mailing = mailing;
	}

	/** 
	 * @uml.property  name="point"
	 */
	public long getPoint() {
		return point;
	}

	/**
	 * Setter of the property <tt>point</tt>
	 * @param point  The point to set.
	 * @uml.property  name="point"
	 */
	public void setPoint(long point) {
		this.point = point;
	}

	/**
	 * Getter of the property <tt>sid</tt>
	 * @return  Returns the sid.
	 * @uml.property  name="sid"
	 */
	public long getSid() {
		return sid;
	}

	/**
	 * Setter of the property <tt>sid</tt>
	 * @param sid  The sid to set.
	 * @uml.property  name="sid"
	 */
	public void setSid(long sid) {
		this.sid = sid;
	}

}
