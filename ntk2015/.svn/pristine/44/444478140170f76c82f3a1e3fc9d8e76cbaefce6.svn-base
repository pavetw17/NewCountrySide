package com.cwrs.ntk.models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by VN on 3/5/2015.
 */
public class TblTieuchiUngdungEntityPK implements Serializable {
    private int idTieuchi;
    private int idThuyetminhDetai;

    @Column(name = "id_tieuchi")
    @Id
    public int getIdTieuchi() {
        return idTieuchi;
    }

    public void setIdTieuchi(int idTieuchi) {
        this.idTieuchi = idTieuchi;
    }

    @Column(name = "id_thuyetminh_detai")
    @Id
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

        TblTieuchiUngdungEntityPK that = (TblTieuchiUngdungEntityPK) o;

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
}
