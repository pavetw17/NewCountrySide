package com.cwrs.ntk.models;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tiendo_capkinhphi", schema = "public", catalog = "ntm")
public class TblTiendoCapkinhphiEntity {
    private int idTiendoCapkinhphi;
    private Long ngaycap;
    private BigDecimal sotien;
    private String ghichu;
    private TblDetaiTochucEntity tblDetaiTochuc;

    @Id
    @Column(name = "id_tiendo_capkinhphi")
    public int getIdTiendoCapkinhphi() {
        return idTiendoCapkinhphi;
    }

    public void setIdTiendoCapkinhphi(int idTiendoCapkinhphi) {
        this.idTiendoCapkinhphi = idTiendoCapkinhphi;
    }

    @Basic
    @Column(name = "ngaycap")
    public Long getNgaycap() {
        return ngaycap;
    }

    public void setNgaycap(Long ngaycap) {
        this.ngaycap = ngaycap;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTiendoCapkinhphiEntity that = (TblTiendoCapkinhphiEntity) o;

        if (idTiendoCapkinhphi != that.idTiendoCapkinhphi) return false;
        if (ghichu != null ? !ghichu.equals(that.ghichu) : that.ghichu != null) return false;
        if (ngaycap != null ? !ngaycap.equals(that.ngaycap) : that.ngaycap != null) return false;
        if (sotien != null ? !sotien.equals(that.sotien) : that.sotien != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTiendoCapkinhphi;
        result = 31 * result + (ngaycap != null ? ngaycap.hashCode() : 0);
        result = 31 * result + (sotien != null ? sotien.hashCode() : 0);
        result = 31 * result + (ghichu != null ? ghichu.hashCode() : 0);
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
