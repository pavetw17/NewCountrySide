package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_tintuc", schema = "public", catalog = "ntm")
public class TblPhanloaiTintucEntity {
    private int idPhanloaiTintuc;
    private String tenPhanloai;

//    id_phanloai_tintuc integer NOT NULL,
//    ten_phanloai character varying(200),
    
    public static final String PHANLOAI_TINTUC_TBL          = "tbl_phanloai_tintuc";
    public static final String PHANLOAI_TINTUC_ID          = "id_phanloai_tintuc";
    public static final String PHANLOAI_TINTUC_TEN          = "ten_phanloai";
    
    @Id
    @Column(name = "id_phanloai_tintuc")
    public int getIdPhanloaiTintuc() {
        return idPhanloaiTintuc;
    }

    public void setIdPhanloaiTintuc(int idPhanloaiTintuc) {
        this.idPhanloaiTintuc = idPhanloaiTintuc;
    }

    @Basic
    @Column(name = "ten_phanloai")
    public String getTenPhanloai() {
        return tenPhanloai;
    }

    public void setTenPhanloai(String tenPhanloai) {
        this.tenPhanloai = tenPhanloai;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiTintucEntity that = (TblPhanloaiTintucEntity) o;

        if (idPhanloaiTintuc != that.idPhanloaiTintuc) return false;
        if (tenPhanloai != null ? !tenPhanloai.equals(that.tenPhanloai) : that.tenPhanloai != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloaiTintuc;
        result = 31 * result + (tenPhanloai != null ? tenPhanloai.hashCode() : 0);
        return result;
    }
}
