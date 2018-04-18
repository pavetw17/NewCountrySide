package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_danhgia_kq_theonam", schema = "public", catalog = "ntm")
public class TblDanhgiaKqTheonamEntity {
    private int id;
    private Integer idTieuchi;
    private Integer tiendoHoanthanh;
    private String ghichu;
    private Integer ngayDanhgia;
    private Integer idNguoidanhgia;
    private Integer danhgiachonam;
    private Boolean tieuchiUngdungKhcn;
    private TblXadiemEntity tblXadiemByIdXadiem;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "id_tieuchi")
    public Integer getIdTieuchi() {
        return idTieuchi;
    }

    public void setIdTieuchi(Integer idTieuchi) {
        this.idTieuchi = idTieuchi;
    }

    @Basic
    @Column(name = "tiendo_hoanthanh")
    public Integer getTiendoHoanthanh() {
        return tiendoHoanthanh;
    }

    public void setTiendoHoanthanh(Integer tiendoHoanthanh) {
        this.tiendoHoanthanh = tiendoHoanthanh;
    }

    @Basic
    @Column(name = "ghichu")
    public String getGhichu() {
        return ghichu;
    }

    public void setGhichu(String ghichu) {
        this.ghichu = ghichu;
    }

    @Basic
    @Column(name = "ngay_danhgia")
    public Integer getNgayDanhgia() {
        return ngayDanhgia;
    }

    public void setNgayDanhgia(Integer ngayDanhgia) {
        this.ngayDanhgia = ngayDanhgia;
    }

    @Basic
    @Column(name = "id_nguoidanhgia")
    public Integer getIdNguoidanhgia() {
        return idNguoidanhgia;
    }

    public void setIdNguoidanhgia(Integer idNguoidanhgia) {
        this.idNguoidanhgia = idNguoidanhgia;
    }

    @Basic
    @Column(name = "danhgiachonam")
    public Integer getDanhgiachonam() {
        return danhgiachonam;
    }

    public void setDanhgiachonam(Integer danhgiachonam) {
        this.danhgiachonam = danhgiachonam;
    }

    @Basic
    @Column(name = "tieuchi_ungdung_khcn")
    public Boolean getTieuchiUngdungKhcn() {
        return tieuchiUngdungKhcn;
    }

    public void setTieuchiUngdungKhcn(Boolean tieuchiUngdungKhcn) {
        this.tieuchiUngdungKhcn = tieuchiUngdungKhcn;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblDanhgiaKqTheonamEntity that = (TblDanhgiaKqTheonamEntity) o;

        if (id != that.id) return false;
        if (danhgiachonam != null ? !danhgiachonam.equals(that.danhgiachonam) : that.danhgiachonam != null)
            return false;
        if (ghichu != null ? !ghichu.equals(that.ghichu) : that.ghichu != null) return false;
        if (idNguoidanhgia != null ? !idNguoidanhgia.equals(that.idNguoidanhgia) : that.idNguoidanhgia != null)
            return false;
        if (idTieuchi != null ? !idTieuchi.equals(that.idTieuchi) : that.idTieuchi != null) return false;
        if (ngayDanhgia != null ? !ngayDanhgia.equals(that.ngayDanhgia) : that.ngayDanhgia != null) return false;
        if (tiendoHoanthanh != null ? !tiendoHoanthanh.equals(that.tiendoHoanthanh) : that.tiendoHoanthanh != null)
            return false;
        if (tieuchiUngdungKhcn != null ? !tieuchiUngdungKhcn.equals(that.tieuchiUngdungKhcn) : that.tieuchiUngdungKhcn != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (idTieuchi != null ? idTieuchi.hashCode() : 0);
        result = 31 * result + (tiendoHoanthanh != null ? tiendoHoanthanh.hashCode() : 0);
        result = 31 * result + (ghichu != null ? ghichu.hashCode() : 0);
        result = 31 * result + (ngayDanhgia != null ? ngayDanhgia.hashCode() : 0);
        result = 31 * result + (idNguoidanhgia != null ? idNguoidanhgia.hashCode() : 0);
        result = 31 * result + (danhgiachonam != null ? danhgiachonam.hashCode() : 0);
        result = 31 * result + (tieuchiUngdungKhcn != null ? tieuchiUngdungKhcn.hashCode() : 0);
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
