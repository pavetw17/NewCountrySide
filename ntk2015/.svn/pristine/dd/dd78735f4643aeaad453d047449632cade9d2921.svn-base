package com.cwrs.ntk.models;

import javax.persistence.*;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_coche_chinhsach", schema = "public", catalog = "ntm")
public class TblCocheChinhsachEntity {
    private int idCocheChinhsach;
    private String tenCocheChinhsach;
    private String noidungCocheChinhsach;
    private String masoCocheChinhsach;
    private byte[] filenoidung;
    private String tenfile;

    @Id
    @Column(name = "id_coche_chinhsach")
    public int getIdCocheChinhsach() {
        return idCocheChinhsach;
    }

    public void setIdCocheChinhsach(int idCocheChinhsach) {
        this.idCocheChinhsach = idCocheChinhsach;
    }

    @Basic
    @Column(name = "ten_coche_chinhsach")
    public String getTenCocheChinhsach() {
        return tenCocheChinhsach;
    }

    public void setTenCocheChinhsach(String tenCocheChinhsach) {
        this.tenCocheChinhsach = tenCocheChinhsach;
    }

    @Basic
    @Column(name = "noidung_coche_chinhsach")
    public String getNoidungCocheChinhsach() {
        return noidungCocheChinhsach;
    }

    public void setNoidungCocheChinhsach(String noidungCocheChinhsach) {
        this.noidungCocheChinhsach = noidungCocheChinhsach;
    }

    @Basic
    @Column(name = "maso_coche_chinhsach")
    public String getMasoCocheChinhsach() {
        return masoCocheChinhsach;
    }

    public void setMasoCocheChinhsach(String masoCocheChinhsach) {
        this.masoCocheChinhsach = masoCocheChinhsach;
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

        TblCocheChinhsachEntity that = (TblCocheChinhsachEntity) o;

        if (idCocheChinhsach != that.idCocheChinhsach) return false;
        if (!Arrays.equals(filenoidung, that.filenoidung)) return false;
        if (masoCocheChinhsach != null ? !masoCocheChinhsach.equals(that.masoCocheChinhsach) : that.masoCocheChinhsach != null)
            return false;
        if (noidungCocheChinhsach != null ? !noidungCocheChinhsach.equals(that.noidungCocheChinhsach) : that.noidungCocheChinhsach != null)
            return false;
        if (tenCocheChinhsach != null ? !tenCocheChinhsach.equals(that.tenCocheChinhsach) : that.tenCocheChinhsach != null)
            return false;
        if (tenfile != null ? !tenfile.equals(that.tenfile) : that.tenfile != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idCocheChinhsach;
        result = 31 * result + (tenCocheChinhsach != null ? tenCocheChinhsach.hashCode() : 0);
        result = 31 * result + (noidungCocheChinhsach != null ? noidungCocheChinhsach.hashCode() : 0);
        result = 31 * result + (masoCocheChinhsach != null ? masoCocheChinhsach.hashCode() : 0);
        result = 31 * result + (filenoidung != null ? Arrays.hashCode(filenoidung) : 0);
        result = 31 * result + (tenfile != null ? tenfile.hashCode() : 0);
        return result;
    }
}
