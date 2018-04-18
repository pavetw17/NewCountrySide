package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_huyen", schema = "public", catalog = "ntm")
public class TblHuyenEntity {
    private int idHuyen;
    private String tenQuanhuyen;

    @Id
    @Column(name = "id_huyen")
    public int getIdHuyen() {
        return idHuyen;
    }

    public void setIdHuyen(int idHuyen) {
        this.idHuyen = idHuyen;
    }

    @Basic
    @Column(name = "ten_quanhuyen")
    public String getTenQuanhuyen() {
        return tenQuanhuyen;
    }

    public void setTenQuanhuyen(String tenQuanhuyen) {
        this.tenQuanhuyen = tenQuanhuyen;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblHuyenEntity that = (TblHuyenEntity) o;

        if (idHuyen != that.idHuyen) return false;
        if (tenQuanhuyen != null ? !tenQuanhuyen.equals(that.tenQuanhuyen) : that.tenQuanhuyen != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idHuyen;
        result = 31 * result + (tenQuanhuyen != null ? tenQuanhuyen.hashCode() : 0);
        return result;
    }
}
