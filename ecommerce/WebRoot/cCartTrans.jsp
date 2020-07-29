<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="bean.Product"%>
<%@ page import="java.text.SimpleDateFormat" import="java.util.Date"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<jsp:useBean id="tool" class="bean.MyTools" scope="page" />
<jsp:useBean id="car" class="bean.Cart" scope="session" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>cCartTrans</title>

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
	%>
	<div>
		<h4>
			&nbsp;&nbsp;&nbsp;<a href="cMain.jsp">HOME</a> &nbsp;<a
				href="personal.jsp">Welcome_<%=cid%></a> &nbsp;<a
				href="cShoppingCart.jsp">Shopping_Cart</a> &nbsp;<a href="index.jsp">Exit</a>
		</h4>
	</div>

	<br>
	<br>
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}
		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		java.util.Date date = new java.util.Date();
		String date2 = date.toString();
		String date3 = new SimpleDateFormat("yyyy-MM-dd").format(date);
		java.sql.Date date4 = new java.sql.Date(date.getDate());

		String transdate = new SimpleDateFormat("yyyyMMdd").format(date);

		String Tid = null;

		for (int i = 1; i < 999; i++) {
			String n = String.valueOf(i);
			Tid = transdate + n;

			String sql2 = "select count(*) from order_payments where order_id ='" + Tid + "'";
			ResultSet rs2 = s.executeQuery(sql2);
			int count = 0;
			while (rs2.next()) {
				count = rs2.getInt(1);
			}
			if (count == 0) {
				break;
			}
		}
	%>

	<div class="row">
		<div class="col-md-2 text-center">.</div>
		<div class="col-md-8">
			<div class="text-left">
				<h4>
					<font color="grey">Buy successfully!</font>
				</h4>
			</div>
			<div class="text-center">
				<h1>Order Detail</h1>
				<br>
				<%
					String zip = request.getParameter("zip");
					String city = request.getParameter("city");
					String state = request.getParameter("state");
					String payment = request.getParameter("payment");
					double total = (double) session.getAttribute("total");
				%>
				<div style="background-color:rgba(0,0,0,0.1);"> 
				<h4>
					OrderID:&nbsp;<%=Tid%></h4>
				<h4>
					Username:&nbsp;<%=cid%></h4>
				<h4>
					City:&nbsp;<%=city%></h4>
				<h4>
					State:&nbsp;<%=state%></h4>
				<h4>
					Zip:&nbsp;<%=zip%></h4>
				<h4>
					Payment:&nbsp;<%=payment%></h4>
				<h4>
					Total:&nbsp;<font color="red">$<%=total%></font>
				</h4>
				</div>
				<table class="table table-bordered margin-top:-50px" width=100%
					align=center>
					<thead>
						<tr class="active">
							<td align="center">Product</td>
							<td align="center">Image</td>
							<td align="center">Price</td>
							<td align="center">Amount</td>
							<td align="center">Value</td>
						</tr>
					</thead>
					<%
						ArrayList buylist = car.getBuylist();
						for (int i = 0; i < buylist.size(); i++) {
							Product product = new Product();
							product = (Product) buylist.get(i);
							String pid = product.getPid();
							double price = product.getprice();
							int num = product.getamount();
							double value = price * num;

							String sql4 = "select seller_id from product_seller where product_id='" + pid + "'";
							ResultSet ck4 = s.executeQuery(sql4);
							ck4.next();
							String sid = ck4.getString("seller_id");

							int order_id = 1;
							String sql = "select count(*) from order_items where order_id ='" + Tid + "'";
							ResultSet ck = s.executeQuery(sql);
							int count = 0;
							while (ck.next()) {
								count = ck.getInt(1);
							}
							if (count != 0) {
								String sql7 = "select order_item_id from order_items where order_id ='" + Tid + "'";
								ResultSet ck7 = s.executeQuery(sql7);
								ck7.next();
								int order_item_id = ck7.getInt("order_item_id");
								order_id = order_item_id + 1;
							}

							String sql5 = "insert into order_items(order_id, order_item_id, product_id, seller_id, price) values ('"
									+ Tid + "','" + order_id + "','" + pid + "','" + sid + "','" + value + "')";
							try {
								s.executeUpdate(sql5);
							} catch (SQLException e) {
								out.println(e);
								out.println("<a href='cCartBuy.jsp'>...Return(sql5 error)</a>");
								return;
							}
					%>
					<tbody>
						<tr>
							<td align="center"><%=pid%></td>
							<td align="center"><img border=0 height=100
								src="IMG/product/<%=pid%>.jpg"></td>
							<td align="center">$<%=price%></td>
							<td align="center"><%=num%></td>
							<td align="center"><font color="red">$<%=value%></font></td>
						</tr>
					</tbody>
					<%
						}
					%>

				</table>
				<%
					String sql3 = "insert into order_payments(order_id, payment_type, payment_value) values ('" + Tid + "','"
							+ payment + "','" + total + "')";
					try {
						s.executeUpdate(sql3);
					} catch (SQLException e) {
						out.println(e);
						out.println("<a href='cCartBuy.jsp'>Return(sql3 error)</a>");
						return;
					}

					String sql6 = "insert into orders(order_id, customer_id, order_status, order_purchase_timestamp) values ('"
							+ Tid + "','" + ucsid + "','paid','" + date3 + "')";
					try {
						s.executeUpdate(sql6);
					} catch (SQLException e) {
						out.println(e);
						out.println("<a href='cCartBuy.jsp'>...Return(sql6 error)</a>");
						return;
					}
					car.clearCar();
				%>
				<a href="cMain.jsp"><h4 class="btn btn-success">Back to Home</h4></a>
			</div>
		</div>
		<div class="col-md-2 text-center">.</div>
		<br>
</body>
</html>
