package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_detai_tochuc", schema = "public", catalog = "ntm")
@IdClass(TblDetaiTochucEntityPK.class)
public class TblDetaiTochucEntity {
    private int idDetai;
    private int idTochuc;
    private int idThuyetminhdetai;
    private String maso;
    private String imgCompany;

    @Id
    @Column(name = "id_detai")
    public int getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(int idDetai) {
        this.idDetai = idDetai;
    }

    @Id
    @Column(name = "id_tochuc")
    public int getIdTochuc() {
        return idTochuc;
    }

    public void setIdTochuc(int idTochuc) {
        this.idTochuc = idTochuc;
    }

    @Id
    @Column(name = "id_thuyetminhdetai")
    public int getIdThuyetminhdetai() {
        return idThuyetminhdetai;
    }

    public void setIdThuyetminhdetai(int idThuyetminhdetai) {
        this.idThuyetminhdetai = idThuyetminhdetai;
    }

    @Basic
    @Column(name = "maso")
    public String getMaso() {
        return maso;
    }

    public void setMaso(String maso) {
        this.maso = maso;
    }

    @Basic
    @Column(name = "img_company")
    public String getImgCompany() {
        return imgCompany;
    }

    public void setImgCompany(String imgCompany) {
        this.imgCompany = imgCompany;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblDetaiTochucEntity that = (TblDetaiTochucEntity) o;

        if (idDetai != that.idDetai) return false;
        if (idThuyetminhdetai != that.idThuyetminhdetai) return false;
        if (idTochuc != that.idTochuc) return false;
        if (imgCompany != null ? !imgCompany.equals(that.imgCompany) : that.imgCompany != null) return false;
        if (maso != null ? !maso.equals(that.maso) : that.maso != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetai;
        result = 31 * result + idTochuc;
        result = 31 * result + idThuyetminhdetai;
        result = 31 * result + (maso != null ? maso.hashCode() : 0);
        result = 31 * result + (imgCompany != null ? imgCompany.hashCode() : 0);
        return result;
    }
}
