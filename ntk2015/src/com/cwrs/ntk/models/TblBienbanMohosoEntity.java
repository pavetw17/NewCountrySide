package com.cwrs.ntk.models;

import javax.persistence.*;

import java.sql.Date;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_bienban_mohoso", schema = "public", catalog = "ntm")
public class TblBienbanMohosoEntity {
    private int idDetai;
    private String diadiem;
    private String qdThanhlaphoidong;
    private Integer ngayRaQuyetdinh;
    private Date thoigianMohoso;
    private Integer tongsoHoso;
    private Integer sohosoNiemphong;
    private Integer soHosoHople;
    private Date thoigianKibienban;

    
//    id_detai integer NOT NULL DEFAULT nextval(('public.tbl_bienban_mohoso_id_detai_seq'::text)::regclass),
//    diadiem character varying(200), -- địa điểm mở hồ sơ
//    qd_thanhlaphoidong character varying(30), -- số quyết định thành lập hội đồng
//    ngay_ra_quyetdinh integer, -- ngày ra quyết định
//    thoigian_mohoso date, -- thời gian mở hồ sơ
//    tongso_hoso integer,
//    sohoso_niemphong integer,
//    so_hoso_hople integer,
//    thoigian_kibienban date,
    
    
    public static final String BIENBAN_MOHOSO_TBL = "tbl_bienban_mohoso";
    public static final String BIENBAN_MOHOSO_ID_DETAI = "id_detai";
    public static final String BIENBAN_MOHOSO_DIADIEM = "diadiem";
    public static final String BIENBAN_MOHOSO_QUYETDINH = "qd_thanhlaphoidong";
    public static final String BIENBAN_MOHOSO_NGAYRA_QUYETDINH = "ngay_ra_quyetdinh";
    public static final String BIENBAN_MOHOSO_TONGSO = "tongso_hoso";
    public static final String BIENBAN_MOHOSO_THOIGIAN_MOHOSO = "thoigian_mohoso";
    public static final String BIENBAN_MOHOSO_NIEMPHONG = "sohoso_niemphong";
    public static final String BIENBAN_MOHOSO_HOPLE = "so_hoso_hople";
    public static final String BIENBAN_MOHOSO_THOIGIAN_KIBIENBAN = "thoigian_kibienban";
    public static final String BIENBAN_MOHOSO_NGAY_KIBIENBAN = "ngay_kibienban";
    public static final String BIENBAN_MOHOSO_DUONGDAN_HOSO = "duongdanhoso";
    
    @Id
    @Column(name = "id_detai")
    public int getIdDetai() {
        return idDetai;
    }

    public void setIdDetai(int idDetai) {
        this.idDetai = idDetai;
    }

    @Basic
    @Column(name = "diadiem")
    public String getDiadiem() {
        return diadiem;
    }

    public void setDiadiem(String diadiem) {
        this.diadiem = diadiem;
    }

    @Basic
    @Column(name = "qd_thanhlaphoidong")
    public String getQdThanhlaphoidong() {
        return qdThanhlaphoidong;
    }

    public void setQdThanhlaphoidong(String qdThanhlaphoidong) {
        this.qdThanhlaphoidong = qdThanhlaphoidong;
    }

    @Basic
    @Column(name = "ngay_ra_quyetdinh")
    public Integer getNgayRaQuyetdinh() {
        return ngayRaQuyetdinh;
    }

    public void setNgayRaQuyetdinh(Integer ngayRaQuyetdinh) {
        this.ngayRaQuyetdinh = ngayRaQuyetdinh;
    }

    @Basic
    @Column(name = "thoigian_mohoso")
    public Date getThoigianMohoso() {
        return thoigianMohoso;
    }

    public void setThoigianMohoso(Date thoigianMohoso) {
        this.thoigianMohoso = thoigianMohoso;
    }

    @Basic
    @Column(name = "tongso_hoso")
    public Integer getTongsoHoso() {
        return tongsoHoso;
    }

    public void setTongsoHoso(Integer tongsoHoso) {
        this.tongsoHoso = tongsoHoso;
    }

    @Basic
    @Column(name = "sohoso_niemphong")
    public Integer getSohosoNiemphong() {
        return sohosoNiemphong;
    }

    public void setSohosoNiemphong(Integer sohosoNiemphong) {
        this.sohosoNiemphong = sohosoNiemphong;
    }

    @Basic
    @Column(name = "so_hoso_hople")
    public Integer getSoHosoHople() {
        return soHosoHople;
    }

    public void setSoHosoHople(Integer soHosoHople) {
        this.soHosoHople = soHosoHople;
    }

    @Basic
    @Column(name = "thoigian_kibienban")
    public Date getThoigianKibienban() {
        return thoigianKibienban;
    }

    public void setThoigianKibienban(Date thoigianKibienban) {
        this.thoigianKibienban = thoigianKibienban;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblBienbanMohosoEntity that = (TblBienbanMohosoEntity) o;

        if (idDetai != that.idDetai) return false;
        if (diadiem != null ? !diadiem.equals(that.diadiem) : that.diadiem != null) return false;
        if (ngayRaQuyetdinh != null ? !ngayRaQuyetdinh.equals(that.ngayRaQuyetdinh) : that.ngayRaQuyetdinh != null)
            return false;
        if (qdThanhlaphoidong != null ? !qdThanhlaphoidong.equals(that.qdThanhlaphoidong) : that.qdThanhlaphoidong != null)
            return false;
        if (soHosoHople != null ? !soHosoHople.equals(that.soHosoHople) : that.soHosoHople != null) return false;
        if (sohosoNiemphong != null ? !sohosoNiemphong.equals(that.sohosoNiemphong) : that.sohosoNiemphong != null)
            return false;
        if (thoigianKibienban != null ? !thoigianKibienban.equals(that.thoigianKibienban) : that.thoigianKibienban != null)
            return false;
        if (thoigianMohoso != null ? !thoigianMohoso.equals(that.thoigianMohoso) : that.thoigianMohoso != null)
            return false;
        if (tongsoHoso != null ? !tongsoHoso.equals(that.tongsoHoso) : that.tongsoHoso != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetai;
        result = 31 * result + (diadiem != null ? diadiem.hashCode() : 0);
        result = 31 * result + (qdThanhlaphoidong != null ? qdThanhlaphoidong.hashCode() : 0);
        result = 31 * result + (ngayRaQuyetdinh != null ? ngayRaQuyetdinh.hashCode() : 0);
        result = 31 * result + (thoigianMohoso != null ? thoigianMohoso.hashCode() : 0);
        result = 31 * result + (tongsoHoso != null ? tongsoHoso.hashCode() : 0);
        result = 31 * result + (sohosoNiemphong != null ? sohosoNiemphong.hashCode() : 0);
        result = 31 * result + (soHosoHople != null ? soHosoHople.hashCode() : 0);
        result = 31 * result + (thoigianKibienban != null ? thoigianKibienban.hashCode() : 0);
        return result;
    }
}
