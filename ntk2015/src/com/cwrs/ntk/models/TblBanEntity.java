package com.cwrs.ntk.models;

import javax.persistence.*;

/**
 * Created by VN on 3/5/2015.
 */
@Entity
@Table(name = "tbl_ban", schema = "public", catalog = "ntm")
public class TblBanEntity {
    private int banId;
    private long startTime;
    private long endTime;

    @Id
    @Column(name = "ban_id")
    public int getBanId() {
        return banId;
    }

    public void setBanId(int banId) {
        this.banId = banId;
    }

    @Basic
    @Column(name = "start_time")
    public long getStartTime() {
        return startTime;
    }

    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    @Basic
    @Column(name = "end_time")
    public long getEndTime() {
        return endTime;
    }

    public void setEndTime(long endTime) {
        this.endTime = endTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TblBanEntity that = (TblBanEntity) o;

        if (banId != that.banId) return false;
        if (endTime != that.endTime) return false;
        if (startTime != that.startTime) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = banId;
        result = 31 * result + (int) (startTime ^ (startTime >>> 32));
        result = 31 * result + (int) (endTime ^ (endTime >>> 32));
        return result;
    }
}
