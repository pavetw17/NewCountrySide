package com.cwrs.ntk.models;

import javax.persistence.*;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanbovon_theohangmuc", schema = "public", catalog = "ntm")
public class TblPhanbovonTheohangmucEntity {
    private int idTieuchi;
    private String noidungTieuchi;
    private byte[] filenoidung;
    private String tenfile;
    private TblDetaiTochucEntity tblDetaiTochuc;

    @Id
    @Column(name = "id_tieuchi")
    public int getIdTieuchi() {
        return idTieuchi;
    }

    public void setIdTieuchi(int idTieuchi) {
        this.idTieuchi = idTieuchi;
    }

    @Basic
    @Column(name = "noidung_tieuchi")
    public String getNoidungTieuchi() {
        return noidungTieuchi;
    }

    public void setNoidungTieuchi(String noidungTieuchi) {
        this.noidungTieuchi = noidungTieuchi;
    }

    @Basic
    @Column(name = "filenoidung")
    public byte[] getFilenoidung() {
        return filenoidung;
    }

    public void setFilenoidung(byte[] filenoidung) {
        this.filenoidung = filenoidung;
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

        TblPhanbovonTheohangmucEntity that = (TblPhanbovonTheohangmucEntity) o;

        if (idTieuchi != that.idTieuchi) return false;
        if (!Arrays.equals(filenoidung, that.filenoidung)) return false;
        if (noidungTieuchi != null ? !noidungTieuchi.equals(that.noidungTieuchi) : that.noidungTieuchi != null)
            return false;
        if (tenfile != null ? !tenfile.equals(that.tenfile) : that.tenfile != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTieuchi;
        result = 31 * result + (noidungTieuchi != null ? noidungTieuchi.hashCode() : 0);
        result = 31 * result + (filenoidung != null ? Arrays.hashCode(filenoidung) : 0);
        result = 31 * result + (tenfile != null ? tenfile.hashCode() : 0);
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
