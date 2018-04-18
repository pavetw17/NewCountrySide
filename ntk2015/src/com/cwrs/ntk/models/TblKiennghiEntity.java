package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_kiennghi", schema = "public", catalog = "ntm")
public class TblKiennghiEntity {
    private int idKiennghi;
    private String tenkiennghi;

//    id_kiennghi integer NOT NULL,
//    tenkiennghi character varying(200),
    
    public static final String KIENNGHI_TBL         = "tbl_kiennghi";
    public static final String KIENNGHI_ID         = "id_kiennghi";
    public static final String KIENNGHI_TEN         = "tenkiennghi";
    
    @Id
    @Column(name = "id_kiennghi")
    public int getIdKiennghi() {
        return idKiennghi;
    }

    public void setIdKiennghi(int idKiennghi) {
        this.idKiennghi = idKiennghi;
    }

    @Basic
    @Column(name = "tenkiennghi")
    public String getTenkiennghi() {
        return tenkiennghi;
    }

    public void setTenkiennghi(String tenkiennghi) {
        this.tenkiennghi = tenkiennghi;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblKiennghiEntity that = (TblKiennghiEntity) o;

        if (idKiennghi != that.idKiennghi) return false;
        if (tenkiennghi != null ? !tenkiennghi.equals(that.tenkiennghi) : that.tenkiennghi != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idKiennghi;
        result = 31 * result + (tenkiennghi != null ? tenkiennghi.hashCode() : 0);
        return result;
    }
}
