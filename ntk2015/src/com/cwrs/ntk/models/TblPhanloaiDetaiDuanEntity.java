package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_detai_duan", schema = "public", catalog = "ntm")
public class TblPhanloaiDetaiDuanEntity {
    private int idPhannhomDetai;
    private String tenPhannhomDetai;
    
//    id_phannhom_detai integer NOT NULL,
//    ten_phannhom_detai character varying(200),
    
    public static final String PHANLOAI_DETAI_DUAN_TBL          = "tbl_phanloai_detai_duan";
    public static final String PHANLOAI_DETAI_DUAN_ID          = "id_phannhom_detai";
    public static final String PHANLOAI_DETAI_DUAN_TEN         = "ten_phannhom_detai";
    
    @Id
    @Column(name = "id_phannhom_detai")
    public int getIdPhannhomDetai() {
        return idPhannhomDetai;
    }

    public void setIdPhannhomDetai(int idPhannhomDetai) {
        this.idPhannhomDetai = idPhannhomDetai;
    }

    @Basic
    @Column(name = "ten_phannhom_detai")
    public String getTenPhannhomDetai() {
        return tenPhannhomDetai;
    }

    public void setTenPhannhomDetai(String tenPhannhomDetai) {
        this.tenPhannhomDetai = tenPhannhomDetai;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiDetaiDuanEntity that = (TblPhanloaiDetaiDuanEntity) o;

        if (idPhannhomDetai != that.idPhannhomDetai) return false;
        if (tenPhannhomDetai != null ? !tenPhannhomDetai.equals(that.tenPhannhomDetai) : that.tenPhannhomDetai != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhannhomDetai;
        result = 31 * result + (tenPhannhomDetai != null ? tenPhannhomDetai.hashCode() : 0);
        return result;
    }
}
