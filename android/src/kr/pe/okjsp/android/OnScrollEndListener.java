package kr.pe.okjsp.android;

public interface OnScrollEndListener
{
	public boolean isProcess();
	public boolean isEnded();
	public void setProcess(boolean isProcess);
	public void onEndProcess();
}