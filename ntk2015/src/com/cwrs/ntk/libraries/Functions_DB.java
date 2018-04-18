package com.cwrs.ntk.libraries;

import javax.sql.DataSource;
import java.sql.*;

/**
 * Created by VN on 3/17/2015.
 */
public class Functions_DB {
    private DataSource ds;
    Connection conn;
    static Statement statement;

    public void createStatement() {
        if (statement == null) {
            try {
                conn = ds.getConnection();
                statement = conn.createStatement();
            } catch (SQLException e) {
                System.out.println("CreateStatement error:" + e.toString());
            }
        }
    }

    public ResultSet retrieveData(String sqlCommand) {
        try {
            ResultSet rs = statement.executeQuery(sqlCommand);
            return rs;
        } catch (SQLException e) {
            System.out.println("RetrieveData error:" + e.toString());
            return null;
        }
    }

    public int executeUpdate_Parameter(String sqlCommand, int[] indexes, String[] value) {
        int affectRow = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(sqlCommand);
            for (int i = 0; i < indexes.length; i++) {
                pstmt.setString(indexes[i],value[i]);
            }
            affectRow = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("executeUpdate_Parameter error:" + e.toString());
        }
        return affectRow;
    }
}
