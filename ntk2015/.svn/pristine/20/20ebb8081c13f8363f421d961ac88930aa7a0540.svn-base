package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tochuc_thamgia", schema = "public", catalog = "ntm")
public class TblTochucThamgiaEntity {
    private int idTochucThamgiaDetai;
    private int idDetai;
    private Integer soCanboDhThamgia;
    private Integer soCanboTsThamgia;
    private Integer soCanboThsThamgia;
    private String nhaXuong;
    private String trangthietbi;
    private String kinhnghiemThanhtuuKhcn;
    private String ghichu;
    private TblPhanloaiKqEntity tblPhanloaiKqByIdPhanloaiketqua;
    private TblThuyetminhDetaiDuanEntity tblThuyetminhDetaiDuanByIdThuyetminhdetai;
    private TblTochucEntity tblTochucByIdTochuc;

    @Id
    @Column(name = "id_tochuc_thamgia_detai")
    public int getIdTochucThamgiaDetai() {
        return idTochucThamgiaDetai;
    }

    public void setIdTochucThamgiaDetai(int idTochucThamgiaDetai) {
        this.idTochucThamgiaDetai = idTochucThamgiaDetai;
    }

    @Basic
    @Column(name = "id_detai")
    public int getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(int idDetai) {
        this.idDetai = idDetai;
    }

    @Basic
    @Column(name = "so_canbo_dh_thamgia")
    public Integer getSoCanboDhThamgia() {
        return soCanboDhThamgia;
    }

    public void setSoCanboDhThamgia(Integer soCanboDhThamgia) {
        this.soCanboDhThamgia = soCanboDhThamgia;
    }

    @Basic
    @Column(name = "so_canbo_ts_thamgia")
    public Integer getSoCanboTsThamgia() {
        return soCanboTsThamgia;
    }

    public void setSoCanboTsThamgia(Integer soCanboTsThamgia) {
        this.soCanboTsThamgia = soCanboTsThamgia;
    }

    @Basic
    @Column(name = "so_canbo_ths_thamgia")
    public Integer getSoCanboThsThamgia() {
        return soCanboThsThamgia;
    }

    public void setSoCanboThsThamgia(Integer soCanboThsThamgia) {
        this.soCanboThsThamgia = soCanboThsThamgia;
    }

    @Basic
    @Column(name = "nha_xuong")
    public String getNhaXuong() {
        return nhaXuong;
    }

    public void setNhaXuong(String nhaXuong) {
        this.nhaXuong = nhaXuong;
    }

    @Basic
    @Column(name = "trangthietbi")
    public String getTrangthietbi() {
        return trangthietbi;
    }

    public void setTrangthietbi(String trangthietbi) {
        this.trangthietbi = trangthietbi;
    }

    @Basic
    @Column(name = "kinhnghiem_thanhtuu_khcn")
    public String getKinhnghiemThanhtuuKhcn() {
        return kinhnghiemThanhtuuKhcn;
    }

    public void setKinhnghiemThanhtuuKhcn(String kinhnghiemThanhtuuKhcn) {
        this.kinhnghiemThanhtuuKhcn = kinhnghiemThanhtuuKhcn;
    }

    @Basic
    @Column(name = "ghichu")
    public String getGhichu() {
        return ghichu;
    }

    public void setGhichu(String ghichu) {
        this.ghichu = ghichu;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTochucThamgiaEntity that = (TblTochucThamgiaEntity) o;

        if (idDetai != that.idDetai) return false;
        if (idTochucThamgiaDetai != that.idTochucThamgiaDetai) return false;
        if (ghichu != null ? !ghichu.equals(that.ghichu) : that.ghichu != null) return false;
        if (kinhnghiemThanhtuuKhcn != null ? !kinhnghiemThanhtuuKhcn.equals(that.kinhnghiemThanhtuuKhcn) : that.kinhnghiemThanhtuuKhcn != null)
            return false;
        if (nhaXuong != null ? !nhaXuong.equals(that.nhaXuong) : that.nhaXuong != null) return false;
        if (soCanboDhThamgia != null ? !soCanboDhThamgia.equals(that.soCanboDhThamgia) : that.soCanboDhThamgia != null)
            return false;
        if (soCanboThsThamgia != null ? !soCanboThsThamgia.equals(that.soCanboThsThamgia) : that.soCanboThsThamgia != null)
            return false;
        if (soCanboTsThamgia != null ? !soCanboTsThamgia.equals(that.soCanboTsThamgia) : that.soCanboTsThamgia != null)
            return false;
        if (trangthietbi != null ? !trangthietbi.equals(that.trangthietbi) : that.trangthietbi != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTochucThamgiaDetai;
        result = 31 * result + idDetai;
        result = 31 * result + (soCanboDhThamgia != null ? soCanboDhThamgia.hashCode() : 0);
        result = 31 * result + (soCanboTsThamgia != null ? soCanboTsThamgia.hashCode() : 0);
        result = 31 * result + (soCanboThsThamgia != null ? soCanboThsThamgia.hashCode() : 0);
        result = 31 * result + (nhaXuong != null ? nhaXuong.hashCode() : 0);
        result = 31 * result + (trangthietbi != null ? trangthietbi.hashCode() : 0);
        result = 31 * result + (kinhnghiemThanhtuuKhcn != null ? kinhnghiemThanhtuuKhcn.hashCode() : 0);
        result = 31 * result + (ghichu != null ? ghichu.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_phanloaiketqua", referencedColumnName = "id_phanloai")
    public TblPhanloaiKqEntity getTblPhanloaiKqByIdPhanloaiketqua() {
        return tblPhanloaiKqByIdPhanloaiketqua;
    }

    public void setTblPhanloaiKqByIdPhanloaiketqua(TblPhanloaiKqEntity tblPhanloaiKqByIdPhanloaiketqua) {
        this.tblPhanloaiKqByIdPhanloaiketqua = tblPhanloaiKqByIdPhanloaiketqua;
    }

    @ManyToOne
    @JoinColumn(name = "id_thuyetminhdetai", referencedColumnName = "id_thuyetminh_detai_duan")
    public TblThuyetminhDetaiDuanEntity getTblThuyetminhDetaiDuanByIdThuyetminhdetai() {
        return tblThuyetminhDetaiDuanByIdThuyetminhdetai;
    }

    public void setTblThuyetminhDetaiDuanByIdThuyetminhdetai(TblThuyetminhDetaiDuanEntity tblThuyetminhDetaiDuanByIdThuyetminhdetai) {
        this.tblThuyetminhDetaiDuanByIdThuyetminhdetai = tblThuyetminhDetaiDuanByIdThuyetminhdetai;
    }

    @ManyToOne
    @JoinColumn(name = "id_tochuc", referencedColumnName = "id_tochuc", nullable = false)
    public TblTochucEntity getTblTochucByIdTochuc() {
        return tblTochucByIdTochuc;
    }

    public void setTblTochucByIdTochuc(TblTochucEntity tblTochucByIdTochuc) {
        this.tblTochucByIdTochuc = tblTochucByIdTochuc;
    }
}
