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

<title>cOrder</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script type="text/javascript">
	function del() {
		if (!confirm("Confirm the Receipt？")) {
			window.event.returnValue = false;
		}
	}
	
	function del2() {
		if (!confirm("Confirm to cancel the order？")) {
			window.event.returnValue = false;
		}
	}
</script>
</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">

	<%
		String cid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
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
			&nbsp;<a href="index.jsp">Exit</a>
		</h4>
	</div>

	<p style="margin:20px"></p>
	<div class="text-center">
		<h1>Order</h1>
	</div>
	<br>

	<div class="row">
		<div class="col-md-2 text-center">.</div>
		<div class="col-md-8 text-center">


			<%
				try {
					Class.forName("com.mysql.jdbc.Driver");
				} catch (ClassNotFoundException e) {
				}

				String url = "jdbc:mysql://localhost:8889/ecommerce";
				Connection conn = DriverManager.getConnection(url, "root", "root");

				Statement s = conn.createStatement();
				/*
								String sql = "select ucsid from user where uid='" + cid + "'";
								ResultSet ck = s.executeQuery(sql);
								ck.next();
								String ucsid = ck.getString("ucsid");
								//session.setAttribute("ucsid", ucsid);*/

				String sql2 = "select orders.order_id, orders.order_status, orders.order_purchase_timestamp, order_payments.payment_type, order_payments.payment_value from orders, order_payments where orders.order_id = order_payments.order_id and orders.customer_id ='"
						+ ucsid + "' order by order_id desc";
				ResultSet ck2 = s.executeQuery(sql2);
				int i = 0;
				ArrayList orderlist = new ArrayList();
			%>

			<table class="table table-bordered margin-top:-50px" width=100%
				align=center>
				<thead>
					<tr class="active">
						<td align="center">OrderID</td>
						<td align="center">Date</td>
						<td align="center">Payment</td>
						<td align="center">Total</td>
						<td align="center">Status</td>
						<td align="center"></td>
					</tr>
				</thead>

				<%
					while (ck2.next()) {
						String oid = ck2.getString("order_id");
						String ostatus = ck2.getString("order_status");
						String odate = ck2.getString("order_purchase_timestamp");

						/*String sql3 = "select payment_type, payment_value from order_payments where order_id='" + oid + "'";
						ResultSet ck3 = s.executeQuery(sql3);
						try {
							ck3.next();*/
						String ptype = ck2.getString("payment_type");
						double pvalue = ck2.getDouble("payment_value");
						/*
						} catch (SQLException e) {
						out.println(e);
						out.println("<a href='cMain.jsp'>...Return(sql3 error)</a>");
						return;
						}*/

						Order o = new Order();
						o.setodate(odate);
						o.setostatus(ostatus);
						o.setoid(oid);
						o.setptype(ptype);
						o.setpvalue(pvalue);
						orderlist.add(i, o);
				%>
				<tbody>
					<tr>
						<td align="center"><%=oid%></td>
						<td align="center"><%=odate%></td>
						<td align="center"><%=ptype%></td>
						<td align="center"><%=pvalue%></td>
						<td align="center"><%=ostatus%></td>
						<%
							if (ostatus.equals("delivered") || ostatus.equals("unavailable")) {
						%>
						<td align="center"><a href="cOrderDetail.jsp?index=<%=oid%>"><h
									class="btn btn-success">Detail</h></a></td>
						<%
							} else {
						%>
						<td align="center"><a href="cOrderDetail.jsp?index=<%=oid%>"
							onclick="return del()"><h class="btn btn-info">Confirm</h></a></td>
						<td align="center"><a href="cOrderCancel.jsp?index=<%=oid%>"
							onclick="return del2()"><h class="btn btn-danger">Cancel</h></a></td>
						<%
							}
						%>
					</tr>
				</tbody>

				<%
					i = i + 1;
					}
					session.setAttribute("orderlist", orderlist);

					s.close();
					conn.close();
				%>
			</table>
		</div>

		<div class="col-md-2 text-center">.</div>
	</div>
</body>
</html>
