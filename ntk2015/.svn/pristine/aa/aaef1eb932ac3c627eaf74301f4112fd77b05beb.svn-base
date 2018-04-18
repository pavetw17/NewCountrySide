package com.cwrs.ntk.models;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_kh_capkinhphi", schema = "public", catalog = "ntm")
public class TblKhCapkinhphiEntity {
    private int idKhCapkinhphi;
    private BigDecimal sotien;
    private String ghichu;
    private Long ngaydukiencap;
    private TblDetaiTochucEntity tblDetaiTochuc;

    @Id
    @Column(name = "id_kh_capkinhphi")
    public int getIdKhCapkinhphi() {
        return idKhCapkinhphi;
    }

    public void setIdKhCapkinhphi(int idKhCapkinhphi) {
        this.idKhCapkinhphi = idKhCapkinhphi;
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
    @Column(name = "ngaydukiencap")
    public Long getNgaydukiencap() {
        return ngaydukiencap;
    }

    public void setNgaydukiencap(Long ngaydukiencap) {
        this.ngaydukiencap = ngaydukiencap;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblKhCapkinhphiEntity that = (TblKhCapkinhphiEntity) o;

        if (idKhCapkinhphi != that.idKhCapkinhphi) return false;
        if (ghichu != null ? !ghichu.equals(that.ghichu) : that.ghichu != null) return false;
        if (ngaydukiencap != null ? !ngaydukiencap.equals(that.ngaydukiencap) : that.ngaydukiencap != null)
            return false;
        if (sotien != null ? !sotien.equals(that.sotien) : that.sotien != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idKhCapkinhphi;
        result = 31 * result + (sotien != null ? sotien.hashCode() : 0);
        result = 31 * result + (ghichu != null ? ghichu.hashCode() : 0);
        result = 31 * result + (ngaydukiencap != null ? ngaydukiencap.hashCode() : 0);
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
