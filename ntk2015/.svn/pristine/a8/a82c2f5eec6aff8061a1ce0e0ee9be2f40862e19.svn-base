package com.cwrs.ntk.dataobject;

public class TblBenhHai {
	
		/** 
		 * Define fields of database table 
		 * CREATE TABLE public.tbl_benh (
	  benh_id INTEGER DEFAULT 0 NOT NULL, 
	  benh_ten VARCHAR(50), 
	  benh_mota VARCHAR(200), 
	  benh_thuoc VARCHAR(50), 
	  benh_dacdiem VARCHAR(50), 
	  benh_visinhvat VARCHAR(50), 
	  benh_content VARCHAR, 
	  CONSTRAINT benh_id PRIMARY KEY(benh_id)
	) WITH OIDS;*/
		
		public static final String BENHHAI_TBL           = "tbl_benh";
		public static final String BENHHAI_ID            = "benh_id";
		public static final String BENHHAI_TEN           = "benh_ten";
		public static final String BENHHAI_MOTA          = "benh_mota";
		public static final String BENHHAI_THUOCTRI      = "benh_thuoc";
		public static final String BENHHAI_VISINHVAT     = "benh_visinhvat";
		public static final String BENHHAI_CONTENT   	= "benh_content";
		public static final String BENHHAI_DD   		= "benh_dacdiem";     //đặc điểm



		/*ID of node contained in database*/
		private int id        = -1;

		

		/*Name of node*/
		private String  ten  	  = ""; 
		private String  mota 	  = "";
		private String  thuoctri  = "";
		private String  visinhvat = "";
		private String  content   = "";
		private String  dacdiem   = "";

	    
		/**
		 * Construct default
		 */
		public TblBenhHai() {
			
		}
		public int getID(){
			return this.id;
		}
		public void setID(int id){
			this.id = id;
		}
		
		public String getThuoctri(){
			return this.thuoctri;
		}
		public void setThuoctri(String thuoctri){
			this.thuoctri = thuoctri;
		}
		
		public String getVisinhvat(){
			return this.visinhvat;
		}
		
		public void setVisinhvat(String visinhvat){
			this.visinhvat = visinhvat;
		}
		
		public String getContent(){
			return this.content;
		}
		public void setContent(String content){
			this.content = content;
		}
		
		public String getDacDiem(){
			return (this.dacdiem); 
		}
		public void setDacdiem(String dacdiem){
			this.dacdiem = dacdiem;
		}
		
		
		
		public String getTenBenh(){
			return this.ten;
		}
		public void setTenBenh(String tenBenh){
			this.ten = tenBenh;
		}
		
		public String getMota(){
			return mota;
		}
		public void setMota(String mota){
			this.mota = mota;
		}
		/**
		 * Return info of NodeVO
		 * @return a String object contains info of NodeVO 
		 */
		public String toString() {
			StringBuffer buff = new StringBuffer();
			buff.append(" Objetct_BENHHAI_Ruong <");
			
			buff.append("ten: " + getTenBenh() + ", ");
			buff.append("mota: " + getMota() + ", " );
			buff.append("thuoctri: " + getThuoctri() + ", " );
			buff.append("visinhvat: " + getVisinhvat() + ", " );
			buff.append("content: " +  getContent() + ", " );
			buff.append("dacdiem: " + getDacDiem()); 
			
			buff.append("sauBenh: " + getTenBenh()); 
			buff.append("mota: " + getMota()); 
			
			buff.append(">");
			return buff.toString();
		}	
		
	}


