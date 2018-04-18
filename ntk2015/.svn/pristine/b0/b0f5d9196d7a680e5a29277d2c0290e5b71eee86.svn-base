package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_nhanxet", schema = "public", catalog = "ntm")
public class TblNhanxetEntity {
    private int idNhanxet;
    private String tieudeNhanxet;
    private String noidungNhanxet;
    private Integer idDetai;
    private Boolean tinhtrang;
    private TblBaivietDetaiEntity tblBaivietDetaiByIdBaiviet;
    private TblXadiemEntity tblXadiemByIdXadiem;

    @Id
    @Column(name = "id_nhanxet")
    public int getIdNhanxet() {
        return idNhanxet;
    }

    public void setIdNhanxet(int idNhanxet) {
        this.idNhanxet = idNhanxet;
    }

    @Basic
    @Column(name = "tieude_nhanxet")
    public String getTieudeNhanxet() {
        return tieudeNhanxet;
    }

    public void setTieudeNhanxet(String tieudeNhanxet) {
        this.tieudeNhanxet = tieudeNhanxet;
    }

    @Basic
    @Column(name = "noidung_nhanxet")
    public String getNoidungNhanxet() {
        return noidungNhanxet;
    }

    public void setNoidungNhanxet(String noidungNhanxet) {
        this.noidungNhanxet = noidungNhanxet;
    }

    @Basic
    @Column(name = "id_detai")
    public Integer getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(Integer idDetai) {
        this.idDetai = idDetai;
    }

    @Basic
    @Column(name = "tinhtrang")
    public Boolean getTinhtrang() {
        return tinhtrang;
    }

    public void setTinhtrang(Boolean tinhtrang) {
        this.tinhtrang = tinhtrang;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblNhanxetEntity that = (TblNhanxetEntity) o;

        if (idNhanxet != that.idNhanxet) return false;
        if (idDetai != null ? !idDetai.equals(that.idDetai) : that.idDetai != null) return false;
        if (noidungNhanxet != null ? !noidungNhanxet.equals(that.noidungNhanxet) : that.noidungNhanxet != null)
            return false;
        if (tieudeNhanxet != null ? !tieudeNhanxet.equals(that.tieudeNhanxet) : that.tieudeNhanxet != null)
            return false;
        if (tinhtrang != null ? !tinhtrang.equals(that.tinhtrang) : that.tinhtrang != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idNhanxet;
        result = 31 * result + (tieudeNhanxet != null ? tieudeNhanxet.hashCode() : 0);
        result = 31 * result + (noidungNhanxet != null ? noidungNhanxet.hashCode() : 0);
        result = 31 * result + (idDetai != null ? idDetai.hashCode() : 0);
        result = 31 * result + (tinhtrang != null ? tinhtrang.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_baiviet", referencedColumnName = "id_baiviet")
    public TblBaivietDetaiEntity getTblBaivietDetaiByIdBaiviet() {
        return tblBaivietDetaiByIdBaiviet;
    }

    public void setTblBaivietDetaiByIdBaiviet(TblBaivietDetaiEntity tblBaivietDetaiByIdBaiviet) {
        this.tblBaivietDetaiByIdBaiviet = tblBaivietDetaiByIdBaiviet;
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
