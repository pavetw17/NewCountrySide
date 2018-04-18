package com.cwrs.ntk.models;

import javax.persistence.*;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_baocao", schema = "public", catalog = "ntm")
public class TblBaocaoEntity {
    private int idBaocao;
    private String tenbaocao;
    private String noidungBaocao;
    private byte[] fileNoidung;
    private String tenfile;

    @Id
    @Column(name = "id_baocao")
    public int getIdBaocao() {
        return idBaocao;
    }

    public void setIdBaocao(int idBaocao) {
        this.idBaocao = idBaocao;
    }

    @Basic
    @Column(name = "tenbaocao")
    public String getTenbaocao() {
        return tenbaocao;
    }

    public void setTenbaocao(String tenbaocao) {
        this.tenbaocao = tenbaocao;
    }

    @Basic
    @Column(name = "noidung_baocao")
    public String getNoidungBaocao() {
        return noidungBaocao;
    }

    public void setNoidungBaocao(String noidungBaocao) {
        this.noidungBaocao = noidungBaocao;
    }

    @Basic
    @Column(name = "file_noidung")
    public byte[] getFileNoidung() {
        return fileNoidung;
    }

    public void setFileNoidung(byte[] fileNoidung) {
        this.fileNoidung = fileNoidung;
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

        TblBaocaoEntity that = (TblBaocaoEntity) o;

        if (idBaocao != that.idBaocao) return false;
        if (!Arrays.equals(fileNoidung, that.fileNoidung)) return false;
        if (noidungBaocao != null ? !noidungBaocao.equals(that.noidungBaocao) : that.noidungBaocao != null)
            return false;
        if (tenbaocao != null ? !tenbaocao.equals(that.tenbaocao) : that.tenbaocao != null) return false;
        if (tenfile != null ? !tenfile.equals(that.tenfile) : that.tenfile != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idBaocao;
        result = 31 * result + (tenbaocao != null ? tenbaocao.hashCode() : 0);
        result = 31 * result + (noidungBaocao != null ? noidungBaocao.hashCode() : 0);
        result = 31 * result + (fileNoidung != null ? Arrays.hashCode(fileNoidung) : 0);
        result = 31 * result + (tenfile != null ? tenfile.hashCode() : 0);
        return result;
    }
}
