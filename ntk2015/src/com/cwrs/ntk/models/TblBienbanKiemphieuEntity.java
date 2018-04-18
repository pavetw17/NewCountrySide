package com.cwrs.ntk.models;

import javax.persistence.*;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_bienban_kiemphieu", schema = "public", catalog = "ntm")
public class TblBienbanKiemphieuEntity {
    private int idThuyetminhDetai;
    private Integer sophieuPhatra;
    private Integer sophieuThuve;
    private Integer sophieuHople;
    private Integer sophieuKhonghople;
    private Integer diemtb;
    private Integer ngay;
    private byte[] fileBienban;
    private String tenfile;

    @Id
    @Column(name = "id_thuyetminh_detai")
    public int getIdThuyetminhDetai() {
        return idThuyetminhDetai;
    }

    public void setIdThuyetminhDetai(int idThuyetminhDetai) {
        this.idThuyetminhDetai = idThuyetminhDetai;
    }

    @Basic
    @Column(name = "sophieu_phatra")
    public Integer getSophieuPhatra() {
        return sophieuPhatra;
    }

    public void setSophieuPhatra(Integer sophieuPhatra) {
        this.sophieuPhatra = sophieuPhatra;
    }

    @Basic
    @Column(name = "sophieu_thuve")
    public Integer getSophieuThuve() {
        return sophieuThuve;
    }

    public void setSophieuThuve(Integer sophieuThuve) {
        this.sophieuThuve = sophieuThuve;
    }

    @Basic
    @Column(name = "sophieu_hople")
    public Integer getSophieuHople() {
        return sophieuHople;
    }

    public void setSophieuHople(Integer sophieuHople) {
        this.sophieuHople = sophieuHople;
    }

    @Basic
    @Column(name = "sophieu_khonghople")
    public Integer getSophieuKhonghople() {
        return sophieuKhonghople;
    }

    public void setSophieuKhonghople(Integer sophieuKhonghople) {
        this.sophieuKhonghople = sophieuKhonghople;
    }

    @Basic
    @Column(name = "diemtb")
    public Integer getDiemtb() {
        return diemtb;
    }

    public void setDiemtb(Integer diemtb) {
        this.diemtb = diemtb;
    }

    @Basic
    @Column(name = "ngay")
    public Integer getNgay() {
        return ngay;
    }

    public void setNgay(Integer ngay) {
        this.ngay = ngay;
    }

    @Basic
    @Column(name = "file_bienban")
    public byte[] getFileBienban() {
        return fileBienban;
    }

    public void setFileBienban(byte[] fileBienban) {
        this.fileBienban = fileBienban;
    }

    @Basic
    @Column(name = "tenfile")
    public String getTenfile() {
        return tenfile;
    }

    public void setTenfile(String tenfile) {
        this.tenfile = tenfile;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblBienbanKiemphieuEntity that = (TblBienbanKiemphieuEntity) o;

        if (idThuyetminhDetai != that.idThuyetminhDetai) return false;
        if (diemtb != null ? !diemtb.equals(that.diemtb) : that.diemtb != null) return false;
        if (!Arrays.equals(fileBienban, that.fileBienban)) return false;
        if (ngay != null ? !ngay.equals(that.ngay) : that.ngay != null) return false;
        if (sophieuHople != null ? !sophieuHople.equals(that.sophieuHople) : that.sophieuHople != null) return false;
        if (sophieuKhonghople != null ? !sophieuKhonghople.equals(that.sophieuKhonghople) : that.sophieuKhonghople != null)
            return false;
        if (sophieuPhatra != null ? !sophieuPhatra.equals(that.sophieuPhatra) : that.sophieuPhatra != null)
            return false;
        if (sophieuThuve != null ? !sophieuThuve.equals(that.sophieuThuve) : that.sophieuThuve != null) return false;
        if (tenfile != null ? !tenfile.equals(that.tenfile) : that.tenfile != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idThuyetminhDetai;
        result = 31 * result + (sophieuPhatra != null ? sophieuPhatra.hashCode() : 0);
        result = 31 * result + (sophieuThuve != null ? sophieuThuve.hashCode() : 0);
        result = 31 * result + (sophieuHople != null ? sophieuHople.hashCode() : 0);
        result = 31 * result + (sophieuKhonghople != null ? sophieuKhonghople.hashCode() : 0);
        result = 31 * result + (diemtb != null ? diemtb.hashCode() : 0);
        result = 31 * result + (ngay != null ? ngay.hashCode() : 0);
        result = 31 * result + (fileBienban != null ? Arrays.hashCode(fileBienban) : 0);
        result = 31 * result + (tenfile != null ? tenfile.hashCode() : 0);
        return result;
    }
}
