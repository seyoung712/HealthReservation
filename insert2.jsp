<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> 회원 데이터베이스 </title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<h2>회원 테이블에 데이터를 삽입하는 프로그램 </h2>
<hr><center>
<h2>회원정보 등록</h2>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    StringBuffer SQL = new StringBuffer("insert into 회원 (MEM_NAME,MEM_MAIL,MEM_PHN,MEM_ID,MEM_PASS) "); 
    SQL.append("values (?, ?, ?, ?, ?)");
    String name = request.getParameter("MEM_NAME");


	String driverName = "com.mysql.jdbc.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/health_db";


    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "1234");
 //       pstmt = con.prepareStatement(sql);
 //       pstmt.executeUpdate();

        pstmt = con.prepareStatement(SQL.toString());
        //삽입할 회원 레코드 데이터 입력
        pstmt.setString(1, request.getParameter("MEM_NAME"));
        pstmt.setString(2, request.getParameter("MEM_MAIL"));
        pstmt.setString(3, request.getParameter("MEM_PHN"));
        pstmt.setString(4, request.getParameter("MEM_ID"));
        pstmt.setString(5, request.getParameter("MEM_PASS"));

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1) out.println("<hr>회원[" + name+ "] 레코드 하나가 성공적으로 삽입 되었습니다.<hr>");
        else out.println("회원 레코드 삽입에 문제가 있습니다.");
        
        //다시 조회
        stmt = con.createStatement();

    }
    catch(Exception e) {
    	out.println("MySql 데이터베이스 health_db의 mem 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    out.println("<meta http-equiv='Refresh' content='1;URL=list.jsp'>");
	
%>

<p><hr>
    <button><a onclick="window.location.href='admin.html'">관리자 페이지</a></button>
</body>
</html>