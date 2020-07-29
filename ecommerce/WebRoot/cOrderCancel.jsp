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

<title>cOrderCancel</title>

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
	<h3>
		<font color="grey">Order cancelled...</font>
	</h3>
	<br>

	<%
		String cid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String oid = request.getParameter("index");

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql5 = "update orders set order_status ='unavailable' where order_id='" + oid + "'";
		try {
			s.executeUpdate(sql5);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cOrder.jsp'>...Return(sql5 error)</a>");
			return;
		}

		out.println("Successfully!!");
		out.println("Turn back in 3 seconds... <br><br> <a href='cOrder.jsp'>If not, press here</a>");
		response.setHeader("refresh", "3;URL=cOrder.jsp");

		s.close();
		conn.close();
	%>

</body>
</html>
