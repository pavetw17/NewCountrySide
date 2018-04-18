package com.cwrs.ntk.models;

import javax.persistence.*;

import java.math.BigDecimal;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_detai_duan", schema = "public", catalog = "ntm")
public class TblDetaiDuanEntity {
    private int idDetai;
    private String tendt;
    private String capquanly;
    private String linhvuckh;
    private Integer tgthuchien;
    private BigDecimal kinhphi;
    private String ghichu;
    private Integer tinhtrang;
    private TblBienbanMohosoEntity tblBienbanMohosoByIdDetai;

//    id_detai integer NOT NULL DEFAULT nextval('tbl_detai_id_detai_seq'::regclass),
//    tendt character varying(200),
//    capquanly character varying(100), -- Nhà nước / Bộ / Tỉnh / Cơ sở
//    linhvuckh character varying(100), -- chi danh cho de tai, neu trong muc 7 cua B1-2a
//    id_phannhom_detai_duan integer,
//    tgthuchien integer, -- Số tháng thực hiện
//    kinhphi numeric(15,4), -- kinh phí được duyệt
//    ghichu character varying,
//    tinhtrang integer, -- =0: đang tuyển chọn, =1: đang thực hiện,..
    
    public static final String DETAI_DUAN_TBL         = "tbl_detai_duan";
    public static final String DETAI_DUAN_ID         = "id_detai";
    public static final String DETAI_DUAN_TEN         = "tendt";
    public static final String DETAI_DUAN_CAP_QL         = "capquanly";
    public static final String DETAI_DUAN_LINHVUC_KH         = "linhvuckh";
    public static final String DETAI_DUAN_ID_PHANNHOM         = "id_phannhom_detai_duan";
    public static final String DETAI_DUAN_TG_THUCHIEN         = "tgthuchien";
    public static final String DETAI_DUAN_KINHPHI         = "kinhphi";
    public static final String DETAI_DUAN_GHICHU         = "ghichu";
    public static final String DETAI_DUAN_TINHTRANG         = "tinhtrang";
    
    @Id
    @Column(name = "id_detai")
    public int getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(int idDetai) {
        this.idDetai = idDetai;
    }

    @Basic
    @Column(name = "tendt")
    public String getTendt() {
        return tendt;
    }

    public void setTendt(String tendt) {
        this.tendt = tendt;
    }

    @Basic
    @Column(name = "capquanly")
    public String getCapquanly() {
        return capquanly;
    }

    public void setCapquanly(String capquanly) {
        this.capquanly = capquanly;
    }

    @Basic
    @Column(name = "linhvuckh")
    public String getLinhvuckh() {
        return linhvuckh;
    }

    public void setLinhvuckh(String linhvuckh) {
        this.linhvuckh = linhvuckh;
    }

    @Basic
    @Column(name = "tgthuchien")
    public Integer getTgthuchien() {
        return tgthuchien;
    }

    public void setTgthuchien(Integer tgthuchien) {
        this.tgthuchien = tgthuchien;
    }

    @Basic
    @Column(name = "kinhphi")
    public BigDecimal getKinhphi() {
        return kinhphi;
    }

    public void setKinhphi(BigDecimal kinhphi) {
        this.kinhphi = kinhphi;
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
    @Column(name = "tinhtrang")
    public Integer getTinhtrang() {
        return tinhtrang;
    }

    public void setTinhtrang(Integer tinhtrang) {
        this.tinhtrang = tinhtrang;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblDetaiDuanEntity that = (TblDetaiDuanEntity) o;

        if (idDetai != that.idDetai) return false;
        if (capquanly != null ? !capquanly.equals(that.capquanly) : that.capquanly != null) return false;
        if (ghichu != null ? !ghichu.equals(that.ghichu) : that.ghichu != null) return false;
        if (kinhphi != null ? !kinhphi.equals(that.kinhphi) : that.kinhphi != null) return false;
        if (linhvuckh != null ? !linhvuckh.equals(that.linhvuckh) : that.linhvuckh != null) return false;
        if (tendt != null ? !tendt.equals(that.tendt) : that.tendt != null) return false;
        if (tgthuchien != null ? !tgthuchien.equals(that.tgthuchien) : that.tgthuchien != null) return false;
        if (tinhtrang != null ? !tinhtrang.equals(that.tinhtrang) : that.tinhtrang != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetai;
        result = 31 * result + (tendt != null ? tendt.hashCode() : 0);
        result = 31 * result + (capquanly != null ? capquanly.hashCode() : 0);
        result = 31 * result + (linhvuckh != null ? linhvuckh.hashCode() : 0);
        result = 31 * result + (tgthuchien != null ? tgthuchien.hashCode() : 0);
        result = 31 * result + (kinhphi != null ? kinhphi.hashCode() : 0);
        result = 31 * result + (ghichu != null ? ghichu.hashCode() : 0);
        result = 31 * result + (tinhtrang != null ? tinhtrang.hashCode() : 0);
        return result;
    }

    @OneToOne(mappedBy = "tblDetaiDuanByIdDetai")
    public TblBienbanMohosoEntity getTblBienbanMohosoByIdDetai() {
        return tblBienbanMohosoByIdDetai;
    }

    public void setTblBienbanMohosoByIdDetai(TblBienbanMohosoEntity tblBienbanMohosoByIdDetai) {
        this.tblBienbanMohosoByIdDetai = tblBienbanMohosoByIdDetai;
    }
}
