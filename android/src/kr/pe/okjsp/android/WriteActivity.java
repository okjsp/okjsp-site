package kr.pe.okjsp.android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.pe.okjsp.util.HttpClient;
import kr.pe.okjsp.util.LoginHelper;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

public class WriteActivity extends Activity
{
	private String[] array_spinner_bbs;
	private ArrayList<String> array_spinner_ccl;
	private List<NameValuePair> nameValuePairs;
	private Button btn_reg;
	private Button btn_list;
	private EditText writer;
	private EditText homepage;
	private EditText password;
	private EditText subject;
	private EditText content;
	private Spinner bbs;
	private Spinner ccl_id;
	private String boardName = "";
	
	HashMap<String,String> mapBBS;
	HashMap<String,String> mapCCL;
	ArrayList<String> arrayBBS = new ArrayList<String>();
	ArrayAdapter bbsAdapter;
	Spinner s_bbs;
	Spinner s_ccl;
	
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.write);
        
        setBbsInfo();
        setCclInfo();
        
        btn_reg 	 = (Button)   findViewById(R.id.btnSend);
        btn_list 	 = (Button)   findViewById(R.id.btnCancle);
        writer 		 = (EditText) findViewById(R.id.writer);
        homepage 	 = (EditText) findViewById(R.id.homepage);
        password 	 = (EditText) findViewById(R.id.password);
        subject 	 = (EditText) findViewById(R.id.subject);
        content 	 = (EditText) findViewById(R.id.content);
        bbs 	 	 = (Spinner)  findViewById(R.id.bbs);
        ccl_id 	     = (Spinner)  findViewById(R.id.ccl_id);
        
        Spinner s_bbs = (Spinner) findViewById(R.id.bbs);
        s_bbs.setPrompt("선택하세요");
        bbsAdapter = new ArrayAdapter(this,android.R.layout.simple_spinner_item,arrayBBS);
        s_bbs.setAdapter(bbsAdapter);
        setInit();
        
        Spinner s_ccl = (Spinner) findViewById(R.id.ccl_id);
        s_bbs.setPrompt("선택하세요");

        
        ArrayAdapter adapterCcl = new ArrayAdapter(this,android.R.layout.simple_spinner_item, array_spinner_ccl);
        s_ccl.setAdapter(adapterCcl);
        
       
        
        btn_reg.setOnClickListener(clickListener);
//      btn_list.setOnClickListener(clickListener);
        
//      LoginDialog loginDialog = new LoginDialog((Activity)this);
//      loginDialog.createLoginDialog();
        LoginHelper.doLogin(this,true);
	}

	private void setInit()
	{
		Object object = ActivityHelper.getParameter(this,"boardName");
		if( object != null )
		{
			setBoardName((String)object);
		}
	    writer.setText("");
	    homepage.setText("");
	    password.setText("");
	    subject.setText("");
	    content.setText("");
	    bbs.setSelection(0);
	    ccl_id.setSelection(0);
	}
	
	public void setCclInfo()
	{
		array_spinner_ccl = new ArrayList<String>();
        array_spinner_ccl.add("Copyright-저작자에게 저작권");
        array_spinner_ccl.add("CCL-저작자표시");
        array_spinner_ccl.add("CCL-저작자표시-동일조건변경허락");
        array_spinner_ccl.add("CCL-저작자표시-변경금지");
        array_spinner_ccl.add("CCL-저작자표시-비영리");
        array_spinner_ccl.add("CCL-저작자표시-비영리-동일조건변경허락");
        array_spinner_ccl.add("CCL-저작자표시-비영리-변경금지");
        
	}
	
	public void setBbsInfo()
	{
		mapBBS = new HashMap<String, String>();
		mapBBS.put("html5","HTML5");
	    mapBBS.put("techtrend","TECH TREND");
	    mapBBS.put("lecture","강좌");
	    mapBBS.put("TOOL","개발툴");
	    mapBBS.put("TOOLqna","개발툴 QnA");
	    mapBBS.put("ajax","Ajax");
	    mapBBS.put("ajaxqna","Ajax QnA");
	    mapBBS.put("bbs2","DB Tips");
	    mapBBS.put("bbs1","DB QnA");
	    mapBBS.put("bbs4","JSP Tips");
	    mapBBS.put("bbs3","JSP QnA");
	    mapBBS.put("weblogic","j2ee Tips");
	    mapBBS.put("weblgqna","j2ee QnA");
	    mapBBS.put("xmltip","XML Tips");
	    mapBBS.put("xmlqna","XML QnA");
	    mapBBS.put("ruby","Ruby on Rails");
	    mapBBS.put("rubyqna","Ruby on Rails QnA");
	    mapBBS.put("flex","Flex");
	    mapBBS.put("flexqna","Flex QnA");
	    mapBBS.put("bbs7","소스자료실");
	    mapBBS.put("docs","문서자료실");
	    mapBBS.put("etc","기타자료실");
	    mapBBS.put("bbs6","사는 얘기");
	    mapBBS.put("japanlife","일본사는얘기");
	    mapBBS.put("bbs5","머리식히는 곳");
	    mapBBS.put("movie","movie story");
	    mapBBS.put("howmuch","얼마면돼");
	    mapBBS.put("lifeqna","의견좀...");
	    mapBBS.put("news","뉴스따라잡기");
	    mapBBS.put("solo","싱글의 미학");
	    mapBBS.put("recruit","구인/구직/홍보");
	    mapBBS.put("engdocs","english bbs");
	    mapBBS.put("krtomcat","번역");
	    mapBBS.put("link","추천사이트");
	    mapBBS.put("goodjob","좋은회사");
	    mapBBS.put("market","장터");
	    mapBBS.put("model2jsp","모델2JSP책관련");
	    mapBBS.put("notice","공지사항");
	    mapBBS.put("okboard","자료실문답");
	    mapBBS.put("useful","유용한 정보");
	    mapBBS.put("mac","맥 정보");
	    mapBBS.put("ihaveadream","정부는 개발자를 위해");
	    mapBBS.put("javastudy","프로그램기초스터디");
	    mapBBS.put("ns","자바패턴1기");
	    mapBBS.put("dbstudy","DB스터디");
	    mapBBS.put("springstudy","스프링 스터디");
	    mapBBS.put("xf","SLF");
	    mapBBS.put("twitter","트위터");
	    mapBBS.put("trash","짬통");
	    
	    for( String value : mapBBS.values() )
	    	arrayBBS.add(value);
	}
	
	Button.OnClickListener clickListener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			switch (v.getId()){
				case R.id.btnSend:
					nameValuePairs = new ArrayList<NameValuePair>();
			        
					String writerString = writer.getText().toString();
					String homepageString = homepage.getText().toString();
					String passwordString = password.getText().toString();
					String subjectString = subject.getText().toString();
					String contentString = content.getText().toString();
					String bbsString =     bbs.getSelectedItem().toString();
					String ccl_idString = ccl_id.getSelectedItem().toString();
					
					if(writerString == null || subjectString ==null || contentString ==null || bbsString ==null)
			        {
						
			        	return;
			        }
					
			        nameValuePairs.add(new BasicNameValuePair("writer",   writerString ));
			        nameValuePairs.add(new BasicNameValuePair("homepage", homepageString ));
			        nameValuePairs.add(new BasicNameValuePair("password",passwordString ));
			        nameValuePairs.add(new BasicNameValuePair("subject",  subjectString));
			        nameValuePairs.add(new BasicNameValuePair("content", contentString ));
			        nameValuePairs.add(new BasicNameValuePair("bbs",   bbsString   ));
			        nameValuePairs.add(new BasicNameValuePair("ccl_id",  ccl_idString ));
			        
//			        nameValuePairs.add(new BasicNameValuePair("writer",   "111"));
//			        nameValuePairs.add(new BasicNameValuePair("homepage", ""));
//			        nameValuePairs.add(new BasicNameValuePair("password", "111"));
//			        nameValuePairs.add(new BasicNameValuePair("subject",  "111"));
//			        nameValuePairs.add(new BasicNameValuePair("content",  "111"));
//			        nameValuePairs.add(new BasicNameValuePair("bbs",      "html5"));
//			        nameValuePairs.add(new BasicNameValuePair("ccl_id",   "0"));
			        
			        String url = "http://okjsp.pe.kr/writemobile"; 
			         /* writer=" 
			        + "123"+"&homepage=&password=" + "" + "&subject=" + "123" + "&content=" + "123" + "&bbs=" + "html5" + "&ccl_id=" + "0";
			        */
			        
			        String html = HttpClient.getContents(url, "EUC-KR","POST",nameValuePairs);
			        TextView text = (TextView) findViewById(R.id.alert);
			        text.setText("글이 등록되었습니다."); 
			        
					break;
				case R.id.btnCancle:
					finish();
					break;
			}
		}
	};
	
	public void setBoardName(String boardName)
	{
		this.boardName = boardName;
		
		String getBoardCaption = mapBBS.get(boardName);
		
		int i=0;
		for( String value : arrayBBS )
		{
	    	if( value.equals(getBoardCaption) )
	    	{
	    		s_bbs.setSelection(i);
	    	}
	    	i++;
		}
	}

	public String getBoardName() {
		return boardName;
	}
}