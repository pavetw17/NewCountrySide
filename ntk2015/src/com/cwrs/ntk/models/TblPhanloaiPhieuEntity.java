package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_phieu", schema = "public", catalog = "ntm")
public class TblPhanloaiPhieuEntity {
    private int idPhanloaiphieu;
    private String tenPhanloaiPhieu;
    
//    id_phanloaiphieu integer NOT NULL,
//    ten_phanloai_phieu character varying(200)
    
    public static final String PHANLOAI_PHIEU_TBL         = "tbl_phanloai_phieu";
    public static final String PHANLOAI_PHIEU_ID         = "id_phanloaiphieu";
    public static final String PHANLOAI_PHIEU_TEN         = "ten_phanloai_phieu";

    @Id
    @Column(name = "id_phanloaiphieu")
    public int getIdPhanloaiphieu() {
        return idPhanloaiphieu;
    }

    public void setIdPhanloaiphieu(int idPhanloaiphieu) {
        this.idPhanloaiphieu = idPhanloaiphieu;
    }

    @Basic
    @Column(name = "ten_phanloai_phieu")
    public String getTenPhanloaiPhieu() {
        return tenPhanloaiPhieu;
    }

    public void setTenPhanloaiPhieu(String tenPhanloaiPhieu) {
        this.tenPhanloaiPhieu = tenPhanloaiPhieu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiPhieuEntity that = (TblPhanloaiPhieuEntity) o;

        if (idPhanloaiphieu != that.idPhanloaiphieu) return false;
        if (tenPhanloaiPhieu != null ? !tenPhanloaiPhieu.equals(that.tenPhanloaiPhieu) : that.tenPhanloaiPhieu != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloaiphieu;
        result = 31 * result + (tenPhanloaiPhieu != null ? tenPhanloaiPhieu.hashCode() : 0);
        return result;
    }
}
