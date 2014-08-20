/*----------------------------------------------------------------------------

 Thumbnailer.java

 @author 허광남

 ----------------------------------------------------------------------------*/

package kr.pe.okjsp.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

public class Thumbnailer {
	private Image inImage;
	private String thumb;
	private int maxX;
	private int maxY;
	private int margin;

	/**
	 * Method Thumbnailer.
	 * 
	 * @param orig
	 * @param thumb
	 * @param xx
	 * @param yy
	 */
	// 생성자
	public Thumbnailer(String orig, String thumb, int xx, int yy) {
		this.inImage = new ImageIcon(orig).getImage();
		this.thumb = thumb;
		this.maxX = xx;
		this.maxY = yy;
		this.margin = 0;
	}

	// 작은 이미지를 만든다.
	public void createThumbnail() {
		// Determine the scale.
		double scaleX = (double) (maxX - margin * 2) / inImage.getWidth(null);
		double scaleY = (double) (maxY - margin * 2) / inImage.getHeight(null);
		double scale = scaleX;
		if (scaleX > scaleY) {
			scale = scaleY;
		}

		// Determine size of new image.
		// One of them should equal maxDim.
		int scaledW = (int) (scale * inImage.getWidth(null));
		int scaledH = (int) (scale * inImage.getHeight(null));

		// Create an image buffer in which to paint on.
		BufferedImage outImage = new BufferedImage(maxX, maxY,
				BufferedImage.TYPE_INT_RGB);

		// Set the scale.
		AffineTransform tx = new AffineTransform();

		// If the image is smaller than the desired image size,
		// don't bother scaling.
		tx.scale(scale, scale);
		AffineTransform toCenterAt = new AffineTransform();
		int startx = (maxX - scaledW) / 2;
		int starty = (maxY - scaledH) / 2;
		toCenterAt.translate(startx, starty);
		toCenterAt.concatenate(tx);

		// Paint image.
		Graphics2D g2d = outImage.createGraphics();
		RenderingHints qualityHints = new RenderingHints(
				RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
		qualityHints.put(RenderingHints.KEY_RENDERING,
				RenderingHints.VALUE_RENDER_QUALITY);
		g2d.setRenderingHints(qualityHints);
		g2d.fillRect(0, 0, maxX, maxY);
		g2d.drawImage(inImage, toCenterAt, null);

		g2d.dispose();

		// JPEG-encode the image and write to file.
		try {
			ImageIO.write(outImage, "jpg", new File(thumb));
		} catch (IOException e) {
			System.out.println(e);
		}
	}
}
