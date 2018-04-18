package com.cwrs.ntk.models;

import javax.persistence.*;

import java.math.BigInteger;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_thuyetminh_detai_duan", schema = "public", catalog = "ntm")
public class TblThuyetminhDetaiDuanEntity {
    private int idThuyetminhDetaiDuan;
    private Integer sothangthuchien;
    private BigInteger tongkinhphi;
    private String muctieuDetai;
    private Integer kinhphiTuNgansach;
    private Integer kinhphiTuco;
    private Integer kinhphiTuNguonkhac;
    private Integer ngaypheduyet;
    private Integer ngaybatdau;
    private Integer ngaynghiemthu;
    private Integer mucdoHoanthanh;
    private String tinhtrangdt;
    private String masodt;
    private Integer duocpheduyet;
    private String fileNoidung;
    private TblBienbanKiemphieuEntity tblBienbanKiemphieuByIdThuyetminhDetaiDuan;
    private TblDetaiDuanEntity tblDetaiDuanByIdDetai;

    
//    id_thuyetminh_detai_duan integer NOT NULL,
//    id_detai integer,
//    sothangthuchien integer,
//    tongkinhphi numeric,
//    muctieu_detai character varying(200),
//    kinhphi_tu_ngansach numeric(18,0),
//    kinhphi_tuco numeric(18,0),
//    kinhphi_tu_nguonkhac numeric(18,0),
//    ngaypheduyet integer,
//    ngaybatdau integer,
//    ngaynghiemthu integer,
//    mucdo_hoanthanh integer,
//    tinhtrangdt character varying(100), -- Moi /  Ke tiep huong nghien cuu cua chinh nhom tac gia / ke tiep huong nghien cuu cua nhom khac
//    masodt character varying(20),
//    duocpheduyet boolean,
//    file_noidung character varying(200),
    
    public static final String THUYETMINH_DETAI_TBL = "tbl_thuyetminh_detai_duan";
    public static final String THUYETMINH_DETAI_ID = "id_thuyetminh_detai_duan";
    public static final String THUYETMINH_DETAI_ID_DETAI = "id_detai";
    public static final String THUYETMINH_DETAI_SOTHANG_THUCHIEN = "sothangthuchien";
    public static final String THUYETMINH_DETAI_TONG_KINHPHI = "tongkinhphi";
    public static final String THUYETMINH_DETAI_MUCTIEU = "muctieu_detai";
    public static final String THUYETMINH_DETAI_KP_NGANSACH = "kinhphi_tu_ngansach";
    public static final String THUYETMINH_DETAI_KP_TUCO = "kinhphi_tuco";
    public static final String THUYETMINH_DETAI_KP_NGUONKHAC = "kinhphi_tu_nguonkhac";
    public static final String THUYETMINH_DETAI_NGAY_PHEDUYET = "ngaypheduyet";
    public static final String THUYETMINH_DETAI_NGAY_BATDAU = "ngaybatdau";
    public static final String THUYETMINH_DETAI_NGAY_NGHIEMTHU = "ngaynghiemthu";
    public static final String THUYETMINH_DETAI_MUCDO_HOANTHANH = "mucdo_hoanthanh";
    public static final String THUYETMINH_DETAI_TINHTRANG = "tinhtrangdt";
    public static final String THUYETMINH_DETAI_MASO = "masodt";
    public static final String THUYETMINH_DETAI_DUOCPHEDUYET = "duocpheduyet";
    
    @Id
    @Column(name = "id_thuyetminh_detai_duan")
    public int getIdThuyetminhDetaiDuan() {
        return idThuyetminhDetaiDuan;
    }

    public void setIdThuyetminhDetaiDuan(int idThuyetminhDetaiDuan) {
        this.idThuyetminhDetaiDuan = idThuyetminhDetaiDuan;
    }

    @Basic
    @Column(name = "sothangthuchien")
    public Integer getSothangthuchien() {
        return sothangthuchien;
    }

    public void setSothangthuchien(Integer sothangthuchien) {
        this.sothangthuchien = sothangthuchien;
    }

    @Basic
    @Column(name = "tongkinhphi")
    public BigInteger getTongkinhphi() {
        return tongkinhphi;
    }

    public void setTongkinhphi(BigInteger tongkinhphi) {
        this.tongkinhphi = tongkinhphi;
    }

    @Basic
    @Column(name = "muctieu_detai")
    public String getMuctieuDetai() {
        return muctieuDetai;
    }

    public void setMuctieuDetai(String muctieuDetai) {
        this.muctieuDetai = muctieuDetai;
    }

    @Basic
    @Column(name = "kinhphi_tu_ngansach")
    public Integer getKinhphiTuNgansach() {
        return kinhphiTuNgansach;
    }

    public void setKinhphiTuNgansach(Integer kinhphiTuNgansach) {
        this.kinhphiTuNgansach = kinhphiTuNgansach;
    }

    @Basic
    @Column(name = "kinhphi_tuco")
    public Integer getKinhphiTuco() {
        return kinhphiTuco;
    }

    public void setKinhphiTuco(Integer kinhphiTuco) {
        this.kinhphiTuco = kinhphiTuco;
    }

    @Basic
    @Column(name = "kinhphi_tu_nguonkhac")
    public Integer getKinhphiTuNguonkhac() {
        return kinhphiTuNguonkhac;
    }

    public void setKinhphiTuNguonkhac(Integer kinhphiTuNguonkhac) {
        this.kinhphiTuNguonkhac = kinhphiTuNguonkhac;
    }

    @Basic
    @Column(name = "ngaypheduyet")
    public Integer getNgaypheduyet() {
        return ngaypheduyet;
    }

    public void setNgaypheduyet(Integer ngaypheduyet) {
        this.ngaypheduyet = ngaypheduyet;
    }

    @Basic
    @Column(name = "ngaybatdau")
    public Integer getNgaybatdau() {
        return ngaybatdau;
    }

    public void setNgaybatdau(Integer ngaybatdau) {
        this.ngaybatdau = ngaybatdau;
    }

    @Basic
    @Column(name = "ngaynghiemthu")
    public Integer getNgaynghiemthu() {
        return ngaynghiemthu;
    }

    public void setNgaynghiemthu(Integer ngaynghiemthu) {
        this.ngaynghiemthu = ngaynghiemthu;
    }

    @Basic
    @Column(name = "mucdo_hoanthanh")
    public Integer getMucdoHoanthanh() {
        return mucdoHoanthanh;
    }

    public void setMucdoHoanthanh(Integer mucdoHoanthanh) {
        this.mucdoHoanthanh = mucdoHoanthanh;
    }

    @Basic
    @Column(name = "tinhtrangdt")
    public String getTinhtrangdt() {
        return tinhtrangdt;
    }

    public void setTinhtrangdt(String tinhtrangdt) {
        this.tinhtrangdt = tinhtrangdt;
    }

    @Basic
    @Column(name = "masodt")
    public String getMasodt() {
        return masodt;
    }

    public void setMasodt(String masodt) {
        this.masodt = masodt;
    }

    @Basic
    @Column(name = "duocpheduyet")
    public Integer getDuocpheduyet() {
        return duocpheduyet;
    }

    public void setDuocpheduyet(Integer duocpheduyet) {
        this.duocpheduyet = duocpheduyet;
    }

    @Basic
    @Column(name = "file_noidung")
    public String getFileNoidung() {
        return fileNoidung;
    }

    public void setFileNoidung(String fileNoidung) {
        this.fileNoidung = fileNoidung;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblThuyetminhDetaiDuanEntity that = (TblThuyetminhDetaiDuanEntity) o;

        if (idThuyetminhDetaiDuan != that.idThuyetminhDetaiDuan) return false;
        if (duocpheduyet != null ? !duocpheduyet.equals(that.duocpheduyet) : that.duocpheduyet != null) return false;
        if (fileNoidung != that.fileNoidung) return false;
        if (kinhphiTuNgansach != null ? !kinhphiTuNgansach.equals(that.kinhphiTuNgansach) : that.kinhphiTuNgansach != null)
            return false;
        if (kinhphiTuNguonkhac != null ? !kinhphiTuNguonkhac.equals(that.kinhphiTuNguonkhac) : that.kinhphiTuNguonkhac != null)
            return false;
        if (kinhphiTuco != null ? !kinhphiTuco.equals(that.kinhphiTuco) : that.kinhphiTuco != null) return false;
        if (masodt != null ? !masodt.equals(that.masodt) : that.masodt != null) return false;
        if (mucdoHoanthanh != null ? !mucdoHoanthanh.equals(that.mucdoHoanthanh) : that.mucdoHoanthanh != null)
            return false;
        if (muctieuDetai != null ? !muctieuDetai.equals(that.muctieuDetai) : that.muctieuDetai != null) return false;
        if (ngaybatdau != null ? !ngaybatdau.equals(that.ngaybatdau) : that.ngaybatdau != null) return false;
        if (ngaynghiemthu != null ? !ngaynghiemthu.equals(that.ngaynghiemthu) : that.ngaynghiemthu != null)
            return false;
        if (ngaypheduyet != null ? !ngaypheduyet.equals(that.ngaypheduyet) : that.ngaypheduyet != null) return false;
        if (sothangthuchien != null ? !sothangthuchien.equals(that.sothangthuchien) : that.sothangthuchien != null)
            return false;
        if (tinhtrangdt != null ? !tinhtrangdt.equals(that.tinhtrangdt) : that.tinhtrangdt != null) return false;
        if (tongkinhphi != null ? !tongkinhphi.equals(that.tongkinhphi) : that.tongkinhphi != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idThuyetminhDetaiDuan;
        result = 31 * result + (sothangthuchien != null ? sothangthuchien.hashCode() : 0);
        result = 31 * result + (tongkinhphi != null ? tongkinhphi.hashCode() : 0);
        result = 31 * result + (muctieuDetai != null ? muctieuDetai.hashCode() : 0);
        result = 31 * result + (kinhphiTuNgansach != null ? kinhphiTuNgansach.hashCode() : 0);
        result = 31 * result + (kinhphiTuco != null ? kinhphiTuco.hashCode() : 0);
        result = 31 * result + (kinhphiTuNguonkhac != null ? kinhphiTuNguonkhac.hashCode() : 0);
        result = 31 * result + (ngaypheduyet != null ? ngaypheduyet.hashCode() : 0);
        result = 31 * result + (ngaybatdau != null ? ngaybatdau.hashCode() : 0);
        result = 31 * result + (ngaynghiemthu != null ? ngaynghiemthu.hashCode() : 0);
        result = 31 * result + (mucdoHoanthanh != null ? mucdoHoanthanh.hashCode() : 0);
        result = 31 * result + (tinhtrangdt != null ? tinhtrangdt.hashCode() : 0);
        result = 31 * result + (masodt != null ? masodt.hashCode() : 0);
        result = 31 * result + (duocpheduyet != null ? duocpheduyet.hashCode() : 0);
        result = 31 * result + (fileNoidung != null ? fileNoidung.hashCode() : 0);
        return result;
    }

    @OneToOne(mappedBy = "tblThuyetminhDetaiDuanByIdThuyetminhDetai")
    public TblBienbanKiemphieuEntity getTblBienbanKiemphieuByIdThuyetminhDetaiDuan() {
        return tblBienbanKiemphieuByIdThuyetminhDetaiDuan;
    }

    public void setTblBienbanKiemphieuByIdThuyetminhDetaiDuan(TblBienbanKiemphieuEntity tblBienbanKiemphieuByIdThuyetminhDetaiDuan) {
        this.tblBienbanKiemphieuByIdThuyetminhDetaiDuan = tblBienbanKiemphieuByIdThuyetminhDetaiDuan;
    }

    @ManyToOne
    @JoinColumn(name = "id_detai", referencedColumnName = "id_detai")
    public TblDetaiDuanEntity getTblDetaiDuanByIdDetai() {
        return tblDetaiDuanByIdDetai;
    }

    public void setTblDetaiDuanByIdDetai(TblDetaiDuanEntity tblDetaiDuanByIdDetai) {
        this.tblDetaiDuanByIdDetai = tblDetaiDuanByIdDetai;
    }
}
