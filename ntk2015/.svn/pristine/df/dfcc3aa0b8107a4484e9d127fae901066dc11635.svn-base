package com.cwrs.ntk.models;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tiendo_giaingan", schema = "public", catalog = "ntm")
public class TblTiendoGiainganEntity {
    private int idTiendogiaingan;
    private Integer ngaygiaingan;
    private BigDecimal sotien;
    private String ghichu;
    private String noidungGiaingan;
    private Boolean dakiemtra;
    private Integer idNoidung;
    private Boolean dagiaingan;
    private TblDetaiTochucEntity tblDetaiTochuc;

    @Id
    @Column(name = "id_tiendogiaingan")
    public int getIdTiendogiaingan() {
        return idTiendogiaingan;
    }

    public void setIdTiendogiaingan(int idTiendogiaingan) {
        this.idTiendogiaingan = idTiendogiaingan;
    }

    @Basic
    @Column(name = "ngaygiaingan")
    public Integer getNgaygiaingan() {
        return ngaygiaingan;
    }

    public void setNgaygiaingan(Integer ngaygiaingan) {
        this.ngaygiaingan = ngaygiaingan;
    }

    @Basic
    @Column(name = "sotien")
    public BigDecimal getSotien() {
        return sotien;
    }

    public void setSotien(BigDecimal sotien) {
        this.sotien = sotien;
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
    @Column(name = "noidung_giaingan")
    public String getNoidungGiaingan() {
        return noidungGiaingan;
    }

    public void setNoidungGiaingan(String noidungGiaingan) {
        this.noidungGiaingan = noidungGiaingan;
    }

    @Basic
    @Column(name = "dakiemtra")
    public Boolean getDakiemtra() {
        return dakiemtra;
    }

    public void setDakiemtra(Boolean dakiemtra) {
        this.dakiemtra = dakiemtra;
    }

    @Basic
    @Column(name = "id_noidung")
    public Integer getIdNoidung() {
        return idNoidung;
    }

    public void setIdNoidung(Integer idNoidung) {
        this.idNoidung = idNoidung;
    }

    @Basic
    @Column(name = "dagiaingan")
    public Boolean getDagiaingan() {
        return dagiaingan;
    }

    public void setDagiaingan(Boolean dagiaingan) {
        this.dagiaingan = dagiaingan;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTiendoGiainganEntity that = (TblTiendoGiainganEntity) o;

        if (idTiendogiaingan != that.idTiendogiaingan) return false;
        if (dagiaingan != null ? !dagiaingan.equals(that.dagiaingan) : that.dagiaingan != null) return false;
        if (dakiemtra != null ? !dakiemtra.equals(that.dakiemtra) : that.dakiemtra != null) return false;
        if (ghichu != null ? !ghichu.equals(that.ghichu) : that.ghichu != null) return false;
        if (idNoidung != null ? !idNoidung.equals(that.idNoidung) : that.idNoidung != null) return false;
        if (ngaygiaingan != null ? !ngaygiaingan.equals(that.ngaygiaingan) : that.ngaygiaingan != null) return false;
        if (noidungGiaingan != null ? !noidungGiaingan.equals(that.noidungGiaingan) : that.noidungGiaingan != null)
            return false;
        if (sotien != null ? !sotien.equals(that.sotien) : that.sotien != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTiendogiaingan;
        result = 31 * result + (ngaygiaingan != null ? ngaygiaingan.hashCode() : 0);
        result = 31 * result + (sotien != null ? sotien.hashCode() : 0);
        result = 31 * result + (ghichu != null ? ghichu.hashCode() : 0);
        result = 31 * result + (noidungGiaingan != null ? noidungGiaingan.hashCode() : 0);
        result = 31 * result + (dakiemtra != null ? dakiemtra.hashCode() : 0);
        result = 31 * result + (idNoidung != null ? idNoidung.hashCode() : 0);
        result = 31 * result + (dagiaingan != null ? dagiaingan.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumns({@JoinColumn(name = "id_detai", referencedColumnName = "id_detai"), @JoinColumn(name = "id_tochuc", referencedColumnName = "id_tochuc"), @JoinColumn(name = "id_thuyetminhdetai", referencedColumnName = "id_thuyetminhdetai")})
    public TblDetaiTochucEntity getTblDetaiTochuc() {
        return tblDetaiTochuc;
    }

    public void setTblDetaiTochuc(TblDetaiTochucEntity tblDetaiTochuc) {
        this.tblDetaiTochuc = tblDetaiTochuc;
    }
}
