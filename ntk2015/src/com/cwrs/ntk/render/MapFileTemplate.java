package com.cwrs.dbscl.render;

import java.awt.Color;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.cwrs.dbscl.common.Config;
import com.cwrs.dbscl.common.Utils;

public class MapFileTemplate {


public static String BEGIN_CCGL = 
	"MAP" + "\n" +
	" MAXSIZE  2500 " + "\n" +
	"  OUTPUTFORMAT"+"\n" +
	"  NAME 'AGGPNG'"+"\n" +
	"  DRIVER AGG/PNG"+"\n" +
	"  IMAGEMODE RGB"+"\n" +

	"  FORMATOPTION \"QUANTIZE_FORCE=OFF\""+"\n" +
	"  FORMATOPTION \"QUANTIZE_DITHER=ON\""+"\n" +
	"  FORMATOPTION \"QUANTIZE_COLORS=256\""+"\n" +
	"END"+"\n" +
	"  IMAGETYPE      AGGPNG"+"\n" +
	"  EXTENT		 659968.662821 677337.450413 2299208.093714 2305887.606703"+"\n" +
	"  SIZE           800 600"+"\n" +
	"  SYMBOLSET    \"symbols.txt\""+"\n" +
	"  IMAGECOLOR     255 255 255"+"\n" +
	"  FONTSET        \"../fonts/fonts.list\""+"\n" +
	"  PROJECTION"+"\n" +
	"    \"init=epsg:4756\""+"\n" +
	"END"+"\n" +
	"QUERYMAP"+"\n" +
	"	  STATUS ON"+"\n" +
	"	  SIZE 800 600"+"\n" +
	"	  STYLE HILITE"+"\n" +
	"	  COLOR 255 255 255"+"\n" +
	"END"+"\n" +
	"LAYER"+"\n" +
	"   NAME         \"layer_ruong_hientrang\""+"\n" +
	"   DATA         tbl_ruong_region"+"\n" +
	"   STATUS       ON"+"\n" +
	"   TYPE         POLYGON"+"\n" +
	"CONNECTION \"user="+Config.getDBUserName()+ " password="+Config.getDBPass()+ " dbname="+Config.getDBName()+ " host="+Config.getDBHost()+ " port="+Config.getDBPort()+"\""+"\n" +
	"CONNECTIONTYPE postgis"+"\n" ;

	
public static String END_CCGL = 	

	"CLASS"+"\n" +
	"STYLE"+"\n" +
	"ANTIALIAS TRUE"+"\n" +
	"COLOR 255 255 255"+"\n" +
	"OUTLINECOLOR 255 255 255"+"\n" +
	"END"+"\n" +
	"END"+"\n" +
	"PROJECTION"+"\n" +
	"\"init=epsg:4756\""+"\n" +
	"END"+"\n" +
	"END"+"\n" +
	"END";

public static String genStyleExpressionClass(String expression, String symbol, Color fillColor, Color outlineColor){
	if(outlineColor.getRed()==0 && outlineColor.getGreen() ==0 && outlineColor.getBlue()==0){
	   outlineColor=fillColor;
	}
   	String s =
	" CLASS"+"\n"+
	(expression != null?("EXPRESSION ("+expression+")"+"\n"):"")+
   	(symbol != null?("SYMBOL \""+symbol+"\""+"\n"):"")+
	" COLOR " + fillColor.getRed() + " " + fillColor.getGreen() + " " + fillColor.getBlue() + "\n"+
	" OUTLINECOLOR " + outlineColor.getRed() + " " + outlineColor.getGreen() + " " + outlineColor.getBlue() + "\n"+
	" END"+"\n";
   	
   	return s;
	
}
public static boolean createMapFile(String fileName, String data, ArrayList<String> classExpressions){
	
	try {
		 BufferedWriter out = new BufferedWriter(
				 new OutputStreamWriter(   new FileOutputStream(fileName),"UTF8")
				   
						 );
	    out.write(BEGIN_CCGL);
	    
	    out.write(" DATA " + data + "\n");
	    for (int i = 0; i < classExpressions.size(); i++){
	    	out.write(classExpressions.get(i));
	    }
	    out.write(END_CCGL);
	    
	    out.close();
	} catch (IOException e) {
	}
	return false;
}

public static String createDivChugiaiHientrang(int width, int height, Color bgcolor, Color textcolor, Hashtable<Object, Object> map){
	
	String divHtml = "";
	int boxw = 30;
	int boxh = 30;
	
	String bgcolorCss = Utils.RGB2HexCSS(bgcolor);
	String textColorCss = Utils.RGB2HexCSS(textcolor);
	
	divHtml += "<div id=\"div_chugiai_content\" style=\"background:"+bgcolorCss+"; width:"+width+"px; height:"+height+"px;\">";
	
	divHtml +="<b style=\"color:#000000;margin-top:20px; margin-left:20px\">CHÚ GIẢI BẢN ĐỒ HIỆN TRẠNG:</b>";
	divHtml += "<table border=\"0\">";
	Set<Object> keys = map.keySet();
	Collection<Object> vals = map.values();
	Iterator<Object> itKeys = keys.iterator();
	Iterator<Object> itVals = vals.iterator();
	
	while (itKeys.hasNext()){
		String name = (String)itKeys.next();
		Color ocolor = (Color)itVals.next();
		String color = Utils.RGB2HexCSS(ocolor);
	  divHtml +=
	  "<tr>"+
	    "<td width=\"51\"><div style=\"background:"+color+"; width:"+boxw+"px; height:"+boxh+"px; margin-left:10px;\" align=\"center\"></div></td>"+
	    "<td width=\"139\"><b style=\"color:"+textColorCss+"\">" + name + "</b></td>"+
	  "</tr>";

	}
	divHtml += "</table>";
	divHtml += 
	//" <input id =\"ATMEL1\" type=\"submit\" name=\"Submit2\" value=\"Đóng\" onclick=\"closeChugiai()\">" +
	" <script type=\"text/javascript\" language=\"javascript\"> " +
	" function closeChugiai(){"+
    "	$('#accordion_panel_left').revertFlip();"+
//	"$(\"#accordion_panel_left\").flip({"+
//	"	direction:'rl',"+
//	"	content:g_div_chugiai_flip_orginal"+
//	"})"+
	"}"+
	 "</script>";


	
	divHtml += "</div>";
	return divHtml;
}
public static String createDivChugiaiHientrang(int width, int height, Color bgcolor, Color textcolor, ArrayList arrayMap, int boxw,int boxh, String note){
	
	String divHtml = "";

	String bgcolorCss = Utils.RGB2HexCSS(bgcolor);
	String textColorCss = Utils.RGB2HexCSS(textcolor);
	
	divHtml += "<div id=\"div_chugiai_content\" style=\"background:"+bgcolorCss+"; width:"+width+"px; height:"+height+"px;\">";
	
	divHtml +="<b style=\"color:#000000;margin-top:20px; margin-left:20px\">CHÚ GIẢI BẢN ĐỒ HIỆN TRẠNG:</b>";
	divHtml += "<table border=\"0\">";

	
	for (int i=0; i< arrayMap.size();i++){
	//while (itKeys.hasNext()){
		ColorItem cit= (ColorItem)arrayMap.get(i);
		String name = cit.name;
		Color ocolor = cit.color;
		String color = Utils.RGB2HexCSS(ocolor);
	  divHtml +=
	  "<tr>"+
	    "<td width=\"51\"><div style=\"background:"+color+"; width:"+boxw+"px; height:"+boxh+"px; margin-left:10px;\" align=\"center\"></div></td>"+
	    "<td width=\"199\"><b style=\"color:"+textColorCss+"\">" + name + "</b></td>"+
	  "</tr>";

	}
	divHtml += "</table>";
	divHtml+="<b style=\"color:"+textColorCss+"\">" + note + "</b>";
	divHtml += 
	//" <input id =\"ATMEL1\" type=\"submit\" name=\"Submit2\" value=\"Đóng\" onclick=\"closeChugiai()\">" +
	" <script type=\"text/javascript\" language=\"javascript\"> " +
	" function closeChugiai(){"+
    "	$('#accordion_panel_left').revertFlip();"+
//	"$(\"#accordion_panel_left\").flip({"+
//	"	direction:'rl',"+
//	"	content:g_div_chugiai_flip_orginal"+
//	"})"+
	"}"+
	 "</script>";


	
	divHtml += "</div>";
	return divHtml;
}
public static String createDivChugiaiHientrang(int width, int height, Color bgcolor, Color textcolor, ArrayList arrayMap)
{	
	int boxw = 30;
	int boxh = 30;
	return createDivChugiaiHientrang(width, height, bgcolor, textcolor, arrayMap, boxw, boxh,"");
}
public static String createDivChugiaiHientrangWithNote(int width, int height, Color bgcolor, Color textcolor, ArrayList arrayMap, String note){
	int boxw = 30;
	int boxh = 30;
	
	return createDivChugiaiHientrang(width, height, bgcolor, textcolor, arrayMap, boxw, boxh, note);
}
	
}
