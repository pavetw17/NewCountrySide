package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_baocao", schema = "public", catalog = "ntm")
public class TblPhanloaiBaocaoEntity {
    private int idPhanloaibaocao;
    private String tenphanloai;
    
//    id_phanloaibaocao integer NOT NULL,
//    tenphanloai character varying(200), -- báo cáo chuyên đề, bc tổng hợp, bc tóm tắt
    
    public static final String PHANLOAI_BAOCAO_TBL          = "tbl_phanloai_baocao";
    public static final String PHANLOAI_BAOCAO_ID          = "id_phanloaibaocao";
    public static final String PHANLOAI_BAOCAO_TEN          = "tenphanloai";


    @Id
    @Column(name = "id_phanloaibaocao")
    public int getIdPhanloaibaocao() {
        return idPhanloaibaocao;
    }

    public void setIdPhanloaibaocao(int idPhanloaibaocao) {
        this.idPhanloaibaocao = idPhanloaibaocao;
    }

    @Basic
    @Column(name = "tenphanloai")
    public String getTenphanloai() {
        return tenphanloai;
    }

    public void setTenphanloai(String tenphanloai) {
        this.tenphanloai = tenphanloai;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiBaocaoEntity that = (TblPhanloaiBaocaoEntity) o;

        if (idPhanloaibaocao != that.idPhanloaibaocao) return false;
        if (tenphanloai != null ? !tenphanloai.equals(that.tenphanloai) : that.tenphanloai != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloaibaocao;
        result = 31 * result + (tenphanloai != null ? tenphanloai.hashCode() : 0);
        return result;
    }
}
