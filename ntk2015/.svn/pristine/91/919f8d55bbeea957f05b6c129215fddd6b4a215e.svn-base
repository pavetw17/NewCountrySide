package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_subtopics", schema = "public", catalog = "ntm")
public class TblSubtopicsEntity {
    private int idSubtopic;
    private Boolean prjTopic;
    private String title;
    private String description;
    private TblDetaiDuanEntity tblDetaiDuanByIdDetai;

    @Id
    @Column(name = "id_subtopic")
    public int getIdSubtopic() {
        return idSubtopic;
    }

    public void setIdSubtopic(int idSubtopic) {
        this.idSubtopic = idSubtopic;
    }

    @Basic
    @Column(name = "prj_topic")
    public Boolean getPrjTopic() {
        return prjTopic;
    }

    public void setPrjTopic(Boolean prjTopic) {
        this.prjTopic = prjTopic;
    }

    @Basic
    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblSubtopicsEntity that = (TblSubtopicsEntity) o;

        if (idSubtopic != that.idSubtopic) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (prjTopic != null ? !prjTopic.equals(that.prjTopic) : that.prjTopic != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idSubtopic;
        result = 31 * result + (prjTopic != null ? prjTopic.hashCode() : 0);
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id_detai", referencedColumnName = "id_detai")
    public TblDetaiDuanEntity getTblDetaiDuanByIdDetai() {
        return tblDetaiDuanByIdDetai;
    }

    public void setTblDetaiDuanByIdDetai(TblDetaiDuanEntity tblDetaiDuanByIdDetai) {
        this.tblDetaiDuanByIdDetai = tblDetaiDuanByIdDetai;
    }
}
