package kr.pe.okjsp;

import java.util.ResourceBundle;

import javax.servlet.http.*;

/**
 * <pre>
 * 큐브리드에서 이 pool을 사용하면 성능이 안나온다.
 * 그리고 log4sql을 사용할때 select now() 쿼리를 날려서 에러가 발생된다.
 * </pre>
 * @deprecated MySQL에서 CUBRID로 디비 마이그레이션을 하면서 JDCPool을 사용하지 않습니다.
 * @author 서영아빠
 *
 */
public class PopDb extends HttpServlet {

	static {
		try {
			ResourceBundle rb = ResourceBundle.getBundle("kr.pe.okjsp.DB");
			new pool.JDCConnectionDriver(
				rb.getString("DRIVER"),
				rb.getString("DBURL"),
				rb.getString("DBUSER"),
				rb.getString("DBPASS"));
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
}