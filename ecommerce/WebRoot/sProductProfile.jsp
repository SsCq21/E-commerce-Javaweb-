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

<title>sProductProfile</title>

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
<link rel="stylesheet" type="text/css" href="res/static/css/input.css">

<script type="text/javascript">
	function del() {
		var price = document.getElementById("price").value;
		if (upassword == "") {
			alert("Price cannot be null！");
			return false;
		}
		if (!confirm("Confirm to submit the product profile change？")) {
			window.event.returnValue = false;
		}
	}
</script>

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">

	<%
		String sid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String pid = request.getParameter("index");

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql = "select product_category_name, product_price, product_weight_g, product_length_cm, product_height_cm, product_width_cm from products where product_id='"
				+ pid + "'";
		ResultSet ck = s.executeQuery(sql);
		ck.next();
		String category = ck.getString("product_category_name");
		String price = ck.getString("product_price");
		String weight = ck.getString("product_weight_g");
		String length = ck.getString("product_length_cm");
		String width = ck.getString("product_width_cm");
		String height = ck.getString("product_height_cm");

		s.close();
		conn.close();
	%>
	<div class="text-right">
		<h4>
			<a href="sMain.jsp">HOME</a>&nbsp;&nbsp; <a href="personal.jsp">Welcome~<%=sid%></a>&nbsp;&nbsp;
			<a href="sOrder.jsp">Order</a>&nbsp;&nbsp; <a href="index.jsp">Exit</a>&nbsp;&nbsp;
		</h4>
	</div>
	<br>
	<div class="text-center">
		<h1>Product Profile</h1>
	</div>

	<div class="row">

		<div class="col-md-3 text-center">.</div>
		<div class="col-md-6 text-center">
			<h4>
				Product:&nbsp;<%=pid%></h4>
			<h4>
				Image: <img border=0 height=100 src="IMG/product/<%=pid%>.jpg">
			</h4>

			<form action="sProductChange.jsp?index=<%=pid%>.jsp" method="post" onsubmit="return del()">
				<h4>
					Category:&nbsp;<input style="width:200px" type="text" id="category"
						name="category" value="<%=category%>">
				</h4>
				<h4>
					Price:&nbsp;<input style="width:100px" type="text" id="price"
						name="price" value="<%=price%>"
						onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
						onblur="this.v();" />
				</h4>
				<h4>
					Weight:&nbsp;<input style="width:100px" type="text" id="weight"
						name="weight" value="<%=weight%>"
						onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
						onblur="this.v();" />
				</h4>
				<h4>
					Length:&nbsp;<input style="width:100px" type="text" id="length"
						name="length" value="<%=length%>"
						onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
						onblur="this.v();" />
				</h4>
				<h4>
					Width:&nbsp;<input style="width:100px" type="text" id="width"
						name="width" value="<%=width%>"
						onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
						onblur="this.v();" />
				</h4>
				<h4>
					Height:&nbsp;<input style="width:100px" type="text" id="height"
						name="height" value="<%=height%>"
						onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
						onblur="this.v();" />
				</h4>
				<input class="btn btn-primary" type="submit" value="Submit">

			</form>
		</div>
		<div class="col-md-3 text-center">.</div>

	</div>

</body>
</html>
