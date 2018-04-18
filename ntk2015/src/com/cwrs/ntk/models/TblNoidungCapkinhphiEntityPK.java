package com.cwrs.ntk.models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by VN on 3/5/2015.
 */
public class TblNoidungCapkinhphiEntityPK implements Serializable {
    private int idDetai;

    @Column(name = "id_detai")
    @Id
    public int getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(int idDetai) {
        this.idDetai = idDetai;
    }

    private int idThuyetminhdetai;

    @Column(name = "id_thuyetminhdetai")
    @Id
    public int getIdThuyetminhdetai() {
        return idThuyetminhdetai;
    }

    public void setIdThuyetminhdetai(int idThuyetminhdetai) {
        this.idThuyetminhdetai = idThuyetminhdetai;
    }

    private int idTochuc;

    @Column(name = "id_tochuc")
    @Id
    public int getIdTochuc() {
        return idTochuc;
    }

    public void setIdTochuc(int idTochuc) {
        this.idTochuc = idTochuc;
    }

    private int idNoidung;

    @Column(name = "id_noidung")
    @Id
    public int getIdNoidung() {
        return idNoidung;
    }

    public void setIdNoidung(int idNoidung) {
        this.idNoidung = idNoidung;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblNoidungCapkinhphiEntityPK that = (TblNoidungCapkinhphiEntityPK) o;

        if (idDetai != that.idDetai) return false;
        if (idNoidung != that.idNoidung) return false;
        if (idThuyetminhdetai != that.idThuyetminhdetai) return false;
        if (idTochuc != that.idTochuc) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetai;
        result = 31 * result + idThuyetminhdetai;
        result = 31 * result + idTochuc;
        result = 31 * result + idNoidung;
        return result;
    }
}
