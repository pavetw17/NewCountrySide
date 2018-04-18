package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tieuchi_xaydung_ntm", schema = "public", catalog = "ntm")
public class TblTieuchiXaydungNtmEntity {
    private int idTieuchi;
    private String tenTieuchi;
    private String noidungTieuchi;
    private Integer chitieuPhaidat;
    private TblPhanloaiKhuvucEntity tblPhanloaiKhuvucByIdKhuvuc;
    private TblTieuchiXaydungNtmEntity tblTieuchiXaydungNtmByIdTieuchiCha;

//    id_tieuchi integer NOT NULL,
//    ten_tieuchi character varying(200),
//    noidung_tieuchi character varying(200) NOT NULL,
//    chitieu_phaidat integer,
//    id_khuvuc integer,
//    id_tieuchi_cha integer,
    
    public static final String TIEUCHI_XD_NTM_TBL    = "tbl_tieuchi_xaydung_ntm";
    public static final String TIEUCHI_XD_NTM_ID    = "id_tieuchi";
    public static final String TIEUCHI_XD_NTM_TEN    = "ten_tieuchi";
    public static final String TIEUCHI_XD_NTM_NOIDUNG    = "noidung_tieuchi";
    public static final String TIEUCHI_XD_NTM_CHITIEU    = "chitieu_phaidat";
    public static final String TIEUCHI_XD_NTM_ID_KHUVUC    = "id_khuvuc";
    public static final String TIEUCHI_XD_NTM_ID_TIEUCHI_ID_CHA    = "id_tieuchi_cha";
    
    @Id
    @Column(name = "id_tieuchi")
    public int getIdTieuchi() {
        return idTieuchi;
    }

    public void setIdTieuchi(int idTieuchi) {
        this.idTieuchi = idTieuchi;
    }

    @Basic
    @Column(name = "ten_tieuchi")
    public String getTenTieuchi() {
        return tenTieuchi;
    }

    public void setTenTieuchi(String tenTieuchi) {
        this.tenTieuchi = tenTieuchi;
    }

    @Basic
    @Column(name = "noidung_tieuchi")
    public String getNoidungTieuchi() {
        return noidungTieuchi;
    }

    public void setNoidungTieuchi(String noidungTieuchi) {
        this.noidungTieuchi = noidungTieuchi;
    }

    @Basic
    @Column(name = "chitieu_phaidat")
    public Integer getChitieuPhaidat() {
        return chitieuPhaidat;
    }

    public void setChitieuPhaidat(Integer chitieuPhaidat) {
        this.chitieuPhaidat = chitieuPhaidat;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTieuchiXaydungNtmEntity that = (TblTieuchiXaydungNtmEntity) o;

        if (idTieuchi != that.idTieuchi) return false;
        if (chitieuPhaidat != null ? !chitieuPhaidat.equals(that.chitieuPhaidat) : that.chitieuPhaidat != null)
            return false;
        if (noidungTieuchi != null ? !noidungTieuchi.equals(that.noidungTieuchi) : that.noidungTieuchi != null)
            return false;
        if (tenTieuchi != null ? !tenTieuchi.equals(that.tenTieuchi) : that.tenTieuchi != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTieuchi;
        result = 31 * result + (tenTieuchi != null ? tenTieuchi.hashCode() : 0);
        result = 31 * result + (noidungTieuchi != null ? noidungTieuchi.hashCode() : 0);
        result = 31 * result + (chitieuPhaidat != null ? chitieuPhaidat.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_khuvuc", referencedColumnName = "id_khuvuc")
    public TblPhanloaiKhuvucEntity getTblPhanloaiKhuvucByIdKhuvuc() {
        return tblPhanloaiKhuvucByIdKhuvuc;
    }

    public void setTblPhanloaiKhuvucByIdKhuvuc(TblPhanloaiKhuvucEntity tblPhanloaiKhuvucByIdKhuvuc) {
        this.tblPhanloaiKhuvucByIdKhuvuc = tblPhanloaiKhuvucByIdKhuvuc;
    }

    @ManyToOne
    @JoinColumn(name = "id_tieuchi_cha", referencedColumnName = "id_tieuchi")
    public TblTieuchiXaydungNtmEntity getTblTieuchiXaydungNtmByIdTieuchiCha() {
        return tblTieuchiXaydungNtmByIdTieuchiCha;
    }

    public void setTblTieuchiXaydungNtmByIdTieuchiCha(TblTieuchiXaydungNtmEntity tblTieuchiXaydungNtmByIdTieuchiCha) {
        this.tblTieuchiXaydungNtmByIdTieuchiCha = tblTieuchiXaydungNtmByIdTieuchiCha;
    }
}
