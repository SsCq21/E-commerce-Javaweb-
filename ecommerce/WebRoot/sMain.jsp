<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="bean.Product" import="java.sql.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>sellerMain</title>

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
	%>
	<div class="text-right">
		<h4>
			<a href="sMain.jsp">HOME</a>&nbsp;&nbsp; <a href="personal.jsp">Welcome~<%=sid%></a>&nbsp;&nbsp;
			<a href="sOrder.jsp">Order</a>&nbsp;&nbsp; <a href="index.jsp">Exit</a>&nbsp;&nbsp;
		</h4>
	</div>
	<br>

	<div class="text-center">
		<h1>Product Management</h1>
	</div><br>

	<div class="row">
		<div class="col-md-1 text-center">.</div>
		<div class="col-md-10">
		<div class="text-right">
		<h4 class="btn btn-info"><a href="sNewProduct.jsp">Add New Product</a></h4>
		</div>
			<table class="table table-bordered margin-top:-50px" width=100%
				align=center>
				<thead>
					<tr class="active">
						<td align="center"><h4>Product</h4></td>
						<td align="center"><h4>Image</h4></td>
						<td align="center"><h4>Category</h4></td>
						<td align="center"><h4>Price</h4></td>
						<td align="center"><h4>Weight</h4></td>
						<td align="center"><h4>Length-Width-Height</h4></td>
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

					String sql = "SELECT products.product_id, product_category_name, product_price, product_weight_g, product_length_cm, product_height_cm, product_width_cm from products, product_seller where products.product_id=product_seller.product_id and product_seller.seller_id = '"
							+ ucsid + "'";
					ResultSet ck = s.executeQuery(sql);
					int i = 0;
					while (ck.next()) {
						String pid = ck.getString("product_id");
						String category = ck.getString("product_category_name");
						String price = ck.getString("product_price");
						String weight = ck.getString("product_weight_g");
						String length = ck.getString("product_length_cm");
						String width = ck.getString("product_width_cm");
						String height = ck.getString("product_height_cm");
				%>
				<tbody>
					<tr>
						<td align="center"><h4><%=pid%></h4></td>
						<td align="center"><img border=0 height=100
							src="IMG/product/<%=pid%>.jpg"></td>
						<td align="center"><h4><%=category%></h4></td>
						<td align="center"><h4><font color="red">$<%=price%></font></h4></td>
						<td align="center"><h4><%=weight%></h4></td>
						<td align="center"><h4><%=length%>-<%=width%>-<%=height%></h4></td>
						<td align="center"><a href="sProductProfile.jsp?index=<%=pid%>"><h4 class="btn btn-primary">Update</h4></a></td>
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
