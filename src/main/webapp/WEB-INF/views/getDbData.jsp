<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="model.vo.CustomCustomerDetails" %>
<%@ page import="org.json.JSONObject"%> 
<%
String a = request.getParameter("cust_id");
try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
}catch(Exception e) {
	System.out.println(e.getMessage());
}

try(Connection connection = DriverManager.getConnection(
		"jdbc:oracle:thin:@opalproject-database-1.c5czyv6v8bgk.ap-northeast-2.rds.amazonaws.com:1521:ORCL","admin","ehdrb0059!");
		PreparedStatement pstmt = connection.prepareStatement
				("select * from customer where cust_id ='"+a+"'",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);)
{
	ResultSet rs = pstmt.executeQuery();
	StringBuffer buffer = new StringBuffer();
		buffer.append("[");
		while(rs.next()) {
			String cust_id = rs.getString(3);
			JSONObject object = new JSONObject();
			object = object.put("cust_id", cust_id);
			if(rs.isLast())
				buffer.append(object.toString());
			else
				buffer.append(object.toString()+",");
			}
		buffer.append("]");
		rs.close();

	response.getWriter().print(buffer);
}
		

catch(SQLException e){
	e.printStackTrace();
}

%>