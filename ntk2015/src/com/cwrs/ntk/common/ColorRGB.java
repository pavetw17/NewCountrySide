package com.cwrs.ntk.common;

import java.awt.Color;

public class ColorRGB {
 
		public int r;
		public int g;
		public int b;
	   
	    public ColorRGB(){
	    	
	    }
	    public ColorRGB(Color value)
	    {
	        this.r = value.getRed();
	        this.g = value.getGreen();
	        this.b = value.getBlue();
	    }



	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
