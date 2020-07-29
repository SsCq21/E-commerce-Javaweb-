<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>sOrderDetail</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">

	<%
		String sid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String oid = request.getParameter("index");
	%>

	<div class="text-right">
		<h4>
			<a href="sMain.jsp">HOME</a>&nbsp;&nbsp; <a href="personal.jsp">Welcome~<%=sid%></a>&nbsp;&nbsp;
			<a href="sOrder.jsp">Order</a>&nbsp;&nbsp; <a href="index.jsp">Exit</a>&nbsp;&nbsp;
		</h4>
	</div>
	<br>

	<div class="text-center">
		<h1>Order Management</h1>
	</div>
	<br>

	<div class="row">
		<div class="col-md-2 text-center">.</div>
		<div class="col-md-8 text-left">
			<%
				try {
					Class.forName("com.mysql.jdbc.Driver");
				} catch (ClassNotFoundException e) {
				}

				String url = "jdbc:mysql://localhost:8889/ecommerce";
				Connection conn = DriverManager.getConnection(url, "root", "root");

				Statement s = conn.createStatement();

				String sql = "select order_status, order_purchase_timestamp from orders where order_id='" + oid + "'";
				ResultSet ck = s.executeQuery(sql);
				ck.next();
				String ostatus = ck.getString("order_status");
				String odate = ck.getString("order_purchase_timestamp");

				String sql2 = "select payment_type, payment_value from order_payments where order_id='" + oid + "'";
				ResultSet ck2 = s.executeQuery(sql2);
				ck2.next();
				String ptype = ck2.getString("payment_type");
				String pvalue = ck2.getString("payment_value");

				if (ostatus.equals("paid")) {
					String sql5 = "update orders set order_status ='delivering' where order_id='" + oid + "'";
					try {
						s.executeUpdate(sql5);
					} catch (SQLException e) {
						out.println(e);
						out.println("<a href='cOrder.jsp'>...Return(sql5 error)</a>");
						return;
					}
			%>
			<h3>
				<font color="grey">Change the order to DELIVERING
					successfully... </font>
			</h3>
			<br>
			<%
				}
			%>
			<h4>
				OrderID:&nbsp;<%=oid%></h4>
			<h4>
				Date:&nbsp;<%=odate%></h4>
			<h4>
				Payment:&nbsp;<%=ptype%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font
					color="red">Value:&nbsp;$<%=pvalue%></font>
			</h4>

			<table class="table table-bordered margin-top:-50px" width=100%
				align=center>
				<thead>
					<tr class="active">
						<td align="center">OrderItemID</td>
						<td align="center">ProductID</td>
						<td align="center">Image</td>
						<td align="center">Price</td>

					</tr>
				</thead>
				<%
					String sql3 = "select order_item_id, product_id, price from order_items where order_id='" + oid + "'";
					ResultSet ck3 = s.executeQuery(sql3);
					int i = 0;
					while (ck3.next()) {
						String itemid = ck3.getString("order_item_id");
						String pid = ck3.getString("product_id");
						String price = ck3.getString("price");
				%>
				<tbody>
					<tr>
						<td align="center"><%=itemid%></td>
						<td align="center"><a href="cItem.jsp?index=<%=pid%>"><%=pid%></a></td>
						<td align="center"><img border=0 height=100
							src="IMG/product/<%=pid%>.jpg"></td>
						<td align="center"><font color="red">$<%=price%></font></td>
					</tr>
				</tbody>
				<%
					i = i + 1;
					}

					s.close();
					conn.close();
				%>
			</table>


		</div>
		<div class="col-md-2 text-center">.</div>
	</div>


</body>
</html>
