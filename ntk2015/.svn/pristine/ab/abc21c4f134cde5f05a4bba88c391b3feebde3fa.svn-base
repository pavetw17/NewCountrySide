package com.cwrs.ntk.docconverter;

import java.io.File;

import com.cwrs.dbscl.common.Utils;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.LibraryLoader;
import com.jacob.com.Variant;

public class OLEWordConverter {
	public static String sDir = "c:\\";
	public static String sInputDoc1 = sDir + "0.rtf";
	public static String sInputDoc2 = sDir + "1.rtf";
	public static String sOutputDoc1 = sDir + "b1.doc";
	public static String sOutputDoc2 = sDir + "b2.doc";
	public static String sOldText = "[label:import:1]";
	public static String sNewText = "I am some horribly long sentence, so long that [insert bullshit here]";
	
	public static boolean tVisible = false;
 	public static ActiveXComponent _oWord;
	public static Object _oDocuments;
	public static void startWordApp(){
		Utils.setMeasuretTimeStart("start word app...");
		 _oWord = new ActiveXComponent("Word.Application");
		 _oWord.setProperty("Visible", new Variant(tVisible));
		 _oDocuments = _oWord.getProperty("Documents").toDispatch();
		 Utils.printMeasure();
	}
    public static void convertRTF2Word(String srcFile, String dstFiles){
    Utils.setMeasuretTimeStart("converting...");	
     Object oDocument = Dispatch.call((Dispatch)_oDocuments, "Open", srcFile).toDispatch();
     System.out.println(oDocument.toString());
     Object oWordBasic = Dispatch.call(_oWord, "WordBasic").getDispatch();
     Dispatch.call((Dispatch)oWordBasic, "FileSaveAs", dstFiles ,0);//0 is *.doc format
     Variant saveYesNo = new Variant(false);
     Dispatch.call((Dispatch)oDocument, "Close", saveYesNo);
     Utils.printMeasure();
    }
    public static void stopWordApp(){
    	 _oWord.invoke("Quit", new Variant[0]);
    }
    
    public static void main(String[] args)
	  {
        File lib = new File(".\\WebContent\\WEB-INF\\lib\\jacob\\" + LibraryLoader.getPreferredDLLName() + ".dll");
        System.setProperty(LibraryLoader.JACOB_DLL_PATH, lib.getAbsolutePath());

        System.out.println("JACOB_DLL_PATH = " + lib.getAbsolutePath());
        LibraryLoader.loadJacobLibrary();
        startWordApp();
        for (int i=0;i<1;i++){
        convertRTF2Word(sInputDoc1,sOutputDoc1);
        convertRTF2Word(sInputDoc2,sOutputDoc2);
        
        }
		 System.out.println("ok.");
		 stopWordApp();

	  }
}

