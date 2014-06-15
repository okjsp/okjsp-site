package kr.pe.okjsp;

import java.io.*;

/**
 * @author  kenu
 */
public class DownFile {
	/**
	 * @uml.property  name="fseq"
	 */
	private int     fseq;
	/**
	 * @uml.property  name="fileName"
	 */
	private String  fileName;
	/**
	 * @uml.property  name="maskName"
	 */
	private String  maskName;
	/**
	 * @uml.property  name="fileSize"
	 */
	private long    fileSize;
	/**
	 * @uml.property  name="download"
	 */
	private int     download;
	private String  fileExt;
	private boolean isImage;
	private String  path;

    public DownFile() {
        this.fseq     = 0;
        this.fileName = "";
        this.maskName = "";
        this.fileSize = 0;
        this.download = 0;
    }

    public DownFile(int fseq, String fn, String mn, long fs, int d) {
        setFile(fseq, fn, mn, fs, d);
    }

    public DownFile(File f, int cnt) {
		setExt(f.getName());
		this.fileName = f.getName();
		this.maskName = String.valueOf(System.currentTimeMillis() + cnt);
		if (isImageFile()) {
			this.maskName += getExtension();
		}
		this.fileSize = f.length();
		this.download = 0;

		if (f.exists()) {
			path = f.toString().substring(0,
					f.toString().lastIndexOf(File.separator) + 1);
			boolean renameTo = f.renameTo(new File(path + this.maskName));
			if (!renameTo) {
				System.out.println("can't rename");
			}
		}
	}

    public void setFile(int fseq, String fn, String mn, long fs, int d) {
        this.fseq     = fseq;
        this.fileName = fn;
        this.maskName = mn;
        this.fileSize = fs;
        this.download = d;
        setExt(fn);
    }

    /**
	 * @return
	 * @uml.property  name="fseq"
	 */
    public int getFseq() {
        return this.fseq;
    }
    /**
	 * @return
	 * @uml.property  name="fileName"
	 */
    public String getFileName() {
        return this.fileName;
    }
    /**
	 * @return
	 * @uml.property  name="maskName"
	 */
    public String getMaskName() {
        return this.maskName;
    }
    /**
	 * @return
	 * @uml.property  name="fileSize"
	 */
    public long getFileSize() {
        return this.fileSize;
    }
    /**
	 * @return
	 * @uml.property  name="download"
	 */
    public int getDownload() {
        return this.download;
    }

    public void setExt(String fn) {
        int idx;
        if(fn==null
            || (idx=fn.lastIndexOf("."))==-1 )
            this.fileExt = "";
        else
            this.fileExt = fn.substring(idx);
    }

    public String getExtension() {
        return this.fileExt;
    }

    public boolean isImageFile() {
    	this.isImage = this.fileExt.equalsIgnoreCase(".gif")
            || this.fileExt.equalsIgnoreCase(".jpg")
            || this.fileExt.equalsIgnoreCase(".png");
        return this.isImage;
    }

}