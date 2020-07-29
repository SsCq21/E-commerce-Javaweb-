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

<title>cMakeComment</title>

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
<link rel="stylesheet" type="text/css" href="res/static/css/input.css">

<script type="text/javascript">
	function del() {
		if (!confirm("Confirm to submit the Comment？")) {
			window.event.returnValue = false;
		}
	}
</script>

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
			&nbsp;<a href="#">Welcome_<%=cid%></a>
		</h4>
		<h4>
			&nbsp;<a href="#">Shopping_Cart</a>
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
		<h1>Make Comment</h1>
	</div>
	<br>

	<div class="row">
		<div class="col-md-1 text-center">.</div>
		<div class="col-md-10 text-center">
			<form action="cCommented.jsp?index=<%=oid%>" method="post" onsubmit="return del()">
				<h4>
					Title:<input style="width:400px" type="text" id="title"
						name="title" placeholder="Title">
				</h4>
				<h4>
					Score: <select style="width:50px" id="score" name="score">
						<option value="5">5</option>
						<option value="4">4</option>
						<option value="3">3</option>
						<option value="2">2</option>
						<option value="1">1</option>
					</select>
				</h4>
				<h4>
					Review: <input style="width:600px" type="text" id="review" name="review"
						placeholder="Review..">
				</h4>
				<input class="btn btn-primary" type="submit" value="Submit">
			</form>
			<br><br>
			<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");
		String Cid = (String) session.getAttribute("userid");
		
		Statement s = conn.createStatement();
		
		
		
	%>
	<table class="table table-bordered margin-top:-50px" width=100%
				align=center>
				<thead>
					<tr class="active">
						<td align="center">Product</td>
						<td align="center">Image</td>
						<td align="center">Category</td>
						<td align="center">Price</td>
					</tr>
				</thead>
				<%
				String sql = "SELECT products.product_id, product_category_name, product_price FROM order_items, products  where products.product_id = order_items.product_id and order_id='"+oid+"'";
				ResultSet ck = s.executeQuery(sql);
				int i = 0;
				while(ck.next()) {
				String pid = ck.getString("product_id");
				String pcategory = ck.getString("product_category_name");
				String price = ck.getString("product_price");
				
				
				 %>
				<tbody>
					<tr>
						<td align="center"><a href="cItem.jsp?index=<%=pid%>"><%=pid%></a></td>
						<td align="center"><img height=150 src="IMG/product/<%=pid%>.jpg"></td>
						<td align="center"><%=pcategory%></td>
						<td align="center"><%=price%></td>
						</tr>
				</tbody>
				<%i=i+1;}
				s.close();
				conn.close();
				 %>
				</table>
		</div>
		<div class="col-md-1 text-center">.</div>
	</div>
</body>
</html>
