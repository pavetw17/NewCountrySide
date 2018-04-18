package com.cwrs.ntk.models;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phieu", schema = "public", catalog = "ntm")
public class TblPhieuEntity {
    private int idPhieu;
    private BigDecimal diemdanhgiaTonghop;
    private String giaithichKiennghi;
    private String tenphieu;
    private byte[] noidungPhieu;
    private TblChuyengiaEntity tblChuyengiaByIdChuyengia;
    private TblKiennghiEntity tblKiennghiByIdKiennghi;
    private TblPhanloaiPhieuEntity tblPhanloaiPhieuByIdPhanloaiphieu;
    private TblPhanloaiThanhvienEntity tblPhanloaiThanhvienByVitri;

    @Id
    @Column(name = "id_phieu")
    public int getIdPhieu() {
        return idPhieu;
    }

    public void setIdPhieu(int idPhieu) {
        this.idPhieu = idPhieu;
    }

    @Basic
    @Column(name = "diemdanhgia_tonghop")
    public BigDecimal getDiemdanhgiaTonghop() {
        return diemdanhgiaTonghop;
    }

    public void setDiemdanhgiaTonghop(BigDecimal diemdanhgiaTonghop) {
        this.diemdanhgiaTonghop = diemdanhgiaTonghop;
    }

    @Basic
    @Column(name = "giaithich_kiennghi")
    public String getGiaithichKiennghi() {
        return giaithichKiennghi;
    }

    public void setGiaithichKiennghi(String giaithichKiennghi) {
        this.giaithichKiennghi = giaithichKiennghi;
    }

    @Basic
    @Column(name = "tenphieu")
    public String getTenphieu() {
        return tenphieu;
    }

    public void setTenphieu(String tenphieu) {
        this.tenphieu = tenphieu;
    }

    @Basic
    @Column(name = "noidung_phieu")
    public byte[] getNoidungPhieu() {
        return noidungPhieu;
    }

    public void setNoidungPhieu(byte[] noidungPhieu) {
        this.noidungPhieu = noidungPhieu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhieuEntity that = (TblPhieuEntity) o;

        if (idPhieu != that.idPhieu) return false;
        if (diemdanhgiaTonghop != null ? !diemdanhgiaTonghop.equals(that.diemdanhgiaTonghop) : that.diemdanhgiaTonghop != null)
            return false;
        if (giaithichKiennghi != null ? !giaithichKiennghi.equals(that.giaithichKiennghi) : that.giaithichKiennghi != null)
            return false;
        if (!Arrays.equals(noidungPhieu, that.noidungPhieu)) return false;
        if (tenphieu != null ? !tenphieu.equals(that.tenphieu) : that.tenphieu != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhieu;
        result = 31 * result + (diemdanhgiaTonghop != null ? diemdanhgiaTonghop.hashCode() : 0);
        result = 31 * result + (giaithichKiennghi != null ? giaithichKiennghi.hashCode() : 0);
        result = 31 * result + (tenphieu != null ? tenphieu.hashCode() : 0);
        result = 31 * result + (noidungPhieu != null ? Arrays.hashCode(noidungPhieu) : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_chuyengia", referencedColumnName = "id_chuyengia")
    public TblChuyengiaEntity getTblChuyengiaByIdChuyengia() {
        return tblChuyengiaByIdChuyengia;
    }

    public void setTblChuyengiaByIdChuyengia(TblChuyengiaEntity tblChuyengiaByIdChuyengia) {
        this.tblChuyengiaByIdChuyengia = tblChuyengiaByIdChuyengia;
    }

    @ManyToOne
    @JoinColumn(name = "id_kiennghi", referencedColumnName = "id_kiennghi")
    public TblKiennghiEntity getTblKiennghiByIdKiennghi() {
        return tblKiennghiByIdKiennghi;
    }

    public void setTblKiennghiByIdKiennghi(TblKiennghiEntity tblKiennghiByIdKiennghi) {
        this.tblKiennghiByIdKiennghi = tblKiennghiByIdKiennghi;
    }

    @ManyToOne
    @JoinColumn(name = "id_phanloaiphieu", referencedColumnName = "id_phanloaiphieu")
    public TblPhanloaiPhieuEntity getTblPhanloaiPhieuByIdPhanloaiphieu() {
        return tblPhanloaiPhieuByIdPhanloaiphieu;
    }

    public void setTblPhanloaiPhieuByIdPhanloaiphieu(TblPhanloaiPhieuEntity tblPhanloaiPhieuByIdPhanloaiphieu) {
        this.tblPhanloaiPhieuByIdPhanloaiphieu = tblPhanloaiPhieuByIdPhanloaiphieu;
    }

    @ManyToOne
    @JoinColumn(name = "vitri", referencedColumnName = "id_phanloai_thanhvien")
    public TblPhanloaiThanhvienEntity getTblPhanloaiThanhvienByVitri() {
        return tblPhanloaiThanhvienByVitri;
    }

    public void setTblPhanloaiThanhvienByVitri(TblPhanloaiThanhvienEntity tblPhanloaiThanhvienByVitri) {
        this.tblPhanloaiThanhvienByVitri = tblPhanloaiThanhvienByVitri;
    }
}
