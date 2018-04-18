package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_vanban", schema = "public", catalog = "ntm")
public class TblPhanloaiVanbanEntity {
    private int idPhanloai;
    private String loaiVanbanphaply;

    /* id_phanloai integer NOT NULL,
    loai_vanbanphaply character varying(200),*/

    public static final String PHANLOAI_VANBAN_TBL          = "tbl_phanloai_vanban";
    public static final String PHANLOAI_VANBAN_ID           = "id_phanloai";
    public static final String PHANLOAI_VANBAN_TEN          = "loai_vanbanphaply";
    
    @Id
    @Column(name = "id_phanloai")
    public int getIdPhanloai() {
        return idPhanloai;
    }

    public void setIdPhanloai(int idPhanloai) {
        this.idPhanloai = idPhanloai;
    }

    @Basic
    @Column(name = "loai_vanbanphaply")
    public String getLoaiVanbanphaply() {
        return loaiVanbanphaply;
    }

    public void setLoaiVanbanphaply(String loaiVanbanphaply) {
        this.loaiVanbanphaply = loaiVanbanphaply;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiVanbanEntity that = (TblPhanloaiVanbanEntity) o;

        if (idPhanloai != that.idPhanloai) return false;
        if (loaiVanbanphaply != null ? !loaiVanbanphaply.equals(that.loaiVanbanphaply) : that.loaiVanbanphaply != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloai;
        result = 31 * result + (loaiVanbanphaply != null ? loaiVanbanphaply.hashCode() : 0);
        return result;
    }
}
