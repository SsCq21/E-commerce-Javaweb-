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

<title>sProductChange</title>

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
	Product profile updated...
	<br>
	<%
		String id = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String pid = request.getParameter("index");

		String category = request.getParameter("category");
		String price2 = request.getParameter("price");
		String weight2 = request.getParameter("weight");
		String length2 = request.getParameter("length");
		String width2 = request.getParameter("width");
		String height2 = request.getParameter("height");

		int weight = Integer.parseInt(weight2);
		int length = Integer.parseInt(length2);
		int width = Integer.parseInt(width2);
		int height = Integer.parseInt(height2);
		Double price = Double.parseDouble(price2);

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql2 = "update products set product_category_name ='" + category + "',product_weight_g='" + weight
				+ "' where product_id='" + pid + "'";
		try {
			s.executeUpdate(sql2);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='sProductProfile.jsp'>...Return(sql2 error)</a>");
			return;
		}

		String sql = "update products set product_category_name ='" + category + "',product_price='" + price
				+ "',product_weight_g='" + weight + "',product_length_cm='" + length + "',product_height_cm='"
				+ height + "',product_width_cm='" + width + "' where product_id='" + pid + "'";
		try {
			s.executeUpdate(sql);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='sProductProfile.jsp'>...Return(sql error)</a>");
			return;
		}

		s.close();
		conn.close();

		out.println("Successfully!!");
		out.println("Turn back in 3 seconds... <br><br> <a href='sMain.jsp'>If not, press here</a>");
		response.setHeader("refresh", "3;URL=sMain.jsp");
	%>

</body>
</html>
