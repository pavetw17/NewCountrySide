package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_kq", schema = "public", catalog = "ntm")
public class TblPhanloaiKqEntity {
    private int idPhanloai;
    private String tenPhanloai;
    private Integer sothangDinhchi;
    
//    id_phanloai integer NOT NULL,
//    ten_phanloai character varying(200),
    
    public static final String PHANLOAI_KQ_TBL          = "tbl_phanloai_kq";
    public static final String PHANLOAI_KQ_ID         = "id_phanloai";
    public static final String PHANLOAI_KQ_TEN          = "ten_phanloai";

    @Id
    @Column(name = "id_phanloai")
    public int getIdPhanloai() {
        return idPhanloai;
    }

    public void setIdPhanloai(int idPhanloai) {
        this.idPhanloai = idPhanloai;
    }

    @Basic
    @Column(name = "ten_phanloai")
    public String getTenPhanloai() {
        return tenPhanloai;
    }

    public void setTenPhanloai(String tenPhanloai) {
        this.tenPhanloai = tenPhanloai;
    }

    @Basic
    @Column(name = "sothang_dinhchi")
    public Integer getSothangDinhchi() {
        return sothangDinhchi;
    }

    public void setSothangDinhchi(Integer sothangDinhchi) {
        this.sothangDinhchi = sothangDinhchi;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiKqEntity that = (TblPhanloaiKqEntity) o;

        if (idPhanloai != that.idPhanloai) return false;
        if (sothangDinhchi != null ? !sothangDinhchi.equals(that.sothangDinhchi) : that.sothangDinhchi != null)
            return false;
        if (tenPhanloai != null ? !tenPhanloai.equals(that.tenPhanloai) : that.tenPhanloai != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloai;
        result = 31 * result + (tenPhanloai != null ? tenPhanloai.hashCode() : 0);
        result = 31 * result + (sothangDinhchi != null ? sothangDinhchi.hashCode() : 0);
        return result;
    }
}
