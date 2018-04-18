package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_sanpham", schema = "public", catalog = "ntm")
public class TblSanphamEntity {
    private int idSanpham;
    private String tensanpham;
    private String chitieuchatluong;
    private String donvido;
    private String mucchatluongcandat;
    private String mucChatluongTrongnuoc;
    private String mucChatluongThegioi;
    private Integer soluongdukien;
    private String cskhChitieuchatluong;
    private String yeucaukhoahoc;
    private String noicongbo;
    private TblPhanloaiSpEntity tblPhanloaiSpByIdLoaisp;

    @Id
    @Column(name = "id_sanpham")
    public int getIdSanpham() {
        return idSanpham;
    }

    public void setIdSanpham(int idSanpham) {
        this.idSanpham = idSanpham;
    }

    @Basic
    @Column(name = "tensanpham")
    public String getTensanpham() {
        return tensanpham;
    }

    public void setTensanpham(String tensanpham) {
        this.tensanpham = tensanpham;
    }

    @Basic
    @Column(name = "chitieuchatluong")
    public String getChitieuchatluong() {
        return chitieuchatluong;
    }

    public void setChitieuchatluong(String chitieuchatluong) {
        this.chitieuchatluong = chitieuchatluong;
    }

    @Basic
    @Column(name = "donvido")
    public String getDonvido() {
        return donvido;
    }

    public void setDonvido(String donvido) {
        this.donvido = donvido;
    }

    @Basic
    @Column(name = "mucchatluongcandat")
    public String getMucchatluongcandat() {
        return mucchatluongcandat;
    }

    public void setMucchatluongcandat(String mucchatluongcandat) {
        this.mucchatluongcandat = mucchatluongcandat;
    }

    @Basic
    @Column(name = "muc_chatluong_trongnuoc")
    public String getMucChatluongTrongnuoc() {
        return mucChatluongTrongnuoc;
    }

    public void setMucChatluongTrongnuoc(String mucChatluongTrongnuoc) {
        this.mucChatluongTrongnuoc = mucChatluongTrongnuoc;
    }

    @Basic
    @Column(name = "muc_chatluong_thegioi")
    public String getMucChatluongThegioi() {
        return mucChatluongThegioi;
    }

    public void setMucChatluongThegioi(String mucChatluongThegioi) {
        this.mucChatluongThegioi = mucChatluongThegioi;
    }

    @Basic
    @Column(name = "soluongdukien")
    public Integer getSoluongdukien() {
        return soluongdukien;
    }

    public void setSoluongdukien(Integer soluongdukien) {
        this.soluongdukien = soluongdukien;
    }

    @Basic
    @Column(name = "cskh_chitieuchatluong")
    public String getCskhChitieuchatluong() {
        return cskhChitieuchatluong;
    }

    public void setCskhChitieuchatluong(String cskhChitieuchatluong) {
        this.cskhChitieuchatluong = cskhChitieuchatluong;
    }

    @Basic
    @Column(name = "yeucaukhoahoc")
    public String getYeucaukhoahoc() {
        return yeucaukhoahoc;
    }

    public void setYeucaukhoahoc(String yeucaukhoahoc) {
        this.yeucaukhoahoc = yeucaukhoahoc;
    }

    @Basic
    @Column(name = "noicongbo")
    public String getNoicongbo() {
        return noicongbo;
    }

    public void setNoicongbo(String noicongbo) {
        this.noicongbo = noicongbo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblSanphamEntity that = (TblSanphamEntity) o;

        if (idSanpham != that.idSanpham) return false;
        if (chitieuchatluong != null ? !chitieuchatluong.equals(that.chitieuchatluong) : that.chitieuchatluong != null)
            return false;
        if (cskhChitieuchatluong != null ? !cskhChitieuchatluong.equals(that.cskhChitieuchatluong) : that.cskhChitieuchatluong != null)
            return false;
        if (donvido != null ? !donvido.equals(that.donvido) : that.donvido != null) return false;
        if (mucChatluongThegioi != null ? !mucChatluongThegioi.equals(that.mucChatluongThegioi) : that.mucChatluongThegioi != null)
            return false;
        if (mucChatluongTrongnuoc != null ? !mucChatluongTrongnuoc.equals(that.mucChatluongTrongnuoc) : that.mucChatluongTrongnuoc != null)
            return false;
        if (mucchatluongcandat != null ? !mucchatluongcandat.equals(that.mucchatluongcandat) : that.mucchatluongcandat != null)
            return false;
        if (noicongbo != null ? !noicongbo.equals(that.noicongbo) : that.noicongbo != null) return false;
        if (soluongdukien != null ? !soluongdukien.equals(that.soluongdukien) : that.soluongdukien != null)
            return false;
        if (tensanpham != null ? !tensanpham.equals(that.tensanpham) : that.tensanpham != null) return false;
        if (yeucaukhoahoc != null ? !yeucaukhoahoc.equals(that.yeucaukhoahoc) : that.yeucaukhoahoc != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idSanpham;
        result = 31 * result + (tensanpham != null ? tensanpham.hashCode() : 0);
        result = 31 * result + (chitieuchatluong != null ? chitieuchatluong.hashCode() : 0);
        result = 31 * result + (donvido != null ? donvido.hashCode() : 0);
        result = 31 * result + (mucchatluongcandat != null ? mucchatluongcandat.hashCode() : 0);
        result = 31 * result + (mucChatluongTrongnuoc != null ? mucChatluongTrongnuoc.hashCode() : 0);
        result = 31 * result + (mucChatluongThegioi != null ? mucChatluongThegioi.hashCode() : 0);
        result = 31 * result + (soluongdukien != null ? soluongdukien.hashCode() : 0);
        result = 31 * result + (cskhChitieuchatluong != null ? cskhChitieuchatluong.hashCode() : 0);
        result = 31 * result + (yeucaukhoahoc != null ? yeucaukhoahoc.hashCode() : 0);
        result = 31 * result + (noicongbo != null ? noicongbo.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_loaisp", referencedColumnName = "id_phanloai_sp")
    public TblPhanloaiSpEntity getTblPhanloaiSpByIdLoaisp() {
        return tblPhanloaiSpByIdLoaisp;
    }

    public void setTblPhanloaiSpByIdLoaisp(TblPhanloaiSpEntity tblPhanloaiSpByIdLoaisp) {
        this.tblPhanloaiSpByIdLoaisp = tblPhanloaiSpByIdLoaisp;
    }
}
