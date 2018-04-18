package com.cwrs.ntk.models;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_noidung_capkinhphi", schema = "public", catalog = "ntm")
@IdClass(TblNoidungCapkinhphiEntityPK.class)
public class TblNoidungCapkinhphiEntity {
    private int idDetai;
    private int idThuyetminhdetai;
    private int idTochuc;
    private int idNoidung;
    private BigDecimal sotien;

    @Id
    @Column(name = "id_detai")
    public int getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(int idDetai) {
        this.idDetai = idDetai;
    }

    @Id
    @Column(name = "id_thuyetminhdetai")
    public int getIdThuyetminhdetai() {
        return idThuyetminhdetai;
    }

    public void setIdThuyetminhdetai(int idThuyetminhdetai) {
        this.idThuyetminhdetai = idThuyetminhdetai;
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
    @Column(name = "id_noidung")
    public int getIdNoidung() {
        return idNoidung;
    }

    public void setIdNoidung(int idNoidung) {
        this.idNoidung = idNoidung;
    }

    @Basic
    @Column(name = "sotien")
    public BigDecimal getSotien() {
        return sotien;
    }

    public void setSotien(BigDecimal sotien) {
        this.sotien = sotien;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblNoidungCapkinhphiEntity that = (TblNoidungCapkinhphiEntity) o;

        if (idDetai != that.idDetai) return false;
        if (idNoidung != that.idNoidung) return false;
        if (idThuyetminhdetai != that.idThuyetminhdetai) return false;
        if (idTochuc != that.idTochuc) return false;
        if (sotien != null ? !sotien.equals(that.sotien) : that.sotien != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetai;
        result = 31 * result + idThuyetminhdetai;
        result = 31 * result + idTochuc;
        result = 31 * result + idNoidung;
        result = 31 * result + (sotien != null ? sotien.hashCode() : 0);
        return result;
    }
}
