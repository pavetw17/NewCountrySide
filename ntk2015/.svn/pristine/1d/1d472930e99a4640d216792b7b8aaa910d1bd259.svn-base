package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_xadiem", schema = "public", catalog = "ntm")
public class TblXadiemEntity {
    private int idXadiem;
    private String tenXadiem;
    private String dacdiemDialy;
    private String dacdiemTunhien;
    private String dacdiemKinhte;
    private String dacdiemXahoi;
    private String dacdiemMohinhXaydung;
    private String loaihinhKhoahocApdung;

    public static final String XADIEM_TBL    = "tbl_xadiem";
    public static final String XADIEM_ID    = "id_xadiem";
    public static final String XADIEM_TEN    = "ten_xadiem";
    
    @Id
    @Column(name = "id_xadiem")
    public int getIdXadiem() {
        return idXadiem;
    }

    public void setIdXadiem(int idXadiem) {
        this.idXadiem = idXadiem;
    }

    @Basic
    @Column(name = "ten_xadiem")
    public String getTenXadiem() {
        return tenXadiem;
    }

    public void setTenXadiem(String tenXadiem) {
        this.tenXadiem = tenXadiem;
    }

    @Basic
    @Column(name = "dacdiem_dialy")
    public String getDacdiemDialy() {
        return dacdiemDialy;
    }

    public void setDacdiemDialy(String dacdiemDialy) {
        this.dacdiemDialy = dacdiemDialy;
    }

    @Basic
    @Column(name = "dacdiem_tunhien")
    public String getDacdiemTunhien() {
        return dacdiemTunhien;
    }

    public void setDacdiemTunhien(String dacdiemTunhien) {
        this.dacdiemTunhien = dacdiemTunhien;
    }

    @Basic
    @Column(name = "dacdiem_kinhte")
    public String getDacdiemKinhte() {
        return dacdiemKinhte;
    }

    public void setDacdiemKinhte(String dacdiemKinhte) {
        this.dacdiemKinhte = dacdiemKinhte;
    }

    @Basic
    @Column(name = "dacdiem_xahoi")
    public String getDacdiemXahoi() {
        return dacdiemXahoi;
    }

    public void setDacdiemXahoi(String dacdiemXahoi) {
        this.dacdiemXahoi = dacdiemXahoi;
    }

    @Basic
    @Column(name = "dacdiem_mohinh_xaydung")
    public String getDacdiemMohinhXaydung() {
        return dacdiemMohinhXaydung;
    }

    public void setDacdiemMohinhXaydung(String dacdiemMohinhXaydung) {
        this.dacdiemMohinhXaydung = dacdiemMohinhXaydung;
    }

    @Basic
    @Column(name = "loaihinh_khoahoc_apdung")
    public String getLoaihinhKhoahocApdung() {
        return loaihinhKhoahocApdung;
    }

    public void setLoaihinhKhoahocApdung(String loaihinhKhoahocApdung) {
        this.loaihinhKhoahocApdung = loaihinhKhoahocApdung;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblXadiemEntity that = (TblXadiemEntity) o;

        if (idXadiem != that.idXadiem) return false;
        if (dacdiemDialy != null ? !dacdiemDialy.equals(that.dacdiemDialy) : that.dacdiemDialy != null) return false;
        if (dacdiemKinhte != null ? !dacdiemKinhte.equals(that.dacdiemKinhte) : that.dacdiemKinhte != null)
            return false;
        if (dacdiemMohinhXaydung != null ? !dacdiemMohinhXaydung.equals(that.dacdiemMohinhXaydung) : that.dacdiemMohinhXaydung != null)
            return false;
        if (dacdiemTunhien != null ? !dacdiemTunhien.equals(that.dacdiemTunhien) : that.dacdiemTunhien != null)
            return false;
        if (dacdiemXahoi != null ? !dacdiemXahoi.equals(that.dacdiemXahoi) : that.dacdiemXahoi != null) return false;
        if (loaihinhKhoahocApdung != null ? !loaihinhKhoahocApdung.equals(that.loaihinhKhoahocApdung) : that.loaihinhKhoahocApdung != null)
            return false;
        if (tenXadiem != null ? !tenXadiem.equals(that.tenXadiem) : that.tenXadiem != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idXadiem;
        result = 31 * result + (tenXadiem != null ? tenXadiem.hashCode() : 0);
        result = 31 * result + (dacdiemDialy != null ? dacdiemDialy.hashCode() : 0);
        result = 31 * result + (dacdiemTunhien != null ? dacdiemTunhien.hashCode() : 0);
        result = 31 * result + (dacdiemKinhte != null ? dacdiemKinhte.hashCode() : 0);
        result = 31 * result + (dacdiemXahoi != null ? dacdiemXahoi.hashCode() : 0);
        result = 31 * result + (dacdiemMohinhXaydung != null ? dacdiemMohinhXaydung.hashCode() : 0);
        result = 31 * result + (loaihinhKhoahocApdung != null ? loaihinhKhoahocApdung.hashCode() : 0);
        return result;
    }
}
