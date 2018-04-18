package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_tintuc", schema = "public", catalog = "ntm")
public class TblTintucEntity {
    private int idTintuc;
    private String tieude;
    private String tomtat;
    private String noidung;
    private Integer ngaytao;
    private String duongdantintuc;
	private TblPhanloaiTintucEntity tblPhanloaiTintucByIdPhanloaiTintuc;
    private TblTaikhoanEntity tblTaikhoanByIdTaikhoan;

//    id_tintuc integer NOT NULL,
//    tieude character varying(200),
//    id_taikhoan integer,
//    tomtat character varying(200),
//    noidung text,
//    ngaytao integer,
//    id_phanloai_tintuc integer,
//    duongdantintuc character varying(200),,
    
    public static final String TINTUC_TBL          = "tbl_tintuc";
    public static final String TINTUC_ID          = "id_tintuc";
    public static final String TINTUC_TEN          = "tieude";
    public static final String TINTUC_ID_TAIKHOAN          = "id_taikhoan";
    public static final String TINTUC_TOMTAT          = "tomtat";
    public static final String TINTUC_NOIDUNG        = "noidung";
    public static final String TINTUC_NGAY          = "ngaytao";
    public static final String TINTUC_ID_PHANLOAI          = "id_phanloai_tintuc";
    public static final String TINTUC_DUONGDAN	         = "duongdantintuc";
    
    @Id
    @Column(name = "duongdantintuc")
    public String getDuongdantintuc() {
		return duongdantintuc;
	}

	public void setDuongdantintuc(String duongdantintuc) {
		this.duongdantintuc = duongdantintuc;
	}
    
    @Id
    @Column(name = "id_tintuc")
    public int getIdTintuc() {
        return idTintuc;
    }

    public void setIdTintuc(int idTintuc) {
        this.idTintuc = idTintuc;
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
    @Column(name = "tomtat")
    public String getTomtat() {
        return tomtat;
    }

    public void setTomtat(String tomtat) {
        this.tomtat = tomtat;
    }

    @Basic
    @Column(name = "noidung")
    public String getNoidung() {
        return noidung;
    }

    public void setNoidung(String noidung) {
        this.noidung = noidung;
    }

    @Basic
    @Column(name = "ngaytao")
    public Integer getNgaytao() {
        return ngaytao;
    }

    public void setNgaytao(Integer ngaytao) {
        this.ngaytao = ngaytao;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblTintucEntity that = (TblTintucEntity) o;

        if (idTintuc != that.idTintuc) return false;
        if (ngaytao != null ? !ngaytao.equals(that.ngaytao) : that.ngaytao != null) return false;
        if (noidung != null ? !noidung.equals(that.noidung) : that.noidung != null) return false;
        if (tieude != null ? !tieude.equals(that.tieude) : that.tieude != null) return false;
        if (tomtat != null ? !tomtat.equals(that.tomtat) : that.tomtat != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idTintuc;
        result = 31 * result + (tieude != null ? tieude.hashCode() : 0);
        result = 31 * result + (tomtat != null ? tomtat.hashCode() : 0);
        result = 31 * result + (noidung != null ? noidung.hashCode() : 0);
        result = 31 * result + (ngaytao != null ? ngaytao.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_phanloai_tintuc", referencedColumnName = "id_phanloai_tintuc")
    public TblPhanloaiTintucEntity getTblPhanloaiTintucByIdPhanloaiTintuc() {
        return tblPhanloaiTintucByIdPhanloaiTintuc;
    }

    public void setTblPhanloaiTintucByIdPhanloaiTintuc(TblPhanloaiTintucEntity tblPhanloaiTintucByIdPhanloaiTintuc) {
        this.tblPhanloaiTintucByIdPhanloaiTintuc = tblPhanloaiTintucByIdPhanloaiTintuc;
    }

    @ManyToOne
    @JoinColumn(name = "id_taikhoan", referencedColumnName = "id_taikhoan")
    public TblTaikhoanEntity getTblTaikhoanByIdTaikhoan() {
        return tblTaikhoanByIdTaikhoan;
    }

    public void setTblTaikhoanByIdTaikhoan(TblTaikhoanEntity tblTaikhoanByIdTaikhoan) {
        this.tblTaikhoanByIdTaikhoan = tblTaikhoanByIdTaikhoan;
    }
}
