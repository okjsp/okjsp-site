package kr.pe.okjsp.android;

import java.util.List;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.Handler;
import android.view.Window;
import android.widget.LinearLayout;
import android.widget.ZoomControls;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.Overlay;
import com.google.android.maps.OverlayItem;

public class NearByActivity extends MapActivity
{
	private List<Overlay> overlayList;
	private Drawable drawable;
	private NearByItemizedOverlay itemizedOverlay;
	private MapView mapView; 
	
	@Override
    public void onCreate(Bundle savedInstanceState)
	{
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		super.onCreate(savedInstanceState);
		setContentView(R.layout.nearby);
		
		ActivityHelper.setHeaderProgressBar(this,false);
		ActivityHelper.setNavigationBar(this,3);
		
		setInit();
		setOverlay();
        
		GeoPoint point = setLocation();
		if( point != null )
		{
	        OverlayItem overlayItem = new OverlayItem(point ,"제목", "이건내용인듯;");
	        itemizedOverlay.addOverlay(overlayItem); 
	        overlayList.add(itemizedOverlay);
		}
    }

	private void setOverlay()
	{
		overlayList = mapView.getOverlays(); 
        drawable = this.getResources().getDrawable(R.drawable.icon_marker);
        itemizedOverlay = new NearByItemizedOverlay(drawable,this);
	}

	private GeoPoint setLocation()
	{
		LocationManager locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
		Location location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
		
		if( location == null )
			return null;
		
		int x = (int)(location.getLatitude()*1E6);
		int y = (int)(location.getLongitude()*1E6);
		
		GeoPoint point = new GeoPoint(x,y);
        MapController mapController = mapView.getController();        
        mapController.animateTo(point);
        mapController.setZoom(18);
		return point;
	}

	private void setInit() {
		mapView = (MapView) findViewById(R.id.mapView);
        mapView.setBuiltInZoomControls(true);
	}

	@Override
	protected boolean isRouteDisplayed() {
		return false;
	}
}