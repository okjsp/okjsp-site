package kr.pe.okjsp.test;

import java.awt.Color;
import java.awt.Font;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Image;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Acme.JPM.Encoders.GifEncoder;

public class OkGraphServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		//			계산
		//			난수 발생
		double[] num = new double[10];
		for (int i = 0; i < num.length; i++) {
			num[i] = Math.random() * 100;
		}
		//			최대값
		double max = num[0];
		for (int i = 1; i < num.length; i++) {
			if (max < num[i])
				max = num[i];
		}

		int margin = 10;
		float x_pace = (300 - margin * 2) / (float) 10;
		float y_height = (float) (200 - margin * 2);
		double ratio = y_height / max;

		Frame frame = null;
		Graphics g = null;

		try {
			// Create an unshown frame
			frame = new Frame();
			frame.addNotify();

			// Get a graphics region, using the Frame
			Image image = frame.createImage(300, 200);
			// image size width 300, height 200
			g = image.getGraphics();

			g.setColor(new Color(0x0040FF));
			g.setFont(new Font("System", Font.PLAIN, 11));
			g.drawString("www.okjsp.pe.kr", 210, 198);
			g.drawString("Max:" + max, 10, 198);

			//			draw Bars
			int xx = 0;
			int yy = 0;

			g.setColor(new Color(0x000000));
			g.drawRect(0, 0, 299, 199);
			for (int i = 0; i < num.length; i++) {
				xx = (int) (i * x_pace) + margin;
				yy = (int) (num[i] * ratio);
				yy = 200 - (yy + margin);

				g.drawRect(xx, yy, (int) x_pace - 3, 188 - yy);
				g.drawString("" + (int) num[i], xx + 9, yy);
			}

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