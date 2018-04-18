package com.cwrs.ntk.common;

import org.json.simple.JSONObject;

public class JResult {
	
	 private String code = Definitions.DB_STR_FAILED;
	 private String msg = "";
	 private double val = 0;//id returned by insert
	 private String json = "";//id returned by insert
	 public JResult(String code, String msg){
		 this.code = code;
		 this.msg = msg;
		 this.json = msg;
	 }
	 public JResult(String code, Exception e){
		 this.code = code;
		 this.msg = e.getMessage();
	 }
	 public JResult(String code, int val){
		 this.code = code;
		 this.val = (int)val;
	 }
	 public JResult(String code, float val){
		 this.code = code;
		 this.val = val;
	 }
	 public int getCode(){
		 return Integer.parseInt(this.code);
	 }
	 public String getMessage(){
		 return this.msg;
	 }
	 public void setMessage(String msg){
		 this.msg = msg;
	 }
	 public int getIntValue(){
		 return (int)this.val;
	 }
	 public double getFloatValue(){
		 return this.val;
	 }
	 public void setFloatValue(float fv){
		 this.val = fv;
	 }
	 public String create(){
		 JSONObject object=new JSONObject();
		 object.put("code", this.code);
		 object.put("msg",this.msg);
		 object.put("json",this.json);
		 object.put("val",String.valueOf(this.val));
		 return object.toJSONString();
	 }
	 public String toString(){
		 return this.create();
	 }
	 public String createString(){
		 return this.create();
	 }
}
