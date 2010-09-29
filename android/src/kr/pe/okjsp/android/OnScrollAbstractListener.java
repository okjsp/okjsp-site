package kr.pe.okjsp.android;

import android.content.Context;
import android.widget.AbsListView;
import android.widget.AbsListView.OnScrollListener;

public class OnScrollAbstractListener implements OnScrollListener
{
	Context context;
	OnScrollEndListener onScrollEndListener;
	
	public OnScrollAbstractListener(Context context,OnScrollEndListener onScrollEndListener)
	{
		this.context = context; 
		this.onScrollEndListener = onScrollEndListener;
	}
	
	@Override
	public void onScroll(AbsListView view, int firstVisibleItem,
			int visibleItemCount, int totalItemCount) {
		
		if( onScrollEndListener == null )
			return;
		
		if( totalItemCount == 0 )
			return;
		
		if( onScrollEndListener.isEnded() )
			return;
		
		if((firstVisibleItem+visibleItemCount)==totalItemCount && ! onScrollEndListener.isProcess())
		{
			onScrollEndListener.onEndProcess();
		}
	}

	@Override
	public void onScrollStateChanged(AbsListView view, int scrollState) {
	}
}
