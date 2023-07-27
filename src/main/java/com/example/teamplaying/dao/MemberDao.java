package com.example.teamplaying.dao;

import com.example.teamplaying.domain.Member;

import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

@Repository
public class MemberDao {

//    public boolean deleteMember(int memberId) {
//        Connection conn = null;
//        PreparedStatement pstmt = null;
//
//        try {
//            // 데이터베이스 연결
//            // ...
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            // SQL 쿼리를 작성하고 PreparedStatement 초기화
//            String sql = "DELETE FROM Member WHERE id = ?";
//            pstmt = conn.prepareStatement(sql);
//            pstmt.setInt(1, memberId);
//
//            // 쿼리 실행
//            int rowsAffected = pstmt.executeUpdate();
//
//            // 삭제가 성공하면 rowsAffected는 1이상의 값을 가짐
//            return rowsAffected > 0;
//
//        } catch (Exception e) {
//            throw new RuntimeException(e.getMessage());
//        } finally {
//            // Connection, PreparedStatement 닫기
//            // ...
//        }
//    }

    public ArrayList<Member> getMemberList() {
        ArrayList<Member> memberList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 드라이버를 로드합니다.
            String url = "jdbc:mysql://localhost:3306/ZeroOne"; // 자신의 데이터베이스 정보에 맞게 수정하세요.
            String user = "your_username"; // 자신의 데이터베이스 사용자 이름에 맞게 수정하세요.
            String password = "your_password"; // 자신의 데이터베이스 비밀번호에 맞게 수정하세요.
            conn = DriverManager.getConnection(url, user, password);

            // SQL 쿼리를 작성하고 PreparedStatement 초기화
            String sql = "SELECT * FROM member"; // 적절한 SQL 쿼리를 작성하세요.
            pstmt = conn.prepareStatement(sql);

            // ResultSet으로 결과 가져오기
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setPassword(rs.getString("password"));
                member.setUserId(rs.getString("userId"));
                member.setName(rs.getString("name"));
                member.setAddress(rs.getString("address"));
                member.setPhone(rs.getString("phone"));
                member.setEmail(rs.getString("email"));
                member.setMemberType(rs.getString("memberType"));
                // ... (다른 필드들도 가져와서 설정)

                memberList.add(member);
            }

            return memberList;

        } catch (Exception sql) {
            throw new RuntimeException(sql.getMessage());
        } finally {
            // Connection, PreparedStatement, ResultSet 닫기
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    // 다른 데이터베이스 관련 메서드들도 추가할 수 있습니다.
    // ...
}
