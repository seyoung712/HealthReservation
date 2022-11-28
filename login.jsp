<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<!-- 전역변수 선언 및 입력정보 추출 -->
<%
Connection        con  = null;
PreparedStatement pstmt = null;
ResultSet         rs    = null;
String            sql   = "";
String            rst   = "success";
String            msg   = "";
int               cnt   = 0;

String driverName = "com.mysql.jdbc.Driver";
String dbURL = "jdbc:mysql://localhost:3306/health_db";

Class.forName(driverName);
con = DriverManager.getConnection(dbURL, "root", "jsb2723");

// 입력정보 한글 처리
request.setCharacterEncoding("utf-8");
// 사용자 입력정보 추출

String radioValue = "";
radioValue=request.getParameter("account"); 
String mem="mem";
String trn="trn";
String adm="adm";

if(radioValue.equals(mem)){ //radioValue가 null로 나옴
	String ID   = request.getParameter("id");
	String PW = request.getParameter("pw");
}
else if(radioValue.equals(trn)){
	String ID   = request.getParameter("id");
	String PW = request.getParameter("pw");
}
else if(radioValue.equals(adm)){
	String ID   = request.getParameter("id");
	String PW = request.getParameter("pw");
}


String name = "";
// DB 관련 객체/변수


try {
   	// 등록된 아이디의 여부 검사
	if(radioValue.equals(mem)){
	sql = "select MEM_NAME " + 
		  "  from 회원 " + 
		  " where MEM_ID   = ? " +
		  "   and MEM_PASS = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, "ID");
   	pstmt.setString(2, "PW");
    rs = pstmt.executeQuery();
}
	else if(radioValue.equals(trn))
	{
		sql = "select TRN_NAME " + 
		  "  from 강사 " + 
		  " where TRN_ID   = ? " +
		  "   and TRN_PASS = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, "ID");
   	pstmt.setString(2, "PW");
    rs = pstmt.executeQuery();
	}
	else if(radioValue.equals(adm)){
		sql = "select ADM_NAME " + 
		  "  from 관리자 " + 
		  " where ADM_ID   = ? " +
		  "   and ADM_PASS = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, "ID");
   	pstmt.setString(2, "PW");
    rs = pstmt.executeQuery();
	}
    
    // 등록된 아이디의 경우, 성명 추출
    if ( radioValue.equals(mem) ) {
        //name = rs.getString("MEM_NAME");
			
        // 세션 저장
		session.setAttribute("MEM_ID", "ID");
		session.setAttribute("MEM_PASS", "PW");
              
    }
	else if( radioValue.equals(trn) ) {
			
        // 세션 저장
		session.setAttribute("TRN_ID", "ID");
		session.setAttribute("TRN_PASS", "PW");
    } 
	else if( radioValue.equals(adm)) {
       
        // 세션 저장
		session.setAttribute("ADM_ID", "ID");
		session.setAttribute("ADM_PASS", "PW");
    } 
	else {// 등록된 아이디가 아닌 경우
	    rst = "로그인에러";
		msg = "회원이 아닙니다!";
    } 
} 
catch(SQLException e) {
	rst = "시스템에러";
	msg = e.getMessage();
} finally {
   	if(rs != null) 
   	    rs.close();
   	if(pstmt != null) 
   	    pstmt.close();
   	if(con != null) 
   	    con.close();
}

//로그인 확인 out.println(radioValue +"로그인 성공");
// 로그인 후, 사용자 홈으로 이동
if(rst.equals("success")){
	if(radioValue.equals(mem)){
		response.sendRedirect("account_mem.html");
	}
	else if(radioValue.equals(trn)){
		//pageContext.forward("account_trn.html");
		response.sendRedirect("account_trn.html");
	}
	else if(radioValue.equals(adm)){
		response.sendRedirect("account_admin.html");
	}
}
else{
	out.println(radioValue);
	out.println(rst);
}

%>   

