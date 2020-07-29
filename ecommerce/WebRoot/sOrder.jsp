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

<title>sellerOrder</title>

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
		if (!confirm("Confirm to change the status to DELIVERING?")) {
			window.event.returnValue = false;
		}
	}
</script>

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<%
		String sid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
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
		<div class="col-md-1 text-center">.</div>
		<div class="col-md-10 text-center">
			<table class="table table-bordered margin-top:-50px" width=100%
				align=center>
				<thead>
					<tr class="active">
						<td align="center"><h4>OrderID</h4></td>
						<td align="center"><h4>Customer</h4></td>
						<td align="center"><h4>Value</h4></td>
						<td align="center"><h4>BuyDate</h4></td>
						<td align="center"><h4>Status</h4></td>
						<td align="center"></td>
					</tr>
				</thead>
				<%
					try {
						Class.forName("com.mysql.jdbc.Driver");
					} catch (ClassNotFoundException e) {
					}

					String url = "jdbc:mysql://localhost:8889/ecommerce";
					Connection conn = DriverManager.getConnection(url, "root", "root");

					Statement s = conn.createStatement();

					String sql = "SELECT orders.order_id, customer_id,order_status,order_purchase_timestamp ,order_payments.payment_value FROM orders, order_items, order_payments where orders.order_id=order_items.order_id and orders.order_id=order_payments.order_id and order_items.seller_id='"
							+ ucsid + "' order by order_id desc";
					ResultSet ck = s.executeQuery(sql);
					int i = 0;
					while (ck.next()) {
						String oid = ck.getString("order_id");
						String cid = ck.getString("customer_id");
						String value = ck.getString("payment_value");
						String status = ck.getString("order_status");
						String date = ck.getString("order_purchase_timestamp");
				%>
				<tbody>
					<tr>
						<td align="center"><h4><%=oid%></h4></td>
						<td align="center"><h4><%=cid%></h4></td>
						<td align="center"><h4>
								<font color="red">$<%=value%></font>
							</h4></td>
						<td align="center"><h4><%=date%></h4></td>
						<td align="center"><h4><%=status%></h4></td>
						<%if(status.equals("paid"))  {%>
						<td align="center"><a href="sOrderDetail.jsp?index=<%=oid%>"
							onclick="return del()"><h4 class="btn btn-primary">Delivering</h4></a></td>
							<%} else { %>
							<td align="center"><a href="sOrderDetail.jsp?index=<%=oid%>"><h4 class="btn btn-success">Detail</h4></a></td>
							<%} %>
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
		<div class="col-md-1 text-center">.</div>
	</div>
</body>
</html>
