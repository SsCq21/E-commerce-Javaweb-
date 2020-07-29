<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" import="java.text.SimpleDateFormat"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>sNewProductChange</title>

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
	New product added...
	<br>

	<%
		String id = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");

		String name = request.getParameter("pname");
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

		java.util.Date date = new java.util.Date();
		String pdate = new SimpleDateFormat("yyyyMMdd").format(date);

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String pid = null;

		for (int i = 1; i < 999; i++) {
			String n = String.valueOf(i);
			pid = pdate + id + name + n;

			String sql2 = "select count(*) from products where product_id ='" + pid + "'";
			ResultSet rs2 = s.executeQuery(sql2);
			int count = 0;
			while (rs2.next()) {
				count = rs2.getInt(1);
			}
			if (count == 0) {
				break;
			}
		}

		String sql = "insert into products(product_id, product_category_name, product_price, product_weight_g,product_length_cm, product_height_cm, product_width_cm) values ('"
				+ pid + "','" + category + "','" + price + "','" + weight + "','" + length + "','" + height + "','"
				+ width + "')";
		try {
			s.executeUpdate(sql);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='sMain.jsp'>...Return(sql error)</a>");
			return;
		}

		String sql2 = "insert into product_seller(product_id, seller_id) values ('" + pid + "','" + ucsid + "')";
		try {
			s.executeUpdate(sql2);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='sMain.jsp'>...Return(sql2 error)</a>");
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
