package com.cwrs.ntk.docconverter;

public class ConversionThreadManager implements Runnable{
	
	    public void run() {
	        System.out.println("Start ConversionThreadManager...!");
	        while(true){
	        	try {
					Thread.sleep(1000);
					//System.out.println("Hello by ConversionThreadManager...");
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
	        }
	    }

	    public static void main(String args[]) {
	        (new Thread(new ConversionThreadManager())).start();
	    }
}
