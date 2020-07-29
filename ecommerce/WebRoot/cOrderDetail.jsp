<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%@ page import="bean.Product"%>
<%@ page import="bean.Order"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>cOrderDetail</title>

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
		String cid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String oid = request.getParameter("index");
	%>

	<div>
		<h4>
			&nbsp;<a href="cMain.jsp">HOME</a>
		</h4>
		<h4>
			&nbsp;<a href="personal.jsp">Welcome_<%=cid%></a>
		</h4>
		<h4>
			&nbsp;<a href="cShoppingCart.jsp">Shopping_Cart</a>
		</h4>
		<h4>
			&nbsp;<a href="cOrder.jsp">Order</a>
		</h4>
		<h4>
			&nbsp;<a href="index.jsp">Exit</a>
		</h4>
	</div>

	<p style="margin:20px"></p>
	<div class="text-center">


		<h1>Order Detail</h1>
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

				if (!ostatus.equals("delivered")) {
			%>
			<h3>
				<font color="grey">Order confirmed successfully! </font>
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
			<%
				String sql4 = "select count(*) from order_reviews where order_id='" + oid + "'";
				ResultSet ck4 = s.executeQuery(sql4);
				int count = 0;
				while (ck4.next()) {
					count = ck4.getInt(1);
				}
			%>
			<table class="table table-bordered margin-top:-50px" width=100%
				align=center>
				<thead>
					<tr class="active">
						<td align="center">ProductID</td>
						<td align="center">Image</td>
						<td align="center">SellerID</td>
						<td align="center">Price</td>
						<td align="center"></td>
					</tr>
				</thead>
				<%
					String sql3 = "select product_id, seller_id, price from order_items where order_id='" + oid + "'";
					ResultSet ck3 = s.executeQuery(sql3);
					int i = 0;
					while (ck3.next()) {
						String pid = ck3.getString("product_id");
						String sid = ck3.getString("seller_id");
						String price = ck3.getString("price");
				%>
				<tbody>
					<tr>
						<td align="center"><a href="cItem.jsp?index=<%=pid%>"><%=pid%></a></td>
						<td align="center"><img border=0 height=100
							src="IMG/product/<%=pid%>.jpg"></td>
						<td align="center"><a href=".jsp?index=<%=sid%>"><%=sid%></a></td>
						<td align="center"><%=price%></td>
						<%
							if (count != 0) {
						%>
						<td align="center"><a href="cItem.jsp?index=<%=pid%>"><h
									class="btn btn-success">ViewComment</h></a></td>
						<%
							} else {
						%>
						<td align="center"><a href="cMakeComment.jsp?index=<%=oid%>"><h
									class="btn btn-success">MakeComment</h></a></td>
						<%
							}
						%>

					</tr>
				</tbody>
				<%
					i = i + 1;
					}
					String sql5 = "update orders set order_status ='delivered' where order_id='" + oid + "'";
					try {
						s.executeUpdate(sql5);
					} catch (SQLException e) {
						out.println(e);
						out.println("<a href='cOrder.jsp'>...Return(sql5 error)</a>");
						return;
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
