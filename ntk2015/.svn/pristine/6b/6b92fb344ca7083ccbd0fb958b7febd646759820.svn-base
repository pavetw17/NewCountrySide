package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_vanbanphaply", schema = "public", catalog = "ntm")
public class TblVanbanphaplyEntity {
    private int idVanbanphaply;
    private String kihieuvanban;
    private String tenvanban;
    private Integer ngaybanhanh;
    private String noidungvanban;
    private TblPhanloaiVanbanEntity tblPhanloaiVanbanByIdPhanloai;
    private TblTaikhoanEntity tblTaikhoanByIdTaikhoan;

//    id_vanbanphaply integer NOT NULL,
//    kihieuvanban character varying(30),
//    tenvanban character varying(200),
//    ngaybanhanh integer,
//    noidungvanban character varying(2000),
//    id_phanloai integer,
//    id_taikhoan integer, -- người cập nhật văn bản pháp lý
//    duongdanvanban character varying(200),
    
    public static final String VANBAN_PHAPLY_TBL          = "tbl_vanbanphaply";
    public static final String VANBAN_PHAPLY_ID           = "id_vanbanphaply";
    public static final String VANBAN_PHAPLY_KIHIEU           	  = "kihieuvanban";
    public static final String VANBAN_PHAPLY_TEN                 = "tenvanban";
    public static final String VANBAN_PHAPLY_NGAYBANHANH         = "ngaybanhanh";
    public static final String VANBAN_PHAPLY_NOIDUNG             = "noidungvanban";
    public static final String VANBAN_PHAPLY_ID_PHANLOAI         = "id_phanloai";
    public static final String VANBAN_PHAPLY_ID_TAIKHOAN         = "id_taikhoan";
    public static final String VANBAN_PHAPLY_DUONGDAN            = "duongdanvanban";
    
    @Id
    @Column(name = "id_vanbanphaply")
    public int getIdVanbanphaply() {
        return idVanbanphaply;
    }

    public void setIdVanbanphaply(int idVanbanphaply) {
        this.idVanbanphaply = idVanbanphaply;
    }

    @Basic
    @Column(name = "kihieuvanban")
    public String getKihieuvanban() {
        return kihieuvanban;
    }

    public void setKihieuvanban(String kihieuvanban) {
        this.kihieuvanban = kihieuvanban;
    }

    @Basic
    @Column(name = "tenvanban")
    public String getTenvanban() {
        return tenvanban;
    }

    public void setTenvanban(String tenvanban) {
        this.tenvanban = tenvanban;
    }

    @Basic
    @Column(name = "ngaybanhanh")
    public Integer getNgaybanhanh() {
        return ngaybanhanh;
    }

    public void setNgaybanhanh(Integer ngaybanhanh) {
        this.ngaybanhanh = ngaybanhanh;
    }

    @Basic
    @Column(name = "noidungvanban")
    public String getNoidungvanban() {
        return noidungvanban;
    }

    public void setNoidungvanban(String noidungvanban) {
        this.noidungvanban = noidungvanban;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblVanbanphaplyEntity that = (TblVanbanphaplyEntity) o;

        if (idVanbanphaply != that.idVanbanphaply) return false;
        if (kihieuvanban != null ? !kihieuvanban.equals(that.kihieuvanban) : that.kihieuvanban != null) return false;
        if (ngaybanhanh != null ? !ngaybanhanh.equals(that.ngaybanhanh) : that.ngaybanhanh != null) return false;
        if (noidungvanban != null ? !noidungvanban.equals(that.noidungvanban) : that.noidungvanban != null)
            return false;
        if (tenvanban != null ? !tenvanban.equals(that.tenvanban) : that.tenvanban != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idVanbanphaply;
        result = 31 * result + (kihieuvanban != null ? kihieuvanban.hashCode() : 0);
        result = 31 * result + (tenvanban != null ? tenvanban.hashCode() : 0);
        result = 31 * result + (ngaybanhanh != null ? ngaybanhanh.hashCode() : 0);
        result = 31 * result + (noidungvanban != null ? noidungvanban.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_phanloai", referencedColumnName = "id_phanloai")
    public TblPhanloaiVanbanEntity getTblPhanloaiVanbanByIdPhanloai() {
        return tblPhanloaiVanbanByIdPhanloai;
    }

    public void setTblPhanloaiVanbanByIdPhanloai(TblPhanloaiVanbanEntity tblPhanloaiVanbanByIdPhanloai) {
        this.tblPhanloaiVanbanByIdPhanloai = tblPhanloaiVanbanByIdPhanloai;
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
