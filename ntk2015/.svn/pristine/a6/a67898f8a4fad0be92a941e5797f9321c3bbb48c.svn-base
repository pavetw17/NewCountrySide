package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tinhthanh", schema = "public", catalog = "ntm")
public class TblTinhthanhEntity {
    private int idTinh;
    private String tenTinhthanh;

    @Id
    @Column(name = "id_tinh")
    public int getIdTinh() {
        return idTinh;
    }

    public void setIdTinh(int idTinh) {
        this.idTinh = idTinh;
    }

    @Basic
    @Column(name = "ten_tinhthanh")
    public String getTenTinhthanh() {
        return tenTinhthanh;
    }

    public void setTenTinhthanh(String tenTinhthanh) {
        this.tenTinhthanh = tenTinhthanh;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTinhthanhEntity that = (TblTinhthanhEntity) o;

        if (idTinh != that.idTinh) return false;
        if (tenTinhthanh != null ? !tenTinhthanh.equals(that.tenTinhthanh) : that.tenTinhthanh != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTinh;
        result = 31 * result + (tenTinhthanh != null ? tenTinhthanh.hashCode() : 0);
        return result;
    }
}
