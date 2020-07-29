<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ page import="bean.DB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>loginJudge</title>

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
	<br>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		//DB stmt=new DB();

		String id = request.getParameter("uname");
		String password = request.getParameter("upwd");
		session.setAttribute("userid", id);
		String sql = "select count(*) from user where uid='" + id + "'and upwd='" + password
				+ "' and utype = 'customer'";
		String sql2 = "select count(*) from user where uid='" + id + "'and upwd='" + password
				+ "' and utype = 'seller'";
		//ck = stmt.executeQuery(sql);
		Statement s = conn.createStatement();
		ResultSet ck = s.executeQuery(sql);
		Statement s2 = conn.createStatement();
		ResultSet ck2 = s2.executeQuery(sql2);
		int count1 = 0, count2 = 0;
		while (ck.next()) {
			count1 = ck.getInt(1);
		}
		while (ck2.next()) {
			count2 = ck2.getInt(1);
		}
		//ck.next();
		if (count1 != 0) {

			String sql3 = "select ucsid from user where uid ='" + id + "'";
			ResultSet ck3 = s.executeQuery(sql3);
			ck3.next();
			String uid = ck3.getString("ucsid");
			session.setAttribute("ucsid", uid);
			session.setAttribute("type", "customer");

			response.sendRedirect("cMain.jsp");
		} else if (count2 != 0) {
			//out.println("This is seller");
			String sql4 = "select ucsid from user where uid ='" + id + "'";
			ResultSet ck4 = s.executeQuery(sql4);
			ck4.next();
			String uid = ck4.getString("ucsid");
			session.setAttribute("type", "seller");
			session.setAttribute("ucsid", uid);
			//out.println("<br><br> <a href='index.jsp'>Back...</a>");
			response.sendRedirect("sMain.jsp");

		} else {
			out.println("Username and Password don't match...");
			out.println("Turn back in 3 seconds... <br><br> <a href='index.jsp'>If not, press here</a>");
			response.setHeader("refresh", "3;URL=index.jsp");

		}
	%>
</body>
</html>
