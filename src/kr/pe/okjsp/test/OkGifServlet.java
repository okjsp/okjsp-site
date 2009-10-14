package kr.pe.okjsp.test;

import java.awt.Color;
import java.awt.Font;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Image;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Acme.JPM.Encoders.GifEncoder;

public class OkGifServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws IOException {
		Frame frame = null;
		Graphics g = null;

		try {
			// Create an unshown frame
			frame = new Frame();
			frame.addNotify();

			// Get a graphics region, using the Frame
			Image image = frame.createImage(200, 300);
			// image size width 200, height 300
			g = image.getGraphics();

			g.setFont(new Font("Serif", Font.ITALIC, 50));
			g.drawString("JSP", 10, 50);
			g.drawString("Image!", 10, 80);
			g.setColor(new Color(0x0080AA));
			g.setFont(new Font("Garamond", Font.PLAIN, 18));
			g.drawString("www.okjsp.pe.kr", 60, 280);

			// Encode the off screen image into a GIF and send it to the client
			response.setContentType("image/gif");
			GifEncoder encoder =
				new GifEncoder(image, response.getOutputStream());
			encoder.encode();
		} finally {
			// Clean up resources
			if (g != null)
				g.dispose();
			if (frame != null)
				frame.removeNotify();
		}

	}
}