package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_nhansu_thamgia", schema = "public", catalog = "ntm")
public class TblNhansuThamgiaEntity {
    private int idNhansuDetai;
    private String noidungthamgia;
    private Integer sothangthamgia;
    private Integer idTaikhoan;
    private TblNhansuEntity tblNhansuByIdNhansu;

//    id_nhansu_detai integer NOT NULL,
//    id_thuyetminh_detai integer,
//    id_nhansu integer,
//    noidungthamgia character varying(200),
//    sothangthamgia integer,
//    id_vaitro integer,
//    id_taikhoan integer,
    
    public static final String NHANSU_THAMGIA_TBL ="tbl_nhansu_thamgia";
    public static final String NHANSU_THAMGIA_ID_NHANSU_DETAI ="id_nhansu_detai";
    public static final String NHANSU_THAMGIA_ID_THUYETMINH ="id_thuyetminh_detai";
    public static final String NHANSU_THAMGIA_ID_NHANSU ="id_nhansu";
    public static final String NHANSU_THAMGIA_NOIDUNG ="noidungthamgia";
    public static final String NHANSU_THAMGIA_SOTHANG ="sothangthamgia";
    public static final String NHANSU_THAMGIA_ID_VAITRO ="id_vaitro";
    public static final String NHANSU_THAMGIA_TAIKHOAN ="id_taikhoan";
    
    @Id
    @Column(name = "id_nhansu_detai")
    public int getIdNhansuDetai() {
        return idNhansuDetai;
    }

    public void setIdNhansuDetai(int idNhansuDetai) {
        this.idNhansuDetai = idNhansuDetai;
    }

    @Basic
    @Column(name = "noidungthamgia")
    public String getNoidungthamgia() {
        return noidungthamgia;
    }

    public void setNoidungthamgia(String noidungthamgia) {
        this.noidungthamgia = noidungthamgia;
    }

    @Basic
    @Column(name = "sothangthamgia")
    public Integer getSothangthamgia() {
        return sothangthamgia;
    }

    public void setSothangthamgia(Integer sothangthamgia) {
        this.sothangthamgia = sothangthamgia;
    }

    @Basic
    @Column(name = "id_taikhoan")
    public Integer getIdTaikhoan() {
        return idTaikhoan;
    }

    public void setIdTaikhoan(Integer idTaikhoan) {
        this.idTaikhoan = idTaikhoan;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblNhansuThamgiaEntity that = (TblNhansuThamgiaEntity) o;

        if (idNhansuDetai != that.idNhansuDetai) return false;
        if (idTaikhoan != null ? !idTaikhoan.equals(that.idTaikhoan) : that.idTaikhoan != null) return false;
        if (noidungthamgia != null ? !noidungthamgia.equals(that.noidungthamgia) : that.noidungthamgia != null)
            return false;
        if (sothangthamgia != null ? !sothangthamgia.equals(that.sothangthamgia) : that.sothangthamgia != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idNhansuDetai;
        result = 31 * result + (noidungthamgia != null ? noidungthamgia.hashCode() : 0);
        result = 31 * result + (sothangthamgia != null ? sothangthamgia.hashCode() : 0);
        result = 31 * result + (idTaikhoan != null ? idTaikhoan.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_nhansu", referencedColumnName = "id_nhansu")
    public TblNhansuEntity getTblNhansuByIdNhansu() {
        return tblNhansuByIdNhansu;
    }

    public void setTblNhansuByIdNhansu(TblNhansuEntity tblNhansuByIdNhansu) {
        this.tblNhansuByIdNhansu = tblNhansuByIdNhansu;
    }
}