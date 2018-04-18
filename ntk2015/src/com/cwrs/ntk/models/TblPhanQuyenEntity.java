package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phan_quyen", schema = "public", catalog = "ntm")
public class TblPhanQuyenEntity {
    private int idQuyen;
    private String tenQuyen;

    /*id_quyen integer NOT NULL,
    ten_quyen character varying(100),*/

    public static final String PHANQUYEN_TBL          = "tbl_phan_quyen";
    public static final String PHANQUYEN_ID           = "id_quyen";
    public static final String PHANQUYEN_TEN          = "ten_quyen";

    @Id
    @Column(name = "id_quyen")
    public int getIdQuyen() {
        return idQuyen;
    }

    public void setIdQuyen(int idQuyen) {
        this.idQuyen = idQuyen;
    }

    @Basic
    @Column(name = "ten_quyen")
    public String getTenQuyen() {
        return tenQuyen;
    }

    public void setTenQuyen(String tenQuyen) {
        this.tenQuyen = tenQuyen;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanQuyenEntity that = (TblPhanQuyenEntity) o;

        if (idQuyen != that.idQuyen) return false;
        if (tenQuyen != null ? !tenQuyen.equals(that.tenQuyen) : that.tenQuyen != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idQuyen;
        result = 31 * result + (tenQuyen != null ? tenQuyen.hashCode() : 0);
        return result;
    }
}
