package com.cwrs.ntk.models;

import javax.persistence.*;

import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_nhansu", schema = "public", catalog = "ntm")
public class TblNhansuEntity {
    private int idNhansu;
    private String hoten;
    private String hocham;
    private String hocvi;
    private String lylichkh;
    private Integer ngaysinh;
    private String chucvu;
    private String phonenr;
    private String mobile;
    private String diachinr;
    private String email;
    private String fax;
    private byte[] fileLylichkh;
    private Integer gioitinh;

    
    
//    id_nhansu serial NOT NULL,
//    hoten character varying(200), -- họ tên đầy đủ
//    hocham character varying(50), -- học hàm
//    hocvi character varying(50), -- học vị
//    lylichkh character varying, -- lý lịch khoa học
//    ngaysinh integer, -- ngày tháng năm sinh
//    chucvu character varying(100), -- chức vụ tại đơn vị công tác
//    id_tochuc integer, -- mã tổ chức công tác
//    phonenr character varying(20), -- số điện thoại nhà riêng
//    mobile character varying(20), -- số di động
//    diachinr character varying(200), -- địa chỉ nhà riêng
//    email character varying(100), -- địa chỉ hòm thư điện tử
//    fax character varying(20), -- số fax cơ quan
//    file_lylichkh bytea, -- tập tin lý lịch khoa học
//    gioitinh boolean, -- giới tỉnh (nam/nữ)
    
    public static final String NHANSU_TBL = "tbl_nhansu";
    public static final String NHANSU_ID = "id_nhansu";
    public static final String NHANSU_HOTEN = "hoten";
    public static final String NHANSU_HOCHAM = "hocham";
    public static final String NHANSU_HOCVI = "hocvi";
    public static final String NHANSU_LYLICH = "lylichkh";
    public static final String NHANSU_NGAYSINh = "ngaysinh";
    public static final String NHANSU_CHUCVU = "chucvu";
    public static final String NHANSU_ID_TOCHUC = "id_tochuc";
    public static final String NHANSU_PHONE_NR= "phonenr";
    public static final String NHANSU_MOBILE = "mobile";
    public static final String NHANSU_DIACHI = "diachinr";
    public static final String NHANSU_EMAIL = "email";
    public static final String NHANSU_FAX = "fax";
    public static final String NHANSU_FILE = "file_lylichkh";
    public static final String NHANSU_GIOITINH = "gioitinh";
    
   
    @Id
    @Column(name = "id_nhansu")
    public int getIdNhansu() {
        return idNhansu;
    }

    public void setIdNhansu(int idNhansu) {
        this.idNhansu = idNhansu;
    }

    @Basic
    @Column(name = "hoten")
    public String getHoten() {
        return hoten;
    }

    public void setHoten(String hoten) {
        this.hoten = hoten;
    }

    @Basic
    @Column(name = "hocham")
    public String getHocham() {
        return hocham;
    }

    public void setHocham(String hocham) {
        this.hocham = hocham;
    }

    @Basic
    @Column(name = "hocvi")
    public String getHocvi() {
        return hocvi;
    }

    public void setHocvi(String hocvi) {
        this.hocvi = hocvi;
    }

    @Basic
    @Column(name = "lylichkh")
    public String getLylichkh() {
        return lylichkh;
    }

    public void setLylichkh(String lylichkh) {
        this.lylichkh = lylichkh;
    }

    @Basic
    @Column(name = "ngaysinh")
    public Integer getNgaysinh() {
        return ngaysinh;
    }

    public void setNgaysinh(Integer ngaysinh) {
        this.ngaysinh = ngaysinh;
    }

    @Basic
    @Column(name = "chucvu")
    public String getChucvu() {
        return chucvu;
    }

    public void setChucvu(String chucvu) {
        this.chucvu = chucvu;
    }

    @Basic
    @Column(name = "phonenr")
    public String getPhonenr() {
        return phonenr;
    }

    public void setPhonenr(String phonenr) {
        this.phonenr = phonenr;
    }

    @Basic
    @Column(name = "mobile")
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Basic
    @Column(name = "diachinr")
    public String getDiachinr() {
        return diachinr;
    }

    public void setDiachinr(String diachinr) {
        this.diachinr = diachinr;
    }

    @Basic
    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "fax")
    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    @Basic
    @Column(name = "file_lylichkh")
    public byte[] getFileLylichkh() {
        return fileLylichkh;
    }

    public void setFileLylichkh(byte[] fileLylichkh) {
        this.fileLylichkh = fileLylichkh;
    }

    @Basic
    @Column(name = "gioitinh")
    public Integer getGioitinh() {
        return gioitinh;
    }

    public void setGioitinh(Integer gioitinh) {
        this.gioitinh = gioitinh;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblNhansuEntity that = (TblNhansuEntity) o;

        if (idNhansu != that.idNhansu) return false;
        if (chucvu != null ? !chucvu.equals(that.chucvu) : that.chucvu != null) return false;
        if (diachinr != null ? !diachinr.equals(that.diachinr) : that.diachinr != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (fax != null ? !fax.equals(that.fax) : that.fax != null) return false;
        if (!Arrays.equals(fileLylichkh, that.fileLylichkh)) return false;
        if (gioitinh != null ? !gioitinh.equals(that.gioitinh) : that.gioitinh != null) return false;
        if (hocham != null ? !hocham.equals(that.hocham) : that.hocham != null) return false;
        if (hocvi != null ? !hocvi.equals(that.hocvi) : that.hocvi != null) return false;
        if (hoten != null ? !hoten.equals(that.hoten) : that.hoten != null) return false;
        if (lylichkh != null ? !lylichkh.equals(that.lylichkh) : that.lylichkh != null) return false;
        if (mobile != null ? !mobile.equals(that.mobile) : that.mobile != null) return false;
        if (ngaysinh != null ? !ngaysinh.equals(that.ngaysinh) : that.ngaysinh != null) return false;
        if (phonenr != null ? !phonenr.equals(that.phonenr) : that.phonenr != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idNhansu;
        result = 31 * result + (hoten != null ? hoten.hashCode() : 0);
        result = 31 * result + (hocham != null ? hocham.hashCode() : 0);
        result = 31 * result + (hocvi != null ? hocvi.hashCode() : 0);
        result = 31 * result + (lylichkh != null ? lylichkh.hashCode() : 0);
        result = 31 * result + (ngaysinh != null ? ngaysinh.hashCode() : 0);
        result = 31 * result + (chucvu != null ? chucvu.hashCode() : 0);
        result = 31 * result + (phonenr != null ? phonenr.hashCode() : 0);
        result = 31 * result + (mobile != null ? mobile.hashCode() : 0);
        result = 31 * result + (diachinr != null ? diachinr.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (fax != null ? fax.hashCode() : 0);
        result = 31 * result + (fileLylichkh != null ? Arrays.hashCode(fileLylichkh) : 0);
        result = 31 * result + (gioitinh != null ? gioitinh.hashCode() : 0);
        return result;
    }
}