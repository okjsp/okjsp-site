package kr.pe.okjsp;

public class Lap {
	static long last;

	public static void log(int i) {
		long now = System.currentTimeMillis();
		System.out.println(i + " : " + (now - last) / 1000.0);
		last = now;
	}
	

}
