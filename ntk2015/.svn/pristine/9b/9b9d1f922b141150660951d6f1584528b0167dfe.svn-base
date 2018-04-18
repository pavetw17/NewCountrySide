package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_phanloai_thanhvien", schema = "public", catalog = "ntm")
public class TblPhanloaiThanhvienEntity {
    private int idPhanloaiThanhvien;
    private String motaThanhvien;

    
//    id_phanloai_thanhvien serial NOT NULL,
//    mota_thanhvien character varying(100),
    
    public static final String PHANLOAI_THANHVIEN_TBL          = "tbl_phanloai_thanhvien";
    public static final String PHANLOAI_THANHVIEN_ID          = "id_phanloai_thanhvien";
    public static final String PHANLOAI_THANHVIEN_MOTA          = "mota_thanhvien";
    
    @Id
    @Column(name = "id_phanloai_thanhvien")
    public int getIdPhanloaiThanhvien() {
        return idPhanloaiThanhvien;
    }

    public void setIdPhanloaiThanhvien(int idPhanloaiThanhvien) {
        this.idPhanloaiThanhvien = idPhanloaiThanhvien;
    }

    @Basic
    @Column(name = "mota_thanhvien")
    public String getMotaThanhvien() {
        return motaThanhvien;
    }

    public void setMotaThanhvien(String motaThanhvien) {
        this.motaThanhvien = motaThanhvien;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblPhanloaiThanhvienEntity that = (TblPhanloaiThanhvienEntity) o;

        if (idPhanloaiThanhvien != that.idPhanloaiThanhvien) return false;
        if (motaThanhvien != null ? !motaThanhvien.equals(that.motaThanhvien) : that.motaThanhvien != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idPhanloaiThanhvien;
        result = 31 * result + (motaThanhvien != null ? motaThanhvien.hashCode() : 0);
        return result;
    }
}
