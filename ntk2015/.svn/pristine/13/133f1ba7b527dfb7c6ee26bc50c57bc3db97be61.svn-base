package com.cwrs.ntk.docconverter;

import java.io.File;

import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeConnectionProtocol;
import org.artofsolving.jodconverter.office.OfficeManager;

import com.cwrs.dbscl.common.Utils;

public class DocConverter {
    public static OfficeManager _officeManager;
    public static OfficeDocumentConverter _converter;
    
    public static void startService(){
    	_officeManager = new DefaultOfficeManagerConfiguration().buildOfficeManager();
		
		
		 /*_officeManager = new DefaultOfficeManagerConfiguration()
	      .setOfficeHome("D:\\Program Files (x86)\\OpenOffice.org 3")
	      .setConnectionProtocol(OfficeConnectionProtocol.PIPE)
	      .setPipeNames("office1", "office2")
	      .setTaskExecutionTimeout(30000L)
	      .buildOfficeManager();
		*/
	    _officeManager.start();
	    _converter = new OfficeDocumentConverter(_officeManager);
    }
    public static void stopService(){
    	_officeManager.stop(); 
    }
	public static void convert(String srcFile, String... destFiles){
	
		for (int i=0;i <destFiles.length;i++){
			try{
				_converter.convert(new File(srcFile), new File(destFiles[i]));
			}catch (Exception e) {
				//e.printStackTrace();
				System.out.println("Convert "+srcFile+" -> "+destFiles[i]+" failed: unsupported conversion.");
			}
		}
	    
	}
	public static void main(String[] args)
	  {
		startService();
		 System.out.println("start converting...");

		 convert("C:\\0.rtf","C:\\2.doc","C:\\2.pdf","C:\\2.rtf","C:\\2.html");
	
		 
	     System.out.println("OK!");
			//System.out.println(n.id);
	     stopService();
	  }
}
