package com.cwrs.ntk.common;

import java.util.ArrayList;

public class ErrorNotifier {
	private ArrayList lstErrors;
	public  ErrorNotifier(){
		lstErrors = new ArrayList();

	}


			
	  public void clear(){
		  lstErrors.clear();
	};
		
		 public void add(String msg){
	    	this.lstErrors.add(msg); 
	    };
	    public boolean hasErrors(){
	    	if (this.lstErrors.size() > 0) return true;
	    	return false;
	    };
	    
	    public String getErrorMessages(String motifyError){
	    	String msgErrors = "";
	    	msgErrors += "<strong>";
	    	if (motifyError == null) msgErrors += "Dữ liệu không hợp lệ. Hãy kiểm tra lại những thông tin sau:";
	    	else 
	    		msgErrors += motifyError;
	    	
	    	msgErrors += "</strong>";
	    	msgErrors +="<br>";
	    	for (int i = 0; i < this.lstErrors.size(); i++){
	    		msgErrors += "<strong>"+((i+1)+ "</strong>"+ ". " + this.lstErrors.get(i));
	    		msgErrors += "<br>";
	    	}
	    	return msgErrors;
	    }

}
