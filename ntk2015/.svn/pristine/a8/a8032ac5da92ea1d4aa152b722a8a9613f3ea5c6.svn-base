package com.cwrs.ntk.models;

import javax.persistence.*;
import java.util.Arrays;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_baiviet_detai", schema = "public", catalog = "ntm")
public class TblBaivietDetaiEntity {
    private int idBaiviet;
    private String tentieude;
    private String tomtatnoidung;
    private String noidungbv;
    private Boolean tinhtrang;
    private Integer idPhanloaiBaiviet;
    private String tacgia;
    private Integer ngaycongbo;
    private byte[] noidung;
    private TblXadiemEntity tblXadiemByIdXadiem;

    @Id
    @Column(name = "id_baiviet")
    public int getIdBaiviet() {
        return idBaiviet;
    }

    public void setIdBaiviet(int idBaiviet) {
        this.idBaiviet = idBaiviet;
    }

    @Basic
    @Column(name = "tentieude")
    public String getTentieude() {
        return tentieude;
    }

    public void setTentieude(String tentieude) {
        this.tentieude = tentieude;
    }

    @Basic
    @Column(name = "tomtatnoidung")
    public String getTomtatnoidung() {
        return tomtatnoidung;
    }

    public void setTomtatnoidung(String tomtatnoidung) {
        this.tomtatnoidung = tomtatnoidung;
    }

    @Basic
    @Column(name = "noidungbv")
    public String getNoidungbv() {
        return noidungbv;
    }

    public void setNoidungbv(String noidungbv) {
        this.noidungbv = noidungbv;
    }

    @Basic
    @Column(name = "tinhtrang")
    public Boolean getTinhtrang() {
        return tinhtrang;
    }

    public void setTinhtrang(Boolean tinhtrang) {
        this.tinhtrang = tinhtrang;
    }

    @Basic
    @Column(name = "id_phanloai_baiviet")
    public Integer getIdPhanloaiBaiviet() {
        return idPhanloaiBaiviet;
    }

    public void setIdPhanloaiBaiviet(Integer idPhanloaiBaiviet) {
        this.idPhanloaiBaiviet = idPhanloaiBaiviet;
    }

    @Basic
    @Column(name = "tacgia")
    public String getTacgia() {
        return tacgia;
    }

    public void setTacgia(String tacgia) {
        this.tacgia = tacgia;
    }

    @Basic
    @Column(name = "ngaycongbo")
    public Integer getNgaycongbo() {
        return ngaycongbo;
    }

    public void setNgaycongbo(Integer ngaycongbo) {
        this.ngaycongbo = ngaycongbo;
    }

    @Basic
    @Column(name = "noidung")
    public byte[] getNoidung() {
        return noidung;
    }

    public void setNoidung(byte[] noidung) {
        this.noidung = noidung;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblBaivietDetaiEntity that = (TblBaivietDetaiEntity) o;

        if (idBaiviet != that.idBaiviet) return false;
        if (idPhanloaiBaiviet != null ? !idPhanloaiBaiviet.equals(that.idPhanloaiBaiviet) : that.idPhanloaiBaiviet != null)
            return false;
        if (ngaycongbo != null ? !ngaycongbo.equals(that.ngaycongbo) : that.ngaycongbo != null) return false;
        if (!Arrays.equals(noidung, that.noidung)) return false;
        if (noidungbv != null ? !noidungbv.equals(that.noidungbv) : that.noidungbv != null) return false;
        if (tacgia != null ? !tacgia.equals(that.tacgia) : that.tacgia != null) return false;
        if (tentieude != null ? !tentieude.equals(that.tentieude) : that.tentieude != null) return false;
        if (tinhtrang != null ? !tinhtrang.equals(that.tinhtrang) : that.tinhtrang != null) return false;
        if (tomtatnoidung != null ? !tomtatnoidung.equals(that.tomtatnoidung) : that.tomtatnoidung != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idBaiviet;
        result = 31 * result + (tentieude != null ? tentieude.hashCode() : 0);
        result = 31 * result + (tomtatnoidung != null ? tomtatnoidung.hashCode() : 0);
        result = 31 * result + (noidungbv != null ? noidungbv.hashCode() : 0);
        result = 31 * result + (tinhtrang != null ? tinhtrang.hashCode() : 0);
        result = 31 * result + (idPhanloaiBaiviet != null ? idPhanloaiBaiviet.hashCode() : 0);
        result = 31 * result + (tacgia != null ? tacgia.hashCode() : 0);
        result = 31 * result + (ngaycongbo != null ? ngaycongbo.hashCode() : 0);
        result = 31 * result + (noidung != null ? Arrays.hashCode(noidung) : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_xadiem", referencedColumnName = "id_xadiem")
    public TblXadiemEntity getTblXadiemByIdXadiem() {
        return tblXadiemByIdXadiem;
    }

    public void setTblXadiemByIdXadiem(TblXadiemEntity tblXadiemByIdXadiem) {
        this.tblXadiemByIdXadiem = tblXadiemByIdXadiem;
    }
}
