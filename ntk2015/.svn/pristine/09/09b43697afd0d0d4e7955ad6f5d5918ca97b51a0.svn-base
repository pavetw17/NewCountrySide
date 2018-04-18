/*
 * Copyright(C) 2008, NTT AT Co., Ltd.
 * Project: AWGView
 *
 * Notes:
 *  N/A
 *
 * Record of change:
 * Date         Version      Name       Content
 * 2008/12/15   1.0          TriNT      First create       
 */
package com.cwrs.ntk.common.old;

import java.awt.Color;
import java.util.Properties;

import com.cwrs.ntk.common.Utils;

/**
 * Class name : Config <BR>
 * Package : jp.co.ntt_at.awgview.server.common <BR>
 * 
 * Description : Utility function to store the config information <BR>
 * 
 * @author : AI&T
 * @version : 1.0
 */
public class Config {

	private static Properties prop = null;
	
	private static String psql_username = null;
	private static String psql_pass     = null;
	private static String psql_dbname   = null;
	private static String psql_host     = null;
	private static String psql_port     = null;
	
	//colors
	public static Color colorBorderRenderNDVI = new Color(255,0,255);
	public static Color colorBorderRenderGDST = new Color(255,0,255);
	

	/**
	 * Empty constructor
	 */
	public Config() {
		
	}

	/**
	 * Decode color from string 
	 * @param s: vd 255,0,0
	 * @return
	 */
	private static Color decodeColor(String s){
		Color c = null;
		try{
			if(s.startsWith("#")){
			  c = Utils.Hex2RGB(s);
			}else {
			  String[] channels = s.split(",");
			  c = new Color(Integer.parseInt(channels[0]),Integer.parseInt(channels[1]),Integer.parseInt(channels[2]));
			}
		 return c;	
		}catch(Exception e){
			
		}
		return new Color(255,255,0);  
	}
	/**
	 * Loads the properties from the source .properties file specified and
	 * over-rides them with those found in the merge file.
	 */
	public static Properties loadFile(String fileName) {
		if(prop != null) return prop;
		prop = Utils.loadFile2Properties(fileName);
		psql_username = getParamConfig("psql_username");
		psql_pass = getParamConfig("psql_pass");
		psql_dbname = getParamConfig("psql_dbname");
		psql_host = getParamConfig("psql_host"); 
		psql_port = getParamConfig("psql_port");
		colorBorderRenderNDVI = decodeColor(getParamConfig("color_border_render_ndvi"));
		colorBorderRenderGDST = decodeColor(getParamConfig("color_border_render_gdst"));
		return prop;
	}
	
	public static String getDBUserName(){
		return psql_username;
	}
	public static String getDBPass(){
		return psql_pass;
	}
	public static String getDBName(){
		return psql_dbname;
	}
	public static String getDBHost(){
		return psql_host;
	}
	public static String getDBPort(){
		return psql_port;
	}

	/**
	 * Get parameter value by parameter name
	 * 
	 * @param paramName
	 * @return paramValue from properties file
	 */
	public static String getParamConfig(String paramName) {
		if (prop != null) {
			String paramValue = prop.getProperty(paramName);
			if (paramValue != null) {
				if (!"".equalsIgnoreCase(paramValue.trim())) {
					return paramValue.trim();
				}
			}
		}
		return null;
	}

	/**
	 * Get parameter is string
	 * 
	 * @param paramName
	 * @return String
	 */
	public static String getString(String paramName) {
		String val = null;
		try {
			val = getParamConfig(paramName);
		} catch (Exception e) {
			// handle exception
		}
		return val;
	}

	/**
	 * Get parameter is long
	 * 
	 * @param paramName
	 * @return long
	 */
	public static long getLong(String paramName) {
		long val = -1;
		try {
			String strValue = getParamConfig(paramName);
			val = Long.valueOf(strValue);
		} catch (Exception e) {
			// handle exception
			//LogWriter.getSNMPLogger().error(e.toString());
		}
		return val;
	}

	/**
	 * Get parameter is Int.
	 * 
	 * @param paramName
	 * @param defaultValue
	 * @return int
	 */
	public static int getInt(String paramName, int defaultValue) {
		return Utils.parseInt(Config.getParamConfig(paramName), defaultValue);
	}

	/**
	 * Get parameter is boolean.
	 * 
	 * @param paramName
	 * @param defaultValue
	 * @return boolean
	 */
	public static boolean getBoolean(String paramName, boolean defaultValue) {
		boolean result = defaultValue;
		String StringTemp = Config.getParamConfig(paramName);
		if ((StringTemp != null) && (StringTemp.trim().length() > 0)) {
			StringTemp = StringTemp.trim();
			if ("true".equalsIgnoreCase(StringTemp)) {
				result = true;
			} else if ("false".equalsIgnoreCase(StringTemp)) {
				result = false;
			} else {
				// todo nothing
			}
		}
		return result;
	}
}
