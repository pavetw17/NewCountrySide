package com.cwrs.ntk.models;

import javax.persistence.*;

import java.sql.Date;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tochuc", schema = "public", catalog = "ntm")
public class TblTochucEntity {
    private int idTochuc;
    private String tentc;
    private String phonecq;
    private String fax;
    private String sotk;
    private String nganhang;
    private String email;
    private String website;
    private String tencqcq;
    private String tenThutruong;
    private String diachiCoquan;
    private Date namThanhLap;
    private Integer soCanboTrinhdoDh;
    private Integer soCanboTrinhdoTs;
    private Integer soCanboTrinhdoThs;
    private String phoneThutruong;
    private String logo;

//    id_tochuc integer NOT NULL DEFAULT nextval('tbl_tochu_id_tochu_seq'::regclass),
//    tentc character varying(200),
//    phonecq character varying(20),
//    fax character varying(20),
//    sotk character varying(20),
//    nganhang character varying(200),
//    email character varying(100),
//    website character varying(100),
//    tencqcq character varying(200),
//    ten_thutruong character varying(200),
//    diachi_coquan character varying(200),
//    nam_thanh_lap date,
//    so_canbo_trinhdo_dh integer,
//    so_canbo_trinhdo_ts integer,
//    so_canbo_trinhdo_ths integer,
//    phone_thutruong character varying(20),
//    logo character varying(255), -- đường dẫn đến logo của tổ chức
    
    
    public static final String TOCHUC_TBL = "tbl_tochuc";
    public static final String TOCHUC_ID = "id_tochuc";
    public static final String TOCHUC_TEN = "tentc";
    public static final String TOCHUC_PHONE = "phonecq";
    public static final String TOCHUC_FAX = "fax";
    public static final String TOCHUC_SOTK = "sotk";
    public static final String TOCHUC_NGANHANG = "nganhang";
    public static final String TOCHUC_EMAIL = "email";
    public static final String TOCHUC_WEBSITE = "website";
    public static final String TOCHUC_TENCQCQ = "tencqcq";
    public static final String TOCHUC_THUTRUONG = "ten_thutruong";
    public static final String TOCHUC_DIACHI = "diachi_coquan";
    public static final String TOCHUC_NAM = "nam_thanh_lap";
    public static final String TOCHUC_CANBO_DAIHOC = "so_canbo_trinhdo_dh";
    public static final String TOCHUC_CANBO_TIENSI = "so_canbo_trinhdo_ts";
    public static final String TOCHUC_CANBO_THACSI = "so_canbo_trinhdo_ths";
    public static final String TOCHUC_PHONE_THUTRUONG = "phone_thutruong";
    public static final String TOCHUC_LOGO = "logo";
    
    @Id
    @Column(name = "id_tochuc")
    public int getIdTochuc() {
        return idTochuc;
    }

    public void setIdTochuc(int idTochuc) {
        this.idTochuc = idTochuc;
    }

    @Basic
    @Column(name = "tentc")
    public String getTentc() {
        return tentc;
    }

    public void setTentc(String tentc) {
        this.tentc = tentc;
    }

    @Basic
    @Column(name = "phonecq")
    public String getPhonecq() {
        return phonecq;
    }

    public void setPhonecq(String phonecq) {
        this.phonecq = phonecq;
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
    @Column(name = "sotk")
    public String getSotk() {
        return sotk;
    }

    public void setSotk(String sotk) {
        this.sotk = sotk;
    }

    @Basic
    @Column(name = "nganhang")
    public String getNganhang() {
        return nganhang;
    }

    public void setNganhang(String nganhang) {
        this.nganhang = nganhang;
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
    @Column(name = "website")
    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    @Basic
    @Column(name = "tencqcq")
    public String getTencqcq() {
        return tencqcq;
    }

    public void setTencqcq(String tencqcq) {
        this.tencqcq = tencqcq;
    }

    @Basic
    @Column(name = "ten_thutruong")
    public String getTenThutruong() {
        return tenThutruong;
    }

    public void setTenThutruong(String tenThutruong) {
        this.tenThutruong = tenThutruong;
    }

    @Basic
    @Column(name = "diachi_coquan")
    public String getDiachiCoquan() {
        return diachiCoquan;
    }

    public void setDiachiCoquan(String diachiCoquan) {
        this.diachiCoquan = diachiCoquan;
    }

    @Basic
    @Column(name = "nam_thanh_lap")
    public Date getNamThanhLap() {
        return namThanhLap;
    }

    public void setNamThanhLap(Date namThanhLap) {
        this.namThanhLap = namThanhLap;
    }

    @Basic
    @Column(name = "so_canbo_trinhdo_dh")
    public Integer getSoCanboTrinhdoDh() {
        return soCanboTrinhdoDh;
    }

    public void setSoCanboTrinhdoDh(Integer soCanboTrinhdoDh) {
        this.soCanboTrinhdoDh = soCanboTrinhdoDh;
    }

    @Basic
    @Column(name = "so_canbo_trinhdo_ts")
    public Integer getSoCanboTrinhdoTs() {
        return soCanboTrinhdoTs;
    }

    public void setSoCanboTrinhdoTs(Integer soCanboTrinhdoTs) {
        this.soCanboTrinhdoTs = soCanboTrinhdoTs;
    }

    @Basic
    @Column(name = "so_canbo_trinhdo_ths")
    public Integer getSoCanboTrinhdoThs() {
        return soCanboTrinhdoThs;
    }

    public void setSoCanboTrinhdoThs(Integer soCanboTrinhdoThs) {
        this.soCanboTrinhdoThs = soCanboTrinhdoThs;
    }

    @Basic
    @Column(name = "phone_thutruong")
    public String getPhoneThutruong() {
        return phoneThutruong;
    }

    public void setPhoneThutruong(String phoneThutruong) {
        this.phoneThutruong = phoneThutruong;
    }

    @Basic
    @Column(name = "logo")
    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTochucEntity that = (TblTochucEntity) o;

        if (idTochuc != that.idTochuc) return false;
        if (diachiCoquan != null ? !diachiCoquan.equals(that.diachiCoquan) : that.diachiCoquan != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (fax != null ? !fax.equals(that.fax) : that.fax != null) return false;
        if (logo != null ? !logo.equals(that.logo) : that.logo != null) return false;
        if (namThanhLap != null ? !namThanhLap.equals(that.namThanhLap) : that.namThanhLap != null) return false;
        if (nganhang != null ? !nganhang.equals(that.nganhang) : that.nganhang != null) return false;
        if (phoneThutruong != null ? !phoneThutruong.equals(that.phoneThutruong) : that.phoneThutruong != null)
            return false;
        if (phonecq != null ? !phonecq.equals(that.phonecq) : that.phonecq != null) return false;
        if (soCanboTrinhdoDh != null ? !soCanboTrinhdoDh.equals(that.soCanboTrinhdoDh) : that.soCanboTrinhdoDh != null)
            return false;
        if (soCanboTrinhdoThs != null ? !soCanboTrinhdoThs.equals(that.soCanboTrinhdoThs) : that.soCanboTrinhdoThs != null)
            return false;
        if (soCanboTrinhdoTs != null ? !soCanboTrinhdoTs.equals(that.soCanboTrinhdoTs) : that.soCanboTrinhdoTs != null)
            return false;
        if (sotk != null ? !sotk.equals(that.sotk) : that.sotk != null) return false;
        if (tenThutruong != null ? !tenThutruong.equals(that.tenThutruong) : that.tenThutruong != null) return false;
        if (tencqcq != null ? !tencqcq.equals(that.tencqcq) : that.tencqcq != null) return false;
        if (tentc != null ? !tentc.equals(that.tentc) : that.tentc != null) return false;
        if (website != null ? !website.equals(that.website) : that.website != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTochuc;
        result = 31 * result + (tentc != null ? tentc.hashCode() : 0);
        result = 31 * result + (phonecq != null ? phonecq.hashCode() : 0);
        result = 31 * result + (fax != null ? fax.hashCode() : 0);
        result = 31 * result + (sotk != null ? sotk.hashCode() : 0);
        result = 31 * result + (nganhang != null ? nganhang.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (website != null ? website.hashCode() : 0);
        result = 31 * result + (tencqcq != null ? tencqcq.hashCode() : 0);
        result = 31 * result + (tenThutruong != null ? tenThutruong.hashCode() : 0);
        result = 31 * result + (diachiCoquan != null ? diachiCoquan.hashCode() : 0);
        result = 31 * result + (namThanhLap != null ? namThanhLap.hashCode() : 0);
        result = 31 * result + (soCanboTrinhdoDh != null ? soCanboTrinhdoDh.hashCode() : 0);
        result = 31 * result + (soCanboTrinhdoTs != null ? soCanboTrinhdoTs.hashCode() : 0);
        result = 31 * result + (soCanboTrinhdoThs != null ? soCanboTrinhdoThs.hashCode() : 0);
        result = 31 * result + (phoneThutruong != null ? phoneThutruong.hashCode() : 0);
        result = 31 * result + (logo != null ? logo.hashCode() : 0);
        return result;
    }
}
