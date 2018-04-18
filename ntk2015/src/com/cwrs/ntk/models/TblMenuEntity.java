package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_menu", schema = "public", catalog = "ntm")
public class TblMenuEntity {
    private int idMenu;
    private String title;
    private String href;
    private TblMenuEntity tblMenuByParentId;

    @Id
    @Column(name = "id_menu")
    public int getIdMenu() {
        return idMenu;
    }

    public void setIdMenu(int idMenu) {
        this.idMenu = idMenu;
    }

    @Basic
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "href")
    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblMenuEntity that = (TblMenuEntity) o;

        if (idMenu != that.idMenu) return false;
        if (href != null ? !href.equals(that.href) : that.href != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idMenu;
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (href != null ? href.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "parent_id", referencedColumnName = "id_menu")
    public TblMenuEntity getTblMenuByParentId() {
        return tblMenuByParentId;
    }

    public void setTblMenuByParentId(TblMenuEntity tblMenuByParentId) {
        this.tblMenuByParentId = tblMenuByParentId;
    }
}
