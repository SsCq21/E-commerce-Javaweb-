<%@ page language="java" import="java.util.*" import="java.sql.*"
	import="java.util.Date" import="java.text.SimpleDateFormat"
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

<title>registerJudge</title>

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

	Register:
	<br>
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String uname = request.getParameter("uname");
		String upwd = request.getParameter("upwd");
		String zip = request.getParameter("zip");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String type = request.getParameter("type");

		java.util.Date date = new java.util.Date();
		String rdate = new SimpleDateFormat("yyyyMMdd").format(date);

		String sql = "select count(*) from user where uid='" + uname + "'";
		ResultSet ck = s.executeQuery(sql);
		int count = 0;
		while (ck.next()) {
			count = ck.getInt(1);
		}
		if (count != 0) {
			out.println("This username has been registered...");
			out.println("Turn back in 3 seconds... <br><br> <a href='index.jsp'>If not, press here</a>");
			response.setHeader("refresh", "3;URL=index.jsp");
		} else {
			String ucsid = rdate + uname;
			String unique = uname + "unique" + rdate;

			if (type.equals("customer")) {
				String sql2 = "insert into customers values('" + ucsid + "','" + unique + "','" + zip + "','" + city
						+ "','" + state + "')";
				try {
					s.executeUpdate(sql2);
				} catch (SQLException e) {
					out.println(e);
					out.println("<a href='register.jsp'>Return(sql2 error)</a>");
					return;
				}

				String sql3 = "insert into user values ('" + uname + "','" + upwd + "','customer','" + ucsid + "')";
				try {
					s.executeUpdate(sql3);
				} catch (SQLException e) {
					out.println(e);
					out.println("<a href='register.jsp'>Return(sql3 error)</a>");
					return;
				}
			}

			else {
				String sql4 = "insert into sellers values('" + ucsid + "','" + zip + "','" + city + "','" + state
						+ "')";
				try {
					s.executeUpdate(sql4);
				} catch (SQLException e) {
					out.println(e);
					out.println("<a href='register.jsp'>Return(sql4 error)</a>");
					return;
				}

				String sql5 = "insert into user values ('" + uname + "','" + upwd + "','seller','" + ucsid + "')";
				try {
					s.executeUpdate(sql5);
				} catch (SQLException e) {
					out.println(e);
					out.println("<a href='register.jsp'>Return(sql5 error)</a>");
					return;
				}

			}

		}
		s.close();
		conn.close();

		out.println("Successfully!!");
		out.println("Turn back in 3 seconds... <br><br> <a href='index.jsp'>If not, press here</a>");
		response.setHeader("refresh", "3;URL=index.jsp");
	%>

</body>
</html>
