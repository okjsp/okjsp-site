package kr.pe.okjsp.android;

import java.util.ArrayList;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.drawable.Drawable;

import com.google.android.maps.ItemizedOverlay;
import com.google.android.maps.OverlayItem;

public class NearByItemizedOverlay extends ItemizedOverlay {
	private Context context;
	private ArrayList<OverlayItem> overlayList = new ArrayList<OverlayItem>();

	public NearByItemizedOverlay(Drawable defaultMarker,Context context) {
		super(boundCenterBottom(defaultMarker));
		this.context = context;
	}

	@Override
	protected OverlayItem createItem(int i) {
		return overlayList.get(i);
	}

	@Override
	public int size() {
		return overlayList.size();
	}

	public void addOverlay(OverlayItem overlay) {
		overlayList.add(overlay);
		populate();
	}

	@Override
	protected boolean onTap(int index)
	{
		OverlayItem item = overlayList.get(index);
		AlertDialog.Builder dialog = new AlertDialog.Builder(context);
		dialog.setTitle(item.getTitle());
		dialog.setMessage(item.getSnippet());
		dialog.show();
		return true;
	}
}
