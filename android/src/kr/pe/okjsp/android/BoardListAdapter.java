package kr.pe.okjsp.android;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import kr.pe.okjsp.BbsInfoBean;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class BoardListAdapter extends BaseAdapter
{
	ArrayList<BbsInfoBean> boardList;
	LayoutInflater Inflater;
	Context context;
	int layout;
	
	public BoardListAdapter(Context context, int hLayout, ArrayList<BbsInfoBean> items)
	{
		this.context = context;
		Inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.boardList = items;
		this.layout = hLayout;
	}
	
	@Override
    public int getCount() {
	    return boardList.size();
    }
	
	@Override
    public Object getItem(int position) {
	    return boardList.get(position);
    }

	@Override
    public long getItemId(int position) {
	    return position;
    }
	
    @Override
	public View getView(int position, View convertView, ViewGroup parent) {
    	final int pos = position;
    	
    	if(convertView == null)
    	{
    		convertView = Inflater.inflate(layout, parent, false);
    	}
		
    	BbsInfoBean bbsInfoBean = boardList.get(position);
    	TextView boardName = (TextView) convertView.findViewById(R.id.boardName);
    	boardName.setText(bbsInfoBean.getName());
    	
		return convertView;
	}
	
}
