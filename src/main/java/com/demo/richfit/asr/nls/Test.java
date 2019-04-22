package com.demo.richfit.asr.nls;

import java.io.InputStream;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String appKey = "QygVGKjy3t2cMlOD";
		String token = "f69156cbefb14b429daee5b43eefec2c";

		SpeechTranscriberDemo demo = new SpeechTranscriberDemo(appKey, token);
		InputStream ins = SpeechTranscriberDemo.class.getResourceAsStream("/nls-sample-16k.wav");
		if (null == ins) {
			System.err.println("open the audio file failed!");
			return;
		}
		demo.process(ins);
		demo.shutdown();
	}

}
