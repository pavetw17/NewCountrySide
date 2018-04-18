package com.cwrs.ntk.reporter;

public class GraphComparisonVO {
	public String year;
	public Float dientichHa;
	private Integer stt;
	public int vulua;

	
	public int ngaydieutra;
	
	//Mật độ sâu-Diện tích nhiễm-Tỷ lệ bệnh
	public int t1;
	public int t2;
	public int count;//count object nằm trong khoảng t1->t2
	public float matdotb;
	public float matdotb_max;
	public float matdocao;
	public float dtNhiem;
	public float dtPhongtru;
	
	
	
    public GraphComparisonVO(){
    	this.t1=0;
    	this.t2=0;
    	//for mds-tlb
    	this.count=0;
    	this.matdotb=0;
    	this.matdotb_max=0;
    	this.matdocao=0;
    	//for dien tich nhiem
    	this.dtNhiem=0;
    	this.dtPhongtru=0;
    	
    	this.ngaydieutra=0;
    	this.vulua = 0;
    }

	public GraphComparisonVO(Integer stt, String year, Float dientichHa) {
		this.dientichHa = dientichHa;
		this.year = year;
    }

	public GraphComparisonVO(Integer stt, int ngaydieutra, float matdotb,float matdocao) {
		this.ngaydieutra = ngaydieutra;
		this.matdotb = matdotb;
		this.matdocao = matdocao;
		
    }
	public Integer getStt() {
		return stt;
	}
	public void setStt(Integer stt) {
		this.stt = stt;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public int getNgaydieutra() {
		return ngaydieutra;
	}
	
	public Float getDientichHa() {
		return dientichHa;
	}
	public void setDientichHa(Float v) {
		this.dientichHa =  v;
	}

	public String toString(){
		return (
				"Stt: " + this.year + "," +
						"Ha: " + this.getDientichHa() 
			   );
	}

}
