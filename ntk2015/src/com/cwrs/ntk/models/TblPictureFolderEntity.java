package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_picture_folder", schema = "public", catalog = "ntm")
public class TblPictureFolderEntity {
    private int idFolder;
    private String foldername;
    private TblDetaiDuanEntity tblDetaiDuanByIdDetai;
    private TblXadiemEntity tblXadiemByIdXadiem;

    @Id
    @Column(name = "id_folder")
    public int getIdFolder() {
        return idFolder;
    }

    public void setIdFolder(int idFolder) {
        this.idFolder = idFolder;
    }

    @Basic
    @Column(name = "foldername")
    public String getFoldername() {
        return foldername;
    }

    public void setFoldername(String foldername) {
        this.foldername = foldername;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPictureFolderEntity that = (TblPictureFolderEntity) o;

        if (idFolder != that.idFolder) return false;
        if (foldername != null ? !foldername.equals(that.foldername) : that.foldername != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idFolder;
        result = 31 * result + (foldername != null ? foldername.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_detai", referencedColumnName = "id_detai")
    public TblDetaiDuanEntity getTblDetaiDuanByIdDetai() {
        return tblDetaiDuanByIdDetai;
    }

    public void setTblDetaiDuanByIdDetai(TblDetaiDuanEntity tblDetaiDuanByIdDetai) {
        this.tblDetaiDuanByIdDetai = tblDetaiDuanByIdDetai;
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
