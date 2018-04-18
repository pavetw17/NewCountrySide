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
package com.cwrs.ntk.common;

import com.cwrs.ntk.reporter.GraphComparisonVO;
import org.json.JSONArray;
import org.json.simple.JSONObject;

import java.awt.*;
import java.io.*;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/*
import com.cwrs.dbscl.dataobject.TblRuongGieocay;
import com.cwrs.dbscl.reporter.GraphComparisonVO;
*/



/**
 * Class name : Utils <BR>
 * 
 * Package : jp.co.nttat.awgstar.server.common <BR>
 * 
 * Description: This class provides function to give support <BR>
 * 
 * @author : AI&T
 * @version : 1.0
 */
public class Utils {

	private static final String OS_NAME = "os.name";
	private static final String OS_LINUX = "Linux";
	private static final String LINUX_IFCONFIG_CMD = "ifconfig";
	// see if line contains eth0 MAC address
	private static final String ETH_0 = "eth0";
	// see if line contains MAC address
	private static final String HARD_WARE_ADDR = "HWaddr";	
	public static final String  LINE_SEP = System.getProperty("line.separator");

	public static final String FILE_SEPARATOR = java.io.File.separator;
	
	public static long measure_time =0;
	
	private static DateFormat df = new SimpleDateFormat(Definitions.DATE_FORMAT);
	private static DecimalFormat decimalFormated = new DecimalFormat("#.##");
	
	/*public static void setMeasuretTimeStart(String s){
		System.out.println("======>[START] MEASURE TIME: "+s);
		Calendar now = Calendar.getInstance();
		measure_time = now.getTimeInMillis();
		
	}*/
	public static void setMeasuretTimeStart(String s){
		System.out.println("======>[START] MEASURE TIME: "+s);
		Calendar now = Calendar.getInstance();
		measure_time = now.getTimeInMillis();
		
	}
	public static void printMeasure(){
		Calendar now = Calendar.getInstance();
		
		System.out.println("======>[END] MEASURE TIME: "+"Operation takes " + (now.getTimeInMillis() - measure_time) +"(ms)");
		measure_time = now.getTimeInMillis();
	}
	
	
	
	public static String convertInt2DateString(int intDate){
		long longDate = (long)intDate* Definitions.TIME_OF_DAY_MSEC;
		Date date = new Date(longDate);
		return (df.format(date));
	}
	public static String convertInt2DateString(String intDate){
		long longDate = (long)Long.valueOf(intDate)* Definitions.TIME_OF_DAY_MSEC;
		Date date = new Date(longDate);
		return (df.format(date));
	}
	public static int convertDateStringToInt(String dateString){
		Date date;
		try {
			date = df.parse(dateString);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			return (int)(cal.getTimeInMillis()/Definitions.TIME_OF_DAY_MSEC);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	public static float convertDateStringToFloat(String dateString){
		Date date;
		try {
			date = df.parse(dateString);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			System.out.println("mils="+cal.getTimeInMillis());
			return (float)(cal.getTimeInMillis()/Definitions.TIME_OF_DAY_MSEC);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	public static int convertDateToInt(Date date){
		
		try {
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			return (int)(cal.getTimeInMillis()/Definitions.TIME_OF_DAY_MSEC);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	public static float convertDateToFloat(Date date){
		
		try {
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			return (float)((float)cal.getTimeInMillis()/Definitions.TIME_OF_DAY_MSEC);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	public static Date convertInt2Date(int intDate){
		long longDate = (long)intDate* Definitions.TIME_OF_DAY_MSEC;
		Date date = new Date(longDate);
		return (date);
	}
	/**
	 * Gent Directory path
	 * @param isFile
	 * @param directorys
	 * @return String
	 */
	public static String genPathDirectory(boolean isFile, String... directorys) {
		String path = "";
		try {
			if (directorys != null) {
				int len = directorys.length;
				
				for (int i = 0; i < len; i++) {
					if (directorys[i] == null) {
						return null;
					}
					path += directorys[i];
					if ((i < (len - 1)) || (!isFile)) {
						path += FILE_SEPARATOR;
					}
				}
			}
		} catch (Exception e) {
			return null;
		}
		return path;
	}

	/**
	 * Loads the properties from the source .properties file specified and
	 * over-rides them with those found in the merge file.
	 */
	public static Properties loadFile2Properties(String fileName) {
		FileInputStream fis = null;
		try {
			Properties prop = new Properties();
			fis = new FileInputStream(fileName);
			prop.load(fis);

			return prop;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error("Can not read file: " + fileName);
			//LogWriter.getSNMPLogger().error("Can not read file: " + fileName);
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
			} catch (IOException ioe) {
				//LogWriter.getDBLogger().error("IOException:" + ioe.toString());
				//LogWriter.getSNMPLogger()
						//.error("IOException:" + ioe.toString());
				ioe.printStackTrace();
			}
		}
		return null;
	}

	/***
	 * Read a file using BufferedReader & FileReader to ArrayList<String>
	 * 
	 * @param fileName
	 * @return ArrayList<String>
	 */
	public static ArrayList<String> readFile2ArrayList(String fileName) {
		ArrayList<String> resultList = new ArrayList<String>();
		FileReader fileReader = null;
		BufferedReader buffReader = null;
		try {
			fileReader = new FileReader(fileName);
			buffReader = new BufferedReader(fileReader);
			String temp = "";
			while ((temp = buffReader.readLine()) != null) {
				if ((temp != null) && (temp.trim().length() > 0)) {
					resultList.add(temp);
				}
			}
			if ((resultList != null) && (resultList.isEmpty())) {
				return null;
			} else {
				return resultList;
			}
		} catch (Exception e) {
			//LogWriter.getSNMPLogger().error(e.toString());
			//LogWriter.getSNMPLogger().error(e.toString());
			return null;
		} finally {
			try {
				if (fileReader != null) {
					fileReader.close();
				}

				if (buffReader != null) {
					buffReader.close();
				}
				fileReader = null;
				buffReader = null;
			} catch (IOException e) {
				//LogWriter.getSNMPLogger().error(e.toString());
				//LogWriter.getSNMPLogger().error(e.toString());
			}
		}
	}

	/**
	 * This function reads the given filename into a string.
	 * 
	 * @param filePath
	 *            : filePath the name of the file to open.
	 * @return String
	 */
	public static String readFile2String(String filePath) {
		FileInputStream fis = null;
		InputStreamReader isReader = null;
		BufferedReader buffReader = null;
		StringBuffer strbuffer = new StringBuffer();
		/* Init file input stream */
		try {
			fis = new FileInputStream(filePath);
			// isReader = new InputStreamReader(fis, Constants.ENCODING_SJIS);
			isReader = new InputStreamReader(fis);
			if (isReader == null) {
				return null;
			}
			/* Use buffer reader so that we can use read line by line */
			buffReader = new BufferedReader(isReader);
			String line = null;
			while ((line = buffReader.readLine()) != null) {
				line = line.trim();
				strbuffer.append(line);
				strbuffer.append(LINE_SEP);
			}
			// buffReader.close();
			return strbuffer.toString();
		} catch (IOException e) {
			//LogWriter.getSNMPLogger().error(e.toString());
			//LogWriter.getSNMPLogger().error(e.toString());
		} finally {
			try {
				if (buffReader != null) {
					buffReader.close();
				}
				if (fis != null) {
					fis.close();
				}
			} catch (IOException e) {
				//LogWriter.getSNMPLogger().error(e.toString());
				//LogWriter.getSNMPLogger().error(e.toString());
			}
		}
		return null;
	}

	/**
	 * Replace all occurrences of a substring within a string with another
	 * string.
	 * 
	 * @param inString
	 *            String to examine
	 * @param oldPattern
	 *            String to replace
	 * @param newPattern
	 *            String to insert
	 * @return a String with the replacements
	 */
	public static String replace(String inString, String oldPattern,
			String newPattern) {
		if (inString == null) {
			return null;
		}
		if (oldPattern == null || newPattern == null) {
			return inString;
		}

		StringBuffer sbuf = new StringBuffer();
		// output StringBuffer we'll build up
		int pos = 0; // our position in the old string
		int index = inString.indexOf(oldPattern);
		// the index of an occurrence we've found, or -1
		int patLen = oldPattern.length();
		while (index >= 0) {
			sbuf.append(inString.substring(pos, index));
			sbuf.append(newPattern);
			pos = index + patLen;
			index = inString.indexOf(oldPattern, pos);
		}
		sbuf.append(inString.substring(pos));
		// remember to append any characters to the right of a match
		return sbuf.toString();
	}

	/**
	 * Get current date and/or time in Java using the following method. You may
	 * change the date format in the constructor of SimpleDateFormat to get the
	 * result in a different format.
	 * 
	 * @param dateFormat
	 *            : yyyy.MMMMM.dd or yyyy.MMMMM.dd GGG hh:mm aaa
	 * @return String
	 */
	public static String getNow(String dateFormat) {
		Calendar cal = Calendar.getInstance(TimeZone.getDefault());
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		sdf.setTimeZone(TimeZone.getDefault());
		return sdf.format(cal.getTime());
	}

	public static long getTimeStampMilli() {
		Calendar cal = Calendar.getInstance(TimeZone.getDefault());
		return cal.getTimeInMillis();
	}
	


	/**
	 * 
	 * @param str
	 *            String
	 * @param intDefault
	 *            position
	 * @return int position
	 */
	public static int parseInt(String str, int intDefault) {
		int intResult;
		try {
			str = str.trim();
			intResult = Integer.parseInt(str);
		} catch (Exception e) {
			intResult = intDefault;
		}
		return intResult;
	}

	/**
	 * Check the input string is numeric format or not
	 * 
	 * @param number
	 *            - the specificed string
	 * @return - true if the input string has integer numeric format - false if
	 *         the input string has not integer numeric format
	 */
	public static boolean isInteger(String number) {

		if ((number == null) || ("".equals(number))) {
			return false;
		}
		try {
			Integer.parseInt(number);
		} catch (NumberFormatException NEx) {
			// log error
			return false;
		}
		return true;
	}

	/**
	 * Get Address
	 * 
	 * @param strIPAddress
	 * @return String IP Address
	 */
	public static String getAddress(String strIPAddress) {
		String port = "/";
		int colon = strIPAddress.indexOf(port);
		if (colon < 0) {
			return strIPAddress;
		} else {
			return strIPAddress.substring(0, colon);
		}
	}

	/**
	 * Takes an array of tokens and converts into separator-separated string.
	 * 
	 * @param array
	 *            [] The array of strings input.
	 * @param separators
	 *            The string separator.
	 * @return String String A string containing tokens separated by seperator.
	 */
	public static final String arrayToString(String[] array, String separators) {
		StringBuffer sb = new StringBuffer("");
		String empty = "";

		if (array == null){
			return empty;
		}
		
		if (separators == null){
			separators = ",";
		}	
		
		int len = array.length;
		
		for (int ix = 0; ix < len; ix++) {
			if ((array[ix] != null) && (!array[ix].equals(""))) {
				sb.append(array[ix] + separators);
			}
		}
		
		String str = sb.toString();
		
		if (!str.equals("")) {
			str = str.substring(0, (str.length() - separators.length()));
		}
		return str;
	}

	/**
	 * Converts a delimited string into an array of string tokens.
	 * 
	 * @param strValue
	 *            The string separator.
	 * @param separators
	 *            [] The 'separator' separated string.
	 * @return String A string array of the original tokens.
	 */
	public static final String[] stringToArray(String strValue,
			String separators) {
		StringTokenizer tokenizer;
		String[] array = null;
		int count = 0;

		if (strValue == null){
			return array;
		}
		
		if (separators == null){
			separators = ",";
		}
		
		tokenizer = new StringTokenizer(strValue, separators);
		if ((count = tokenizer.countTokens()) <= 0) {
			return array;
		}

		array = new String[count];

		int ix = 0;
		
		while (tokenizer.hasMoreTokens()) {
			array[ix] = tokenizer.nextToken();
			ix++;
		}

		return array;
	}
	
	/**
	 * Get the extension of a file.
	 * @param file
	 * @return String
	 */
	public static String getExtension(File file) {
		if (file == null) {
			return null;
		}
		String ext = null;
		String fileName = file.getName();
		int i = fileName.lastIndexOf('.');

		if ((i > 0) && (i < (fileName.length() - 1))) {
			ext = fileName.substring(i + 1).toLowerCase();
		}
		return ext;
	}
	
	
	/**
	 * Check file exist
	 * 
	 * @param fileName
	 * @return boolean
	 */
	public static boolean isFile(String fileName) {
		try {
			File theFile = new File(fileName);
			// Check if a file exists.
			if (theFile.exists()) {
				return true;
			}
			return false;
		} catch (Exception e) {
			//LogWriter.getSNMPLogger().error(e.toString());
			return false;
		}
	}


	
	/**
	 * Parse exception to string
	 * @param e
	 * @return String
	 */
	public static String parseException(Throwable e) {
        String strStackTrace = e.toString() + "\n";
        StackTraceElement[] stacktraces = e.getStackTrace();
        for(StackTraceElement trace : stacktraces){
            strStackTrace += "\tat " + trace.toString() + "\n";
        }
        
        Throwable ourCause = e.getCause();
        while(ourCause != null){
            StackTraceElement[] trace = e.getStackTrace();
            int m = trace.length-1;
            int n = stacktraces.length-1;
            while (m >= 0 && n >=0 && trace[m].equals(stacktraces[n])) {
                m--; n--;
            }
            int framesInCommon = trace.length - 1 - m;

            strStackTrace += "Caused by: " + ourCause.toString() + "\n";
            for (int i=0; i <= m; i++)
                strStackTrace +=  "\tat " + trace[i] + "\n";
            if (framesInCommon != 0)
                strStackTrace += "\t... " + framesInCommon + " more" + "\n";
            
            ourCause = ourCause.getCause();
        }
        
        
        return strStackTrace;
    }
	
	public static byte[] concatByteArrays(byte[] a, byte[] b) {
	    byte[] result = new byte[a.length + b.length]; 
	    System.arraycopy(a, 0, result, 0, a.length); 
	    System.arraycopy(b, 0, result, a.length, b.length); 
	    return result;
	}
	public static byte[] concatByteArrays(byte[] a, byte[] b,byte[] c) {
	    byte[] result = new byte[a.length + b.length + c.length]; 
	    System.arraycopy(a, 0, result, 0, a.length); 
	    System.arraycopy(b, 0, result, a.length, b.length); 
	    System.arraycopy(c, 0, result, a.length + b.length, c.length); 
	    return result;
	}
	public static byte[] intToByteArray(int value, int byteOrder) {
       byte[] bytes = (byteOrder == Definitions.TYPE_LITTLEENDIAN_NDR)?(new byte[]{       
        		(byte)value,
        		(byte)(value >>> 8),
        		(byte)(value >>> 16),
        	    (byte)(value >>> 24)}):
       
        	    (new byte[]{(byte)(value >>> 24),
        	    			(byte)(value >>> 16),
        	    			(byte)(value >>> 8),
        	    			(byte)value});
      
       return bytes;
       
	}
	public static String getVuluaByTime(String strTimeINT){
 		int intDate = Integer.parseInt(strTimeINT);
 		Calendar now = Calendar.getInstance();
		now.setTime(Utils.convertInt2Date(intDate));
		int month = now.get(Calendar.MONTH)+1;
		String vu = "";
		if (month >= 4 && month < 8){
			vu = "Hè thu";
		} else if (month >= 8 && month <= 11){
			vu = "Đông xuân";
		} else {
			vu = "Mùa";
		}
		return vu;
	}
	/**
	 * 
	 * @return json string object
	 */
	public static JSONObject getCurrentTime(){
		JSONObject json = new JSONObject();	
			Date date = new Date();
			Calendar now = Calendar.getInstance();
			now.setTime(date);
			date.getTime();
			int year =now.get(Calendar.YEAR);
			int month = now.get(Calendar.MONTH)+1;
			int day = now.get(Calendar.DAY_OF_MONTH);
			
			json.put("day", now.get(Calendar.DAY_OF_MONTH));
			json.put("month",now.get(Calendar.MONTH)+1);
			json.put("year", now.get(Calendar.YEAR));
			json.put("styear", "0");//start time of year to int
			json.put("sti", "0");//start time of year to int
			json.put("cti", "0");//current time of year to int
			json.put("eti", "0");//end time of year to int
			json.put("string", day+"/"+month+"/"+year);//end time of year to int
		System.out.println(json.toJSONString());
		return json;
		}

	public static int getMonthFromIntTime(String strTimeINT){
 		int intDate = Integer.parseInt(strTimeINT);
 		Calendar now = Calendar.getInstance();
		now.setTime(Utils.convertInt2Date(intDate));
		int month = now.get(Calendar.MONTH)+1;
		return month;
	}
	public static int getYearFromIntTime(String strTimeINT){
 		int intDate = Integer.parseInt(strTimeINT);
 		Calendar now = Calendar.getInstance();
		now.setTime(Utils.convertInt2Date(intDate));
		int year = now.get(Calendar.YEAR);
		return year;
	}
	public static int getDayFromIntTime(String strTimeINT){
 		int intDate = Integer.parseInt(strTimeINT);
 		Calendar now = Calendar.getInstance();
		now.setTime(Utils.convertInt2Date(intDate));
		int day = now.get(Calendar.DAY_OF_MONTH);
		return day;
	}
	
  public static String RGB2HexCSS(double red, double green, double blue){	

	String hexValue="#";
	for(int i=1;i<=3;i++)
	{
		double temp=0;
		if(i==1){temp=red;	}
		else if(i==2){temp=green;}
		else if(i==3){temp=blue;}
		
		double devideResult=temp/16;
		
		String stringDevideResult=Double.toString(devideResult);
		int pointIndexInString=stringDevideResult.indexOf(".");
		String firstValue=stringDevideResult.substring(0,pointIndexInString);
		double multiplySixteen=(devideResult-(Double.parseDouble(firstValue)))*16;
		String stringMultiplySixteen=Double.toString(multiplySixteen);
		pointIndexInString=stringMultiplySixteen.indexOf(".");
		String secondValue=stringMultiplySixteen.substring(0,pointIndexInString);
		
		if(firstValue.equalsIgnoreCase("10")){firstValue="A";}
		if(firstValue.equalsIgnoreCase("11")){firstValue="B";}
		if(firstValue.equalsIgnoreCase("12")){firstValue="C";}
		if(firstValue.equalsIgnoreCase("13")){firstValue="D";}
		if(firstValue.equalsIgnoreCase("14")){firstValue="E";}
		if(firstValue.equalsIgnoreCase("15")){firstValue="F";}
		if(secondValue.equalsIgnoreCase("10")){secondValue="A";}
		if(secondValue.equalsIgnoreCase("11")){secondValue="B";}
		if(secondValue.equalsIgnoreCase("12")){secondValue="C";}
		if(secondValue.equalsIgnoreCase("13")){secondValue="D";}
		if(secondValue.equalsIgnoreCase("14")){secondValue="E";}
		if(secondValue.equalsIgnoreCase("15")){secondValue="F";}
		
		hexValue=hexValue+firstValue+secondValue;
	 }
	 return hexValue;
   }
  public static String RGB2HexCSS(Color color){
	 return (RGB2HexCSS(color.getRed(), color.getGreen(), color.getBlue()));
  }
  public static Color Hex2RGB(String hexStr){
	 return Color.decode(hexStr);
  }
  
  
  public static Color HSL2RGB(double h, double sl, double l)
  {

      double v;
      double r, g, b;
      r = l;   // default to gray
      g = l;
      b = l;
      v = (l <= 0.5) ? (l * (1.0 + sl)) : (l + sl - l * sl);
      if (v > 0)
      {
          double m;
          double sv;
          int sextant;
          double fract, vsf, mid1, mid2;

          m = l + l - v;
          sv = (v - m) / v;
          h *= 6.0;
          sextant = (int)h;
          fract = h - sextant;
          vsf = v * sv * fract;
          mid1 = m + vsf;
          mid2 = v - vsf;
          switch (sextant)
          {
              case 0:
                  r = v;
                  g = mid1;
                  b = m;
                  break;
              case 1:
                  r = mid2;
                  g = v;
                  b = m;
                  break;
              case 2:
                  r = m;
                  g = v;
                  b = mid1;
                  break;
              case 3:
                  r = m;
                  g = mid2;
                  b = v;
                  break;
              case 4:
                  r = mid1;
                  g = m;
                  b = v;
                  break;
              case 5:
                  r = v;
                  g = m;
                  b = mid2;
                  break;
          }
      }
      ColorRGB rgb = new ColorRGB();
      rgb.r = (int)(r * 255.0f);
      rgb.g = (int)(g * 255.0f);
      rgb.b = (int)(b * 255.0f);
      
      return new Color(rgb.r,rgb.g,rgb.b,0);

  }
  
  public static Hashtable<Object, Object> setSttInObjectReport(ArrayList<String> lst){
	  Hashtable<Object, Object> map = new  Hashtable<Object, Object>();
	  int stt = 1;
	  for (int i = 0; i < lst.size(); i++){
			String s = lst.get(i);
			if (!map.containsKey(s)){
				map.put(s, Integer.valueOf(stt));
				stt++;
			}
	  }
	  map.put("rows", Integer.valueOf(stt-1));
	  return map;
  }
  
  public static void DebugArrayList(ArrayList list){
	  System.out.println("DebugArrayList...."+list.size());
	  for (int  i = 0; i < list.size(); i++) {
		 System.out.println(list.get(i).toString()); 
	  }
   }
  public static void DebugArray(Object[] list){
	  System.out.println("DebugArray...."+list.length);
	  for (int  i = 0; i < list.length; i++) {
		  //System.out.println(i);
		 System.out.println(list[i].toString()); 
	  }
   }
  public static void printMap2String(Hashtable list){
	  Set set = list.keySet();
	  Iterator itr = set.iterator();
	  int i = 0;
	  while (itr.hasNext()){
		 Object key = itr.next();
		 i++;
		 System.out.println(key.toString() +" - " + list.get(key));
	  }
	  System.out.println("====== MAP SIZE: " + i);

   }
  
	public static String getStringFromStackTrace(Throwable throwable) {
		  Writer writer = new StringWriter();
		  PrintWriter printWriter = new PrintWriter(writer);
		  throwable.printStackTrace(printWriter);
		  return writer.toString();
	}
  
  public static boolean deletefile(String file){
	  File f1 = new File(file);
	  boolean success = f1.delete();
	  if (!success){
	  System.out.println("Deletion failed.");
	     return false;
	   }else{
	   System.out.println("File deleted.");
	   return true;
	     }
  }
  ////BEGIN
  
  ////END
  public static void delete(String fileName) {
	    try {
	      // Construct a File object for the file to be deleted.
	      File target = new File(fileName);

	      if (!target.exists()) {
	        System.err.println("File " + fileName
	            + " not present to begin with!");
	        return;
	      }

	      // Quick, now, delete it immediately:
	      if (target.delete())
	        System.err.println("** Deleted " + fileName + " **");
	      else
	        System.err.println("Failed to delete " + fileName);
	    } catch (SecurityException e) {
	      System.err.println("Unable to delete " + fileName + "("
	          + e.getMessage() + ")");
	    }
	  }
  public static boolean isNumber(String s) {
      try {
          Float.parseFloat(s);
      
      } catch (NumberFormatException ex) {
          return false;
      }
      
      return true;
  }
  /**
   * 
   * @param value
   * neu value is not a numberm return 0
   * @return
   */
  public static float getFloat(float value){
	  if(Float.isNaN(value)) return 0.0f;
	  return value;
  }
  public static int getDayOfWeekFromInt(int time){
		 Calendar cal = Calendar.getInstance();
		 cal.setTime(Utils.convertInt2Date(time));
		 int ngayThu=cal.get(Calendar.DAY_OF_WEEK);
		 return ngayThu;
  }
  /**
   * Lấy thời gian(tính theo int) tại đầu tuần t2 và cuối tuần CN của tất cả các tuần trong khoảng time1->time2
   * @param time_int1
   * @param time_int2
   * @return
   */
  public static ArrayList getWeekTimeRange(int time_int1, int time_int2){
	     ArrayList arrayTimes=new ArrayList();
	     Calendar cal = Calendar.getInstance();
		 cal.setTime(Utils.convertInt2Date(time_int1));
		 int ngayThu=cal.get(Calendar.DAY_OF_WEEK);
		 //set lại time 1 về ngày thứ 2 gần nhất trước đó
		 time_int1-=(ngayThu-2);
		 //int n=1;
		 for(int i=time_int1;i<time_int2;i+=7){
			 GraphComparisonVO o=new GraphComparisonVO();
			 o.t1=i;
			 o.t2=i+6;
			 arrayTimes.add(o);
			 //System.out.println("Tuần "+n +":"+o.t1+":"+("Thứ "+Utils.getDayOfWeekFromInt(o.t1))+"-"+o.t2+":"+("Thứ "+Utils.getDayOfWeekFromInt(o.t2)));
			 //n++;
		 }
		 
	  return arrayTimes;
  }
  public static float toFixed(float value){
	 
	  return Float.valueOf(decimalFormated.format(value));
  }
  public static String join(ArrayList<String> list, String delim) {

	    StringBuilder sb = new StringBuilder();

	    String loopDelim = "";

	    for(String s : list) {

	        sb.append(loopDelim);
	        sb.append(s);            

	        loopDelim = delim;
	    }

	    return sb.toString();
	}
 public static void main(String[] args)
  {
try{
	String s =
	"{"
		+"\"error_code\": 0,"
		+"\"error_desc\": \"Success\","
		+"\"transaction_id\": \"VDC201407120001\","
		+"\"sys_transaction_id\": \"000000000001\","
		+"\"sys_transaction_datetime\": \"2014-12-31 23:59:59\","
		+"\"products\": ["
		+"{"
		+"\"product_code\": \"TG00001\","
		+"\"quantity\": 2,"
		+"\"running_numbers\": ["
		+"\"BTATHA11134FENFH\","
		+"\"BGATHA11135MYHYW\""
		+"]"
		+"},"
		+"{"
		+"\"product_code\": \"TG00001\","
		+"\"quantity\": 2, "
		+"\"running_numbers\": ["
		+"\"BTATHA11134FENFH\","
		+"\"BGATHA11135MYHYW\""
		+"]"
		+"}"
		+"]"
	+"}";

	System.err.println(s);
	org.json.JSONObject obj = new org.json.JSONObject(s);

	//get tham số
	System.out.println(obj.getString("error_code"));
	System.out.println(obj.getString("error_desc"));
	System.out.println(obj.getString("transaction_id"));
	System.out.println(obj.getString("sys_transaction_datetime"));
	
	//get mảng products
	JSONArray array = obj.getJSONArray("products");
	for(int i = 0 ; i < array.length() ; i++){
		 System.out.println(array.getJSONObject(i).getString("product_code"));
		 System.out.println(array.getJSONObject(i).getString("quantity"));
		 
		 //get mảng running_numbers trong mỗi element của  mảng products
		 JSONArray array2 = array.getJSONObject(i).getJSONArray("running_numbers"); 
		 for(int j = 0 ; j < array2.length() ; j++){
			 System.out.println("->"+array2.getString(i));// BTATHA11134FENFH, BGATHA11135MYHYW....
		 }
		 
	}
	
	
	
	
}catch(Exception e){
	e.printStackTrace();
}
    /*  JSONObject json = new JSONObject();
      ArrayList  lst = new ArrayList();
         Hashtable htbl1 = new Hashtable();
         htbl1.put("a", "1");
         htbl1.put("b", "2");
         lst.add(htbl1);
         
         Hashtable htbl2 = new Hashtable();
         htbl2.put("a", "1");
         htbl2.put("b", "2");
         lst.add(htbl2);
      
      json.put("series", lst);*/
	 // System.out.println("json.toJSONString() :"+json.toJSONString());
	//  System.out.println(isNumber(String.valueOf(10.0/3)));
	// String s = "54202,54204,54205,54208,54210,54213,54255,54256,54203,54215,54216,54218,54240,54236,54237,54254,54257,54264,54265,54267,54268,54270,54277,54279,54288,54262,"
	// ;
	// System.out.println( s.split(",").length);/* ArrayList<String> lst = new  ArrayList<String>();


	 /*System.out.println(Utils.convertDateToInt(new Date()));
	 System.out.println(Utils.convertDateToFloat(new Date()));
	 
	 System.out.println(Utils.convertInt2DateString(Utils.convertDateToInt(new Date())));
	 */
	/* System.out.println(Utils.convertDateStringToFloat("21/06/2012"));//f
	 System.out.println(Utils.convertDateStringToFloat("01/01/1970"));//f
	 */
	/* System.out.println(Utils.convertInt2DateString(0));//ok
	 System.out.println(Utils.convertInt2DateString(1));//ok
	 */
	 //15492  t6 01/06/
	 /*int time_int1=15492;
	 Calendar cal = Calendar.getInstance();
	 cal.setTime(Utils.convertInt2Date(time_int1));
	 int ngayThu=cal.get(Calendar.DAY_OF_WEEK);
	 //set lại time 1
	 time_int1-=(ngayThu-2);
	 
	 Date date1=Utils.convertInt2Date(time_int1);//01/06/2012
	 
	 Calendar cal1 = Calendar.getInstance();
	 cal1.setTime(date1);
	 //System.out.print("Tuần " +cal.get(Calendar.DAY_OF_WEEK_IN_MONTH));
	 System.out.println(" Ngày thứ " +(cal1.get(Calendar.DAY_OF_WEEK)));
	 */

	 
	
	 /*
	  lst.add("Bfdf");
	  lst.add("Ffdf");
	  lst.add("Afdf");
	  lst.add("Afdf");

	  Hashtable<Object, Object> map = setSttInObjectReport(lst);
	  Enumeration<Object> enumV = map.elements();
	  Enumeration<Object> enumK = map.keys();
		while (enumK.hasMoreElements()) {
			
			System.out.println(enumK.nextElement() + ":" + enumV.nextElement());
			
		}
	  */
	  
	   /*ArrayList<Object> arrayList = new ArrayList<Object>();
	   arrayList.add(new Float(1.2));
	   arrayList.add(new Float(1.8));
	   arrayList.add(new Float(1.1));
	    Comparator comparator = Collections.reverseOrder();
	    Utils.DebugArrayList(arrayList);   
	    System.out.println("Before sorting ArrayList in descending order : "
	                                                             + arrayList);
	   
	   */ /*
	      To sort an ArrayList using comparator use,
	      static void sort(List list, Comparator c) method of Collections class.
	    */
	   
	 /*   Collections.sort(arrayList,Collections.reverseOrder());
	    Utils.DebugArrayList(arrayList);*/

  }
 
 public static boolean checkInteger(String s) {
	    try { 
	        Integer.parseInt(s); 
	    } catch(NumberFormatException e) { 
	        return false; 
	    } catch(NullPointerException e) {
	        return false;
	    }
	    // only got here if we didn't return false
	    return true;
	}
  
}