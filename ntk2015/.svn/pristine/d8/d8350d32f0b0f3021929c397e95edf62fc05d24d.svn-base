package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_menu_quantri", schema = "public", catalog = "ntm")
@IdClass(TblMenuQuantriEntityPK.class)
public class TblMenuQuantriEntity {
    private int idMenu;
    private int idQuantri;
    private TblMenuEntity tblMenuByIdMenu;

    @Id
    @Column(name = "id_menu")
    public int getIdMenu() {
        return idMenu;
    }

    public void setIdMenu(int idMenu) {
        this.idMenu = idMenu;
    }

    @Id
    @Column(name = "id_quantri")
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

        TblMenuQuantriEntity that = (TblMenuQuantriEntity) o;

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

    @ManyToOne
    @JoinColumn(name = "id_menu", referencedColumnName = "id_menu", nullable = false)
    public TblMenuEntity getTblMenuByIdMenu() {
        return tblMenuByIdMenu;
    }

    public void setTblMenuByIdMenu(TblMenuEntity tblMenuByIdMenu) {
        this.tblMenuByIdMenu = tblMenuByIdMenu;
    }
}
