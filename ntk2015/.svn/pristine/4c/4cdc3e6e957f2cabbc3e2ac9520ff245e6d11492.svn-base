package com.cwrs.ntk.models;

import javax.persistence.*;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_giaiphap_khcn", schema = "public", catalog = "ntm")
public class TblGiaiphapKhcnEntity {
    private int idGiaiphapKhcn;
    private String tenGiaiphapKhcn;
    private String noidungGiaiphapKhcn;
    private String quytrinhThucHien;
    private byte[] fileGiaiphap;
    private byte[] fileQuytrinh;
    private String tenfileGiaiphap;
    private String tenfileQuytrinh;
    private TblDetaiTochucEntity tblDetaiTochuc;

    @Id
    @Column(name = "id_giaiphap_khcn")
    public int getIdGiaiphapKhcn() {
        return idGiaiphapKhcn;
    }

    public void setIdGiaiphapKhcn(int idGiaiphapKhcn) {
        this.idGiaiphapKhcn = idGiaiphapKhcn;
    }

    @Basic
    @Column(name = "ten_giaiphap_khcn")
    public String getTenGiaiphapKhcn() {
        return tenGiaiphapKhcn;
    }

    public void setTenGiaiphapKhcn(String tenGiaiphapKhcn) {
        this.tenGiaiphapKhcn = tenGiaiphapKhcn;
    }

    @Basic
    @Column(name = "noidung_giaiphap_khcn")
    public String getNoidungGiaiphapKhcn() {
        return noidungGiaiphapKhcn;
    }

    public void setNoidungGiaiphapKhcn(String noidungGiaiphapKhcn) {
        this.noidungGiaiphapKhcn = noidungGiaiphapKhcn;
    }

    @Basic
    @Column(name = "quytrinh_thuc_hien")
    public String getQuytrinhThucHien() {
        return quytrinhThucHien;
    }

    public void setQuytrinhThucHien(String quytrinhThucHien) {
        this.quytrinhThucHien = quytrinhThucHien;
    }

    @Basic
    @Column(name = "file_giaiphap")
    public byte[] getFileGiaiphap() {
        return fileGiaiphap;
    }

    public void setFileGiaiphap(byte[] fileGiaiphap) {
        this.fileGiaiphap = fileGiaiphap;
    }

    @Basic
    @Column(name = "file_quytrinh")
    public byte[] getFileQuytrinh() {
        return fileQuytrinh;
    }

    public void setFileQuytrinh(byte[] fileQuytrinh) {
        this.fileQuytrinh = fileQuytrinh;
    }

    @Basic
    @Column(name = "tenfile_giaiphap")
    public String getTenfileGiaiphap() {
        return tenfileGiaiphap;
    }

    public void setTenfileGiaiphap(String tenfileGiaiphap) {
        this.tenfileGiaiphap = tenfileGiaiphap;
    }

    @Basic
    @Column(name = "tenfile_quytrinh")
    public String getTenfileQuytrinh() {
        return tenfileQuytrinh;
    }

    public void setTenfileQuytrinh(String tenfileQuytrinh) {
        this.tenfileQuytrinh = tenfileQuytrinh;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblGiaiphapKhcnEntity that = (TblGiaiphapKhcnEntity) o;

        if (idGiaiphapKhcn != that.idGiaiphapKhcn) return false;
        if (!Arrays.equals(fileGiaiphap, that.fileGiaiphap)) return false;
        if (!Arrays.equals(fileQuytrinh, that.fileQuytrinh)) return false;
        if (noidungGiaiphapKhcn != null ? !noidungGiaiphapKhcn.equals(that.noidungGiaiphapKhcn) : that.noidungGiaiphapKhcn != null)
            return false;
        if (quytrinhThucHien != null ? !quytrinhThucHien.equals(that.quytrinhThucHien) : that.quytrinhThucHien != null)
            return false;
        if (tenGiaiphapKhcn != null ? !tenGiaiphapKhcn.equals(that.tenGiaiphapKhcn) : that.tenGiaiphapKhcn != null)
            return false;
        if (tenfileGiaiphap != null ? !tenfileGiaiphap.equals(that.tenfileGiaiphap) : that.tenfileGiaiphap != null)
            return false;
        if (tenfileQuytrinh != null ? !tenfileQuytrinh.equals(that.tenfileQuytrinh) : that.tenfileQuytrinh != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idGiaiphapKhcn;
        result = 31 * result + (tenGiaiphapKhcn != null ? tenGiaiphapKhcn.hashCode() : 0);
        result = 31 * result + (noidungGiaiphapKhcn != null ? noidungGiaiphapKhcn.hashCode() : 0);
        result = 31 * result + (quytrinhThucHien != null ? quytrinhThucHien.hashCode() : 0);
        result = 31 * result + (fileGiaiphap != null ? Arrays.hashCode(fileGiaiphap) : 0);
        result = 31 * result + (fileQuytrinh != null ? Arrays.hashCode(fileQuytrinh) : 0);
        result = 31 * result + (tenfileGiaiphap != null ? tenfileGiaiphap.hashCode() : 0);
        result = 31 * result + (tenfileQuytrinh != null ? tenfileQuytrinh.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumns({@JoinColumn(name = "id_detai", referencedColumnName = "id_detai"), @JoinColumn(name = "id_tochuc", referencedColumnName = "id_tochuc"), @JoinColumn(name = "id_thuyetminh_detai", referencedColumnName = "id_thuyetminhdetai")})
    public TblDetaiTochucEntity getTblDetaiTochuc() {
        return tblDetaiTochuc;
    }

    public void setTblDetaiTochuc(TblDetaiTochucEntity tblDetaiTochuc) {
        this.tblDetaiTochuc = tblDetaiTochuc;
    }
}
