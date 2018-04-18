package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_sp", schema = "public", catalog = "ntm")
public class TblPhanloaiSpEntity {
    private int idPhanloaiSp;
    private String tenPhanloaiSp;

    @Id
    @Column(name = "id_phanloai_sp")
    public int getIdPhanloaiSp() {
        return idPhanloaiSp;
    }

    public void setIdPhanloaiSp(int idPhanloaiSp) {
        this.idPhanloaiSp = idPhanloaiSp;
    }

    @Basic
    @Column(name = "ten_phanloai_sp")
    public String getTenPhanloaiSp() {
        return tenPhanloaiSp;
    }

    public void setTenPhanloaiSp(String tenPhanloaiSp) {
        this.tenPhanloaiSp = tenPhanloaiSp;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiSpEntity that = (TblPhanloaiSpEntity) o;

        if (idPhanloaiSp != that.idPhanloaiSp) return false;
        if (tenPhanloaiSp != null ? !tenPhanloaiSp.equals(that.tenPhanloaiSp) : that.tenPhanloaiSp != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloaiSp;
        result = 31 * result + (tenPhanloaiSp != null ? tenPhanloaiSp.hashCode() : 0);
        return result;
    }
}
