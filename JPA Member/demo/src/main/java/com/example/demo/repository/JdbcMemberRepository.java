package com.example.demo.repository;

import com.example.demo.domain.Member;
import org.springframework.jdbc.datasource.DataSourceUtils;
import javax.sql.DataSource;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class JdbcMemberRepository implements MemberRepository {
    private final DataSource dataSource;
    private final static String passwd = "";
    private final static String HOST = "";
    private final static int PORT = 22;
    private final static String SSH_USER = "";

    private Session session;

    public void closeSSH()
    {
        session.disconnect();
    }

    public JdbcMemberRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Member save(Member member) {
        String sql = "insert into member(name) values(?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Properties config = new Properties();
        JSch jsch = new JSch();
        config.put("StrictHostKeyChecking", "no");
        System.out.println("세션 생성");
        try {
            System.out.println("SSH 접속 중...");
            session = jsch.getSession(SSH_USER, HOST, PORT);
            session.setPassword(passwd);
            session.setConfig(config);
            session.connect();
            System.out.println("접속 완료.");
            session.setPortForwardingL(3306, HOST, 3306);
            conn = getConnection();
            pstmt = conn.prepareStatement(sql,
                    Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, member.getName());
            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                member.setId(rs.getLong(1));
            } else {
                throw new SQLException("id 조회 실패");
            }
        } catch (JSchException e) {
            System.out.println("SSH 접속 실패");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("DB 접속 실패");
            throw new IllegalStateException(e);
        }
        finally {
            close(conn, pstmt, rs);
            session.disconnect();
            return member;
        }
    }

    @Override
    public Optional<Member> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public Optional<Member> findByName(String name) {
        return Optional.empty();
    }

    @Override
    public List<Member> findAll() {
        String sql = "select * from member";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Properties config = new Properties();
        JSch jsch = new JSch();
        config.put("StrictHostKeyChecking", "no");
        System.out.println("세션 생성");
        List<Member> members = new ArrayList<>();
        try {
            System.out.println("SSH 접속 중...");
            session = jsch.getSession(SSH_USER, HOST, PORT);
            session.setPassword(passwd);
            session.setConfig(config);
            session.connect();
            System.out.println("접속 완료.");
            session.setPortForwardingL(3306, HOST, 3306);
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next())
            {
                Member member = new Member();
                member.setId(rs.getLong("id"));
                member.setName(rs.getString("name"));
                members.add(member);
            }
        } catch (JSchException e) {
            System.out.println("SSH 접속 실패");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("DB 접속 실패");
            throw new IllegalStateException(e);
        }
        finally {
            close(conn, pstmt, rs);
            session.disconnect();
            return members;
        }
    }

    private Connection getConnection() {

        return DataSourceUtils.getConnection(dataSource);
    }

    private void close(Connection conn, PreparedStatement pstmt, ResultSet rs)
    {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) {
                close(conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private void close(Connection conn) throws SQLException {
        DataSourceUtils.releaseConnection(conn, dataSource);
    }
}