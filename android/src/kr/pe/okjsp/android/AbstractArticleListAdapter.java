package kr.pe.okjsp.android;

import java.util.ArrayList;

import kr.pe.okjsp.Article;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

public class AbstractArticleListAdapter extends BaseAdapter
{
	ArrayList<Article> artList;
	LayoutInflater Inflater;
	Context context;
	int layout;
	
	public AbstractArticleListAdapter(Context context, int hLayout, ArrayList<Article> items)
	{
		this.context = context;
		Inflater = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		this.artList = items;
		this.layout = hLayout;
	}
	
	@Override
    public int getCount() {
	    return artList.size();
    }

	@Override
    public Object getItem(int position) {
	    return artList.get(position).getId();
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
		
    	Article article = artList.get(position);
    	
    	TextView subject = (TextView) convertView.findViewById(R.id.subject);
    	TextView writer = (TextView) convertView.findViewById(R.id.writer);
    	TextView date = (TextView) convertView.findViewById(R.id.date);
    	TextView hit = (TextView) convertView.findViewById(R.id.hit);
    	
    	subject.setText(article.getSubject());
    	writer.setText(article.getId());
    	date.setText(article.getDate());
    	hit.setText("");
    	
		return convertView;
	}
	
}
