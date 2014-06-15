package kr.pe.okjsp.tag;

import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import kr.pe.okjsp.util.CommonUtil;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * 검색어를 표시하는 태그
 */
public class MarkTag extends BodyTagSupport
{
    private String word = "";
    public int doEndTag() throws JspException {

        if( bodyContent == null )
            return EVAL_PAGE;

        try {
            String text = bodyContent.getString();
			StringBuffer sbuf = new StringBuffer();
            if( word != null && word.length() > 0 ) {
				word =
					CommonUtil.rplc(
						CommonUtil.rplc(CommonUtil.rplc(word, "[", "\\["), ")", "\\)"),
						"(", "\\(");

				int start = 0;
				int lastEnd = 0;

				Pattern p = Pattern.compile( word , Pattern.CASE_INSENSITIVE );
				Matcher m = p.matcher( text );
				while( m.find() ) {
					start = m.start();
					sbuf.append( text.substring(lastEnd, start) )
						.append("<font class='search'>"+m.group()+"</font>" );
					lastEnd = m.end();
				} 
				text = sbuf.append(text.substring(lastEnd)).toString();
            }
            pageContext.getOut().print(text);
        } catch (IOException e) {
            throw new JspException(e.toString());
        }

        return EVAL_PAGE;
    }

    /**
	 * @param word
	 * @uml.property  name="word"
	 */
    public void setWord(String word) {
        this.word = word;
    }
}
