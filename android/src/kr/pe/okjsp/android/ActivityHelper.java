package kr.pe.okjsp.android;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.ProgressBar;

public class ActivityHelper
{
	private static ImageView homeButton;
	private static ImageView boardlistButton;
	private static ImageView mypageButton;
	private static ImageView nearbyButton;
	private static ImageView settingButton;
	private static OnClickListener onClickListener;
	
	public static void setHeaderProgressBar(Activity activity,boolean isVisible)
	{
		if( activity == null )
			return;
		
		ProgressBar progressBar = (ProgressBar) activity.findViewById(R.id.progress);
		if( isVisible )
			progressBar.setVisibility(View.VISIBLE);
		else
			progressBar.setVisibility(View.INVISIBLE);
	}
	
	public static void setNavigationBar(Activity activity,int index)
	{
		activity.overridePendingTransition(0,0);
		
		loadNavigationBar(activity);
		setOnClickListener(activity);
		setNavigationBarOnClickListener();
		setNavigationBarSelected(index);
	}

	private static void setNavigationBarOnClickListener()
	{
		homeButton.setOnClickListener(onClickListener);
		boardlistButton.setOnClickListener(onClickListener);
		mypageButton.setOnClickListener(onClickListener);
		nearbyButton.setOnClickListener(onClickListener);
		settingButton.setOnClickListener(onClickListener);
	}

	private static void loadNavigationBar(Activity activity) {
		homeButton = (ImageView) activity.findViewById(R.id.home);
		boardlistButton = (ImageView) activity.findViewById(R.id.boardlist);
		mypageButton = (ImageView) activity.findViewById(R.id.mypage);
		nearbyButton = (ImageView) activity.findViewById(R.id.nearby);
		settingButton = (ImageView) activity.findViewById(R.id.setting);
	}

	private static void setNavigationBarSelected(int index)
	{
		if( index == 0 )
			homeButton.setImageResource(R.drawable.btn_home_selected);
		else if( index == 1 )
			boardlistButton.setImageResource(R.drawable.btn_boardlist_selected);
		else if( index == 2 )
			mypageButton.setImageResource(R.drawable.btn_mypage_selected);
		else if( index == 3 )
			nearbyButton.setImageResource(R.drawable.btn_nearby_selected);
		else if( index == 4 )
			settingButton.setImageResource(R.drawable.btn_setting_selected);
	}
	
	public static void resetNavigation()
	{
		homeButton.setImageResource(R.drawable.btn_home);
		boardlistButton.setImageResource(R.drawable.btn_boardlist);
		mypageButton.setImageResource(R.drawable.btn_mypage);
		nearbyButton.setImageResource(R.drawable.btn_nearby);
		settingButton.setImageResource(R.drawable.btn_setting);
	}
	
	public static void setOnClickListener(final Activity activity)
	{
		onClickListener = new OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				ImageView imageView;
				switch (v.getId())
				{
				case R.id.home:
					{
						Intent intent = new Intent(activity.getApplicationContext(), HomeActivity.class);
						activity.startActivity(intent);
						activity.overridePendingTransition(0,0);
						activity.finish();
					}
					break;
				case R.id.boardlist:
					{
						Intent intent = new Intent(activity.getApplicationContext(), BoardListActivity.class);
						activity.startActivity(intent);
						activity.overridePendingTransition(0,0);
						activity.finish();
					}
					break;
				case R.id.mypage:
					resetNavigation();
					imageView = (ImageView)v;
					imageView.setImageResource(R.drawable.btn_mypage_selected);
					break;
				case R.id.nearby:
					{
						Intent intent = new Intent(activity.getApplicationContext(), NearByActivity.class);
						activity.startActivity(intent);
						activity.overridePendingTransition(0,0);
						activity.finish();
					}
					break;
				case R.id.setting:
    				{
//    					Intent intent = new Intent(activity.getApplicationContext(), Login.class);
//    					activity.startActivity(intent);
//    					activity.overridePendingTransition(0, 0);
//    					activity.finish();
    				}
					break;
				}
			}
		};
	}
	
	public static Object getParameter(Activity activity,String name)
	{
		Intent intent = activity.getIntent();
		if( intent == null )
			return null;
		
		Bundle bundle = intent.getExtras();
		if( bundle == null )
			return null;
		
		return bundle.get(name);
	}
}
