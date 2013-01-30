/*
 * Created on 2005. 3. 14.
 */
package kr.pe.okjsp;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ResourceBundle;

import kr.pe.okjsp.member.Member;

/**
 * @author HeoGwangNam
 */
public class BbsRoleHandler {
	private HashMap roleMap;
	/**
	 *
	 */
	public BbsRoleHandler() {
		init();
	}
	void init() {
		if (roleMap == null) {
			roleMap = new HashMap();
			ResourceBundle rb = ResourceBundle.getBundle("kr.pe.okjsp.BBSROLE");
			Enumeration keys = rb.getKeys();
			while (keys.hasMoreElements()) {
				String key = (String) keys.nextElement();
				roleMap.put(key, rb.getString(key));
			}
		}
	}

	/**
	 * @param member
	 * @param bbs
	 * @return valid
	 */
	public boolean getPermission(Member member, String bbs) {
		boolean valid = false;

		String check = (String)roleMap.get(bbs);
		if (check != null) {
			valid = getValidByRole(member, check);
		} else {
			valid = true;
		}
		return valid;
	}

	/**
	 * @param member
	 * @param validRole
	 * @return
	 */
	private boolean getValidByRole(Member member, String validRole) {
		if (member != null && member.getRole() != null) {
		    Iterator iter = member.getRole().iterator();
			while (iter.hasNext()) {
				String role = (String) iter.next();
				if (validRole.equals(role)) {
					return true;
				}
			}
		}
		return false;
	}

}
