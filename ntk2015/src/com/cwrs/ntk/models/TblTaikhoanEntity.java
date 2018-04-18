package com.cwrs.ntk.models;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by VN on 3/18/2015.
 */
@Entity
@Table(name = "tbl_taikhoan", schema = "public", catalog = "ntm")
public class TblTaikhoanEntity {
    private int idTaikhoan;
    private String hoten;
    private String tentk;
    private Date ngaysinh;
    private Integer gioitinh;
    private String email;
    private String matkhau;
    private String dienthoai;
    private Long regTime;
    private String actKey;
    private Short active;
    private String avatar;

//    id_taikhoan serial NOT NULL,
//    hoten character varying(200),
//    tentk character varying(64),
//    ngaysinh date,
//    gioitinh integer,
//    email character varying(200),
//    matkhau character varying(200),
//    id_quyen integer,
//    dienthoai character varying(20),
//    reg_time bigint,
//    act_key character varying(64),
//    active smallint,
//    avatar character varying(255),
    
 
    public static final String TAIKHOAN_TBL = "tbl_taikhoan";
    public static final String TAIKHOAN_ID = "id_taikhoan";
    public static final String TAIKHOAN_HOTEN = "hoten";
    public static final String TAIKHOAN_TENTK = "tentk";
    public static final String TAIKHOAN_NGAYSINH = "ngaysinh";
    public static final String TAIKHOAN_GIOITINH = "gioitinh";
    public static final String TAIKHOAN_EMAIL = "email";
    public static final String TAIKHOAN_MATKHAU = "matkhau";
    public static final String TAIKHOAN_DIENTHOAI = "dienthoai";
    public static final String TAIKHOAN_REGTIM = "reg_time";
    public static final String TAIKHOAN_ACTKEY = "act_key";
    public static final String TAIKHOAN_ACTIVE = "active";
    public static final String TAIKHOAN_AVATAR = "avatar";
    public static final String TAIKHOAN_IDQUYEN = "id_quyen";
    
    @Id
    @Column(name = "id_taikhoan")
    public int getIdTaikhoan() {
        return idTaikhoan;
    }

    public void setIdTaikhoan(int idTaikhoan) {
        this.idTaikhoan = idTaikhoan;
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
    @Column(name = "tentk")
    public String getTentk() {
        return tentk;
    }

    public void setTentk(String tentk) {
        this.tentk = tentk;
    }

    @Basic
    @Column(name = "ngaysinh")
    public Date getNgaysinh() {
        return ngaysinh;
    }

    public void setNgaysinh(Date ngaysinh) {
        this.ngaysinh = ngaysinh;
    }

    @Basic
    @Column(name = "gioitinh")
    public Integer getGioitinh() {
        return gioitinh;
    }

    public void setGioitinh(Integer gioitinh) {
        this.gioitinh = gioitinh;
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
    @Column(name = "matkhau")
    public String getMatkhau() {
        return matkhau;
    }

    public void setMatkhau(String matkhau) {
        this.matkhau = matkhau;
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
    @Column(name = "reg_time")
    public Long getRegTime() {
        return regTime;
    }

    public void setRegTime(Long regTime) {
        this.regTime = regTime;
    }

    @Basic
    @Column(name = "act_key")
    public String getActKey() {
        return actKey;
    }

    public void setActKey(String actKey) {
        this.actKey = actKey;
    }

    @Basic
    @Column(name = "active")
    public Short getActive() {
        return active;
    }

    public void setActive(Short active) {
        this.active = active;
    }

    @Basic
    @Column(name = "avatar")
    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTaikhoanEntity that = (TblTaikhoanEntity) o;

        if (idTaikhoan != that.idTaikhoan) return false;
        if (actKey != null ? !actKey.equals(that.actKey) : that.actKey != null) return false;
        if (active != null ? !active.equals(that.active) : that.active != null) return false;
        if (avatar != null ? !avatar.equals(that.avatar) : that.avatar != null) return false;
        if (dienthoai != null ? !dienthoai.equals(that.dienthoai) : that.dienthoai != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (gioitinh != null ? !gioitinh.equals(that.gioitinh) : that.gioitinh != null) return false;
        if (hoten != null ? !hoten.equals(that.hoten) : that.hoten != null) return false;
        if (matkhau != null ? !matkhau.equals(that.matkhau) : that.matkhau != null) return false;
        if (ngaysinh != null ? !ngaysinh.equals(that.ngaysinh) : that.ngaysinh != null) return false;
        if (regTime != null ? !regTime.equals(that.regTime) : that.regTime != null) return false;
        if (tentk != null ? !tentk.equals(that.tentk) : that.tentk != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTaikhoan;
        result = 31 * result + (hoten != null ? hoten.hashCode() : 0);
        result = 31 * result + (tentk != null ? tentk.hashCode() : 0);
        result = 31 * result + (ngaysinh != null ? ngaysinh.hashCode() : 0);
        result = 31 * result + (gioitinh != null ? gioitinh.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (matkhau != null ? matkhau.hashCode() : 0);
        result = 31 * result + (dienthoai != null ? dienthoai.hashCode() : 0);
        result = 31 * result + (regTime != null ? regTime.hashCode() : 0);
        result = 31 * result + (actKey != null ? actKey.hashCode() : 0);
        result = 31 * result + (active != null ? active.hashCode() : 0);
        result = 31 * result + (avatar != null ? avatar.hashCode() : 0);
        return result;
    }
}
