package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_picture", schema = "public", catalog = "ntm")
public class TblPictureEntity {
    private int idPicture;
    private String tenanh;
    private Integer ngaychup;
    private String pathfile;
    private Boolean trangthai;
    private Integer idFolder;
    private TblXadiemEntity tblXadiemByIdXadiem;

    @Id
    @Column(name = "id_picture")
    public int getIdPicture() {
        return idPicture;
    }

    public void setIdPicture(int idPicture) {
        this.idPicture = idPicture;
    }

    @Basic
    @Column(name = "tenanh")
    public String getTenanh() {
        return tenanh;
    }

    public void setTenanh(String tenanh) {
        this.tenanh = tenanh;
    }

    @Basic
    @Column(name = "ngaychup")
    public Integer getNgaychup() {
        return ngaychup;
    }

    public void setNgaychup(Integer ngaychup) {
        this.ngaychup = ngaychup;
    }

    @Basic
    @Column(name = "pathfile")
    public String getPathfile() {
        return pathfile;
    }

    public void setPathfile(String pathfile) {
        this.pathfile = pathfile;
    }

    @Basic
    @Column(name = "trangthai")
    public Boolean getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(Boolean trangthai) {
        this.trangthai = trangthai;
    }

    @Basic
    @Column(name = "id_folder")
    public Integer getIdFolder() {
        return idFolder;
    }

    public void setIdFolder(Integer idFolder) {
        this.idFolder = idFolder;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPictureEntity that = (TblPictureEntity) o;

        if (idPicture != that.idPicture) return false;
        if (idFolder != null ? !idFolder.equals(that.idFolder) : that.idFolder != null) return false;
        if (ngaychup != null ? !ngaychup.equals(that.ngaychup) : that.ngaychup != null) return false;
        if (pathfile != null ? !pathfile.equals(that.pathfile) : that.pathfile != null) return false;
        if (tenanh != null ? !tenanh.equals(that.tenanh) : that.tenanh != null) return false;
        if (trangthai != null ? !trangthai.equals(that.trangthai) : that.trangthai != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPicture;
        result = 31 * result + (tenanh != null ? tenanh.hashCode() : 0);
        result = 31 * result + (ngaychup != null ? ngaychup.hashCode() : 0);
        result = 31 * result + (pathfile != null ? pathfile.hashCode() : 0);
        result = 31 * result + (trangthai != null ? trangthai.hashCode() : 0);
        result = 31 * result + (idFolder != null ? idFolder.hashCode() : 0);
        return result;
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
