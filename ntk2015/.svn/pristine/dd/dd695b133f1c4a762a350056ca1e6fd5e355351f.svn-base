package com.cwrs.ntk.models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by VN on 3/5/2015.
 */
public class TblMenuQuantriEntityPK implements Serializable {
    private int idMenu;
    private int idQuantri;

    @Column(name = "id_menu")
    @Id
    public int getIdMenu() {
        return idMenu;
    }

    public void setIdMenu(int idMenu) {
        this.idMenu = idMenu;
    }

    @Column(name = "id_quantri")
    @Id
    public int getIdQuantri() {
        return idQuantri;
    }

    public void setIdQuantri(int idQuantri) {
        this.idQuantri = idQuantri;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblMenuQuantriEntityPK that = (TblMenuQuantriEntityPK) o;

        if (idMenu != that.idMenu) return false;
        if (idQuantri != that.idQuantri) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idMenu;
        result = 31 * result + idQuantri;
        return result;
    }
}
