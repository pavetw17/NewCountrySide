package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_khuvuc", schema = "public", catalog = "ntm")
public class TblPhanloaiKhuvucEntity {
    private int idKhuvuc;
    private String tenKhuvuc;
    
//    id_khuvuc integer NOT NULL,
//    ten_khuvuc character varying(500), -- vùng sinh thái
    
    public static final String PHANLOAI_KHUVUC_TBL          = "tbl_phanloai_khuvuc";
    public static final String PHANLOAI_KHUVUC_ID          = "id_khuvuc";
    public static final String PHANLOAI_KHUVUC_TEN         = "ten_khuvuc";

    @Id
    @Column(name = "id_khuvuc")
    public int getIdKhuvuc() {
        return idKhuvuc;
    }

    public void setIdKhuvuc(int idKhuvuc) {
        this.idKhuvuc = idKhuvuc;
    }

    @Basic
    @Column(name = "ten_khuvuc")
    public String getTenKhuvuc() {
        return tenKhuvuc;
    }

    public void setTenKhuvuc(String tenKhuvuc) {
        this.tenKhuvuc = tenKhuvuc;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiKhuvucEntity that = (TblPhanloaiKhuvucEntity) o;

        if (idKhuvuc != that.idKhuvuc) return false;
        if (tenKhuvuc != null ? !tenKhuvuc.equals(that.tenKhuvuc) : that.tenKhuvuc != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idKhuvuc;
        result = 31 * result + (tenKhuvuc != null ? tenKhuvuc.hashCode() : 0);
        return result;
    }
}
