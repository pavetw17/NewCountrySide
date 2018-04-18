package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_ykienchidao", schema = "public", catalog = "ntm")
public class TblYkienchidaoEntity {
    private int idYkienchidao;
    private String sokihieu;
    private String tieude;
    private Integer ngayChidaoCohieuluc;
    private String noidungchidao;

//    id_ykienchidao integer NOT NULL,
//    sokihieu character varying(30),
//    tieude character varying(200),
//    ngay_chidao_cohieuluc integer,
//    noidungchidao character varying(2000),
//    id_taikhoan integer, -- người cập nhật ý kiến chỉ đạo
//    duongdanykienchidao character varying(200),
    public static final String YKIEN_CHIDAO_TBL          = "tbl_ykienchidao";
    public static final String YKIEN_CHIDAO_ID           = "id_ykienchidao";
    public static final String YKIEN_CHIDAO_SOKIHIEU     = "sokihieu";
    public static final String YKIEN_CHIDAO_TIEUDE       = "tieude";
    public static final String YKIEN_CHIDAO_NGAY         = "ngay_chidao_cohieuluc";
    public static final String YKIEN_CHIDAO_NOIDUNG      = "noidungchidao";
    public static final String YKIEN_CHIDAO_ID_TK        = "id_taikhoan";
    public static final String YKIEN_CHIDAO_DUONGDAN  = "duongdanykienchidao";
    
    @Id
    @Column(name = "id_ykienchidao")
    public int getIdYkienchidao() {
        return idYkienchidao;
    }

    public void setIdYkienchidao(int idYkienchidao) {
        this.idYkienchidao = idYkienchidao;
    }

    @Basic
    @Column(name = "sokihieu")
    public String getSokihieu() {
        return sokihieu;
    }

    public void setSokihieu(String sokihieu) {
        this.sokihieu = sokihieu;
    }

    @Basic
    @Column(name = "tieude")
    public String getTieude() {
        return tieude;
    }

    public void setTieude(String tieude) {
        this.tieude = tieude;
    }

    @Basic
    @Column(name = "ngay_chidao_cohieuluc")
    public Integer getNgayChidaoCohieuluc() {
        return ngayChidaoCohieuluc;
    }

    public void setNgayChidaoCohieuluc(Integer ngayChidaoCohieuluc) {
        this.ngayChidaoCohieuluc = ngayChidaoCohieuluc;
    }

    @Basic
    @Column(name = "noidungchidao")
    public String getNoidungchidao() {
        return noidungchidao;
    }

    public void setNoidungchidao(String noidungchidao) {
        this.noidungchidao = noidungchidao;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblYkienchidaoEntity that = (TblYkienchidaoEntity) o;

        if (idYkienchidao != that.idYkienchidao) return false;
        if (ngayChidaoCohieuluc != null ? !ngayChidaoCohieuluc.equals(that.ngayChidaoCohieuluc) : that.ngayChidaoCohieuluc != null)
            return false;
        if (noidungchidao != null ? !noidungchidao.equals(that.noidungchidao) : that.noidungchidao != null)
            return false;
        if (sokihieu != null ? !sokihieu.equals(that.sokihieu) : that.sokihieu != null) return false;
        if (tieude != null ? !tieude.equals(that.tieude) : that.tieude != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idYkienchidao;
        result = 31 * result + (sokihieu != null ? sokihieu.hashCode() : 0);
        result = 31 * result + (tieude != null ? tieude.hashCode() : 0);
        result = 31 * result + (ngayChidaoCohieuluc != null ? ngayChidaoCohieuluc.hashCode() : 0);
        result = 31 * result + (noidungchidao != null ? noidungchidao.hashCode() : 0);
        return result;
    }
}
