package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_chuyengia", schema = "public", catalog = "ntm")
public class TblChuyengiaEntity {
    private int idChuyengia;
    private String hoten;
    private String donvictac;
    private String chucvu;
    private String hocham;
    private String hocvi;
    private String khoictac;
    private String dienthoai;
    private String mobile;
    private String email;
    private String diachicty;
    private Boolean nghihuu;

//    id_chuyengia serial NOT NULL,
//    hoten character varying(100), -- họ tên đầy đủ
//    donvictac character varying(100), -- đơn vị công tác
//    chucvu character varying(100), -- chức vụ
//    hocham character varying(100), -- học hàm
//    hocvi character varying(100), -- học vị
//    khoictac character varying(100), -- khối công tác (đại học, hành chính sự nghiệp,...)
//    dienthoai character varying(50), -- số điện thoại liên hệ
//    mobile character varying(100), -- số di động
//    email character varying(100), -- hòm thư điện tử
//    diachicty character varying(200), -- địa chỉ cơ quan
//    nghihuu boolean, -- nghỉ hưu chưa?
//    CONSTRAINT tbl_chuyengia_pkey PRIMARY KEY (id_chuyengia )
    
    public static final String CHUYENGIA_TBL         = "tbl_chuyengia";
    public static final String CHUYENGIA_ID         = "id_chuyengia";
    public static final String CHUYENGIA_HOTEN         = "hoten";
    public static final String CHUYENGIA_CHUCVU         = "chucvu";
    public static final String CHUYENGIA_DIENTHOAI         = "dienthoai";
    public static final String CHUYENGIA_DONVI_CONGTAC         = "donvictac";
    
    
    @Id
    @Column(name = "id_chuyengia")
    public int getIdChuyengia() {
        return idChuyengia;
    }

    public void setIdChuyengia(int idChuyengia) {
        this.idChuyengia = idChuyengia;
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
    @Column(name = "donvictac")
    public String getDonvictac() {
        return donvictac;
    }

    public void setDonvictac(String donvictac) {
        this.donvictac = donvictac;
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
    @Column(name = "khoictac")
    public String getKhoictac() {
        return khoictac;
    }

    public void setKhoictac(String khoictac) {
        this.khoictac = khoictac;
    }

    @Basic
    @Column(name = "dienthoai")
    public String getDienthoai() {
        return dienthoai;
    }

    public void setDienthoai(String dienthoai) {
        this.dienthoai = dienthoai;
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
    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "diachicty")
    public String getDiachicty() {
        return diachicty;
    }

    public void setDiachicty(String diachicty) {
        this.diachicty = diachicty;
    }

    @Basic
    @Column(name = "nghihuu")
    public Boolean getNghihuu() {
        return nghihuu;
    }

    public void setNghihuu(Boolean nghihuu) {
        this.nghihuu = nghihuu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblChuyengiaEntity that = (TblChuyengiaEntity) o;

        if (idChuyengia != that.idChuyengia) return false;
        if (chucvu != null ? !chucvu.equals(that.chucvu) : that.chucvu != null) return false;
        if (diachicty != null ? !diachicty.equals(that.diachicty) : that.diachicty != null) return false;
        if (dienthoai != null ? !dienthoai.equals(that.dienthoai) : that.dienthoai != null) return false;
        if (donvictac != null ? !donvictac.equals(that.donvictac) : that.donvictac != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (hocham != null ? !hocham.equals(that.hocham) : that.hocham != null) return false;
        if (hocvi != null ? !hocvi.equals(that.hocvi) : that.hocvi != null) return false;
        if (hoten != null ? !hoten.equals(that.hoten) : that.hoten != null) return false;
        if (khoictac != null ? !khoictac.equals(that.khoictac) : that.khoictac != null) return false;
        if (mobile != null ? !mobile.equals(that.mobile) : that.mobile != null) return false;
        if (nghihuu != null ? !nghihuu.equals(that.nghihuu) : that.nghihuu != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idChuyengia;
        result = 31 * result + (hoten != null ? hoten.hashCode() : 0);
        result = 31 * result + (donvictac != null ? donvictac.hashCode() : 0);
        result = 31 * result + (chucvu != null ? chucvu.hashCode() : 0);
        result = 31 * result + (hocham != null ? hocham.hashCode() : 0);
        result = 31 * result + (hocvi != null ? hocvi.hashCode() : 0);
        result = 31 * result + (khoictac != null ? khoictac.hashCode() : 0);
        result = 31 * result + (dienthoai != null ? dienthoai.hashCode() : 0);
        result = 31 * result + (mobile != null ? mobile.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (diachicty != null ? diachicty.hashCode() : 0);
        result = 31 * result + (nghihuu != null ? nghihuu.hashCode() : 0);
        return result;
    }
}
