package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tieuchi_ungdung", schema = "public", catalog = "ntm")
@IdClass(TblTieuchiUngdungEntityPK.class)
public class TblTieuchiUngdungEntity {
    private int idTieuchi;
    private int idThuyetminhDetai;
    private TblThuyetminhDetaiDuanEntity tblThuyetminhDetaiDuanByIdThuyetminhDetai;
    private TblXadiemEntity tblXadiemByIdXadiem;

//    id_tieuchi integer NOT NULL,
//    id_thuyetminh_detai integer NOT NULL,
//    id_xadiem integer,
    
    public static final String TIEUCHI_UNGDUNG_TBL          = "tbl_tieuchi_ungdung";
    public static final String TIEUCHI_UNGDUNG_ID_TIEUCHI          = "id_tieuchi";
    public static final String TIEUCHI_UNGDUNG_ID_THUYETMINH          = "id_thuyetminh_detai";
    public static final String TIEUCHI_UNGDUNG_ID_XADIEM          = "id_xadiem";
    
    @Id
    @Column(name = "id_tieuchi")
    public int getIdTieuchi() {
        return idTieuchi;
    }

    public void setIdTieuchi(int idTieuchi) {
        this.idTieuchi = idTieuchi;
    }

    @Id
    @Column(name = "id_thuyetminh_detai")
    public int getIdThuyetminhDetai() {
        return idThuyetminhDetai;
    }

    public void setIdThuyetminhDetai(int idThuyetminhDetai) {
        this.idThuyetminhDetai = idThuyetminhDetai;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTieuchiUngdungEntity that = (TblTieuchiUngdungEntity) o;

        if (idThuyetminhDetai != that.idThuyetminhDetai) return false;
        if (idTieuchi != that.idTieuchi) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTieuchi;
        result = 31 * result + idThuyetminhDetai;
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_thuyetminh_detai", referencedColumnName = "id_thuyetminh_detai_duan", nullable = false)
    public TblThuyetminhDetaiDuanEntity getTblThuyetminhDetaiDuanByIdThuyetminhDetai() {
        return tblThuyetminhDetaiDuanByIdThuyetminhDetai;
    }

    public void setTblThuyetminhDetaiDuanByIdThuyetminhDetai(TblThuyetminhDetaiDuanEntity tblThuyetminhDetaiDuanByIdThuyetminhDetai) {
        this.tblThuyetminhDetaiDuanByIdThuyetminhDetai = tblThuyetminhDetaiDuanByIdThuyetminhDetai;
    }

    @ManyToOne
    @JoinColumn(name = "id_xadiem", referencedColumnName = "id_xadiem")
    public TblXadiemEntity getTblXadiemByIdXadiem() {
        return tblXadiemByIdXadiem;
    }

    public void setTblXadiemByIdXadiem(TblXadiemEntity tblXadiemByIdXadiem) {
        this.tblXadiemByIdXadiem = tblXadiemByIdXadiem;
    }
}
