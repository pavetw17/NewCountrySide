package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_vaitro", schema = "public", catalog = "ntm")
public class TblVaitroEntity {
    private int idVaitro;
    private String tenVaitro;
    
//    id_vaitro integer NOT NULL,
//    ten_vaitro character varying(200),
    
    public static final String VAITRO_TBL          = "tbl_vaitro";
    public static final String VAITRO_ID          = "id_vaitro";
    public static final String VAITRO_TEN          = "ten_vaitro";

    @Id
    @Column(name = "id_vaitro")
    public int getIdVaitro() {
        return idVaitro;
    }

    public void setIdVaitro(int idVaitro) {
        this.idVaitro = idVaitro;
    }

    @Basic
    @Column(name = "ten_vaitro")
    public String getTenVaitro() {
        return tenVaitro;
    }

    public void setTenVaitro(String tenVaitro) {
        this.tenVaitro = tenVaitro;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblVaitroEntity that = (TblVaitroEntity) o;

        if (idVaitro != that.idVaitro) return false;
        if (tenVaitro != null ? !tenVaitro.equals(that.tenVaitro) : that.tenVaitro != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idVaitro;
        result = 31 * result + (tenVaitro != null ? tenVaitro.hashCode() : 0);
        return result;
    }
}
