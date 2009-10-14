package kr.pe.okjsp.member;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class MemberDao {

	@SuppressWarnings("unchecked")
	public List<Member> getAllList() throws SQLException {
		SqlMapClient sqlMapper;

		try {
			Reader reader = Resources.getResourceAsReader("sql/SqlMapConfig.xml");
			sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		} catch (IOException e) {
			// Fail fast.
			throw new RuntimeException(
					"Something bad happened while building the SqlMapClient instance."
							+ e, e);
		}

	    return sqlMapper.queryForList("selectAllMembers");
	}

}
