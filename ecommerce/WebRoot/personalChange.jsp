<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>personalChange</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	Personal profile changed...
<br>
	<%
		String id = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String type = (String) session.getAttribute("type");

		String upwd = request.getParameter("upwd");
		String zip = request.getParameter("zip");
		String city = request.getParameter("city");
		String state = request.getParameter("state");

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql = "update user set upwd ='" + upwd + "' where uid='" + id + "'";
		try {
			s.executeUpdate(sql);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cOrder.jsp'>...Return(sql error)</a>");
			return;
		}

		if (type.equals("customer")) {
			String sql2 = "update customers set customer_zip_code_prefix='" + zip + "',customer_city='" + city
					+ "',customer_state='" + state + "'where customer_id='" + id + "'";
			try {
				s.executeUpdate(sql2);
			} catch (SQLException e) {
				out.println(e);
				out.println("<a href='cMain.jsp'>...Return(sql2 error)</a>");
				return;
			}
		} else if (type.equals("seller")) {
			String sql3 = "update sellers set seller_zip_code_prefix='" + zip + "',seller_city='" + city
					+ "',seller_state='" + state + "'where seller_id='" + id + "'";
			try {
				s.executeUpdate(sql3);
			} catch (SQLException e) {
				out.println(e);
				out.println("<a href='sMain.jsp'>...Return(sql3 error)</a>");
				return;
			}
		}
		s.close();
		conn.close();

		out.println("Successfully!!");
		out.println("Turn back in 3 seconds... <br><br> <a href='personal.jsp'>If not, press here</a>");
		response.setHeader("refresh", "3;URL=personal.jsp");
	%>
</body>
</html>
