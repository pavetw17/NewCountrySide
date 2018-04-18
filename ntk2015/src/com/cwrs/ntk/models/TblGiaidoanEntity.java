package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_giaidoan", schema = "public", catalog = "ntm")
public class TblGiaidoanEntity {
    private int idGiaidoan;
    private String tengiaidoan;
    private String noidung;
    private Integer tungay;
    private Integer denngay;

    @Id
    @Column(name = "id_giaidoan")
    public int getIdGiaidoan() {
        return idGiaidoan;
    }

    public void setIdGiaidoan(int idGiaidoan) {
        this.idGiaidoan = idGiaidoan;
    }

    @Basic
    @Column(name = "tengiaidoan")
    public String getTengiaidoan() {
        return tengiaidoan;
    }

    public void setTengiaidoan(String tengiaidoan) {
        this.tengiaidoan = tengiaidoan;
    }

    @Basic
    @Column(name = "noidung")
    public String getNoidung() {
        return noidung;
    }

    public void setNoidung(String noidung) {
        this.noidung = noidung;
    }

    @Basic
    @Column(name = "tungay")
    public Integer getTungay() {
        return tungay;
    }

    public void setTungay(Integer tungay) {
        this.tungay = tungay;
    }

    @Basic
    @Column(name = "denngay")
    public Integer getDenngay() {
        return denngay;
    }

    public void setDenngay(Integer denngay) {
        this.denngay = denngay;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblGiaidoanEntity that = (TblGiaidoanEntity) o;

        if (idGiaidoan != that.idGiaidoan) return false;
        if (denngay != null ? !denngay.equals(that.denngay) : that.denngay != null) return false;
        if (noidung != null ? !noidung.equals(that.noidung) : that.noidung != null) return false;
        if (tengiaidoan != null ? !tengiaidoan.equals(that.tengiaidoan) : that.tengiaidoan != null) return false;
        if (tungay != null ? !tungay.equals(that.tungay) : that.tungay != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idGiaidoan;
        result = 31 * result + (tengiaidoan != null ? tengiaidoan.hashCode() : 0);
        result = 31 * result + (noidung != null ? noidung.hashCode() : 0);
        result = 31 * result + (tungay != null ? tungay.hashCode() : 0);
        result = 31 * result + (denngay != null ? denngay.hashCode() : 0);
        return result;
    }
}
