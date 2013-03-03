package kr.pe.okjsp.member;

import kr.pe.okjsp.Article;

public class TestObject {
	public static Member getTestMember() {
		Member member = new Member();
		member.setSid(3582);
		member.setId("kenu1");
		return member;
	}

	public static Article getTestArticle(Member member) {
		Article article = new Article();
		article.setBbs("recruit");
		article.setSubject("subject");
		article.setId(String.valueOf(member.getSid()));
		article.setSid(member.getSid());
		article.setContent("content");
		article.setWriter(member.getId());
		return article;
	}

	public static void deleteTestData() {
		Member member = TestObject.getTestMember();
		new PointDao().deletePoint(member.getSid());
	}

}
