package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_video_detai", schema = "public", catalog = "ntm")
public class TblVideoDetaiEntity {
    private int idVideo;
    private String tenvideo;
    private String pathfile;
    private Integer ngayquay;
    private Boolean trangthai;
    private Integer idFolder;
    private TblXadiemEntity tblXadiemByIdXadiem;

    @Id
    @Column(name = "id_video")
    public int getIdVideo() {
        return idVideo;
    }

    public void setIdVideo(int idVideo) {
        this.idVideo = idVideo;
    }

    @Basic
    @Column(name = "tenvideo")
    public String getTenvideo() {
        return tenvideo;
    }

    public void setTenvideo(String tenvideo) {
        this.tenvideo = tenvideo;
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
    @Column(name = "ngayquay")
    public Integer getNgayquay() {
        return ngayquay;
    }

    public void setNgayquay(Integer ngayquay) {
        this.ngayquay = ngayquay;
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

        TblVideoDetaiEntity that = (TblVideoDetaiEntity) o;

        if (idVideo != that.idVideo) return false;
        if (idFolder != null ? !idFolder.equals(that.idFolder) : that.idFolder != null) return false;
        if (ngayquay != null ? !ngayquay.equals(that.ngayquay) : that.ngayquay != null) return false;
        if (pathfile != null ? !pathfile.equals(that.pathfile) : that.pathfile != null) return false;
        if (tenvideo != null ? !tenvideo.equals(that.tenvideo) : that.tenvideo != null) return false;
        if (trangthai != null ? !trangthai.equals(that.trangthai) : that.trangthai != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idVideo;
        result = 31 * result + (tenvideo != null ? tenvideo.hashCode() : 0);
        result = 31 * result + (pathfile != null ? pathfile.hashCode() : 0);
        result = 31 * result + (ngayquay != null ? ngayquay.hashCode() : 0);
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
