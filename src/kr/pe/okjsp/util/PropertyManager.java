package kr.pe.okjsp.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertyManager {
	
	static Properties properties;

	private static void load() {
		properties = new Properties();
		File file = new File("/etc/DB.properties");
		try {
			properties.load(new FileInputStream(file));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static String getString(String key) {
		if (properties == null) load();
		return properties.getProperty(key);
	}

}
