<%@ page language="java" import="java.util.*" import="java.sql.*"
	import="java.util.Date" pageEncoding="UTF-8"%>
<%@ page import="bean.Product" import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>cBuyTrans</title>

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
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="res/static/css/main.css">
<link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
<link rel="stylesheet" type="text/css" href="res/static/css/reviews.css">
<script type="text/javascript" src="res/layui/layui.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<script defer
	src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>

<script type="text/javascript">
	layui.config({
		base : '/res/static/js/util/'
	}).use([ 'mm', 'jquery' ], function() {
		var mm = layui.mm,
			$ = layui.$;
		var cur = $('.number-cont input').val();
		$('.number-cont .btn').on('click', function() {
			if ($(this).hasClass('add')) {
				cur++;

			} else {
				if (cur > 1) {
					cur--;
				}
			}
			$('.number-cont input').val(cur)
		})

	});
</script>

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<%
		String pid = request.getParameter("index");
		String cid = (String) session.getAttribute("userid");
		String ucid = (String) session.getAttribute("ucsid");

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

		String sql = "select product_price from products";
		ResultSet ck = s.executeQuery(sql);
		ck.next();
		double price = ck.getDouble("product_price");

		String quantity = request.getParameter("number");
		int quan = Integer.parseInt(quantity);
		//int quan = Integer.valueOf(quantity).intValue();
		double totalPrice = quan * price;
		String payment = request.getParameter("payment");

		String sql3 = "insert into order_payments(order_id, payment_type, payment_value) values ('" + Tid + "','"
				+ payment + "','" + totalPrice + "')";
		try {
			s.executeUpdate(sql3);
			//conn.commit();
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cMain.jsp'>Return(sql3 error)</a>");
			return;
		}

		String sql4 = "select seller_id from product_seller where product_id='" + pid + "'";
		/*try {
			ResultSet ck4 = s.executeQuery(sql4);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cMain.jsp'>Press here to return</a>");
			return;
		}*/	
		ResultSet ck4 = s.executeQuery(sql4);
		ck4.next();
		String sid = ck4.getString("seller_id");

		String sql5 = "insert into order_items(order_id, order_item_id, product_id, seller_id, price) values ('" + Tid + "','1','"
				+ pid + "','" + sid + "','" + totalPrice + "')";
				//s.executeUpdate(sql5);	
		try {
			s.executeUpdate(sql5);
			//conn.commit();
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cMain.jsp'>...Return(sql5 error)</a>");
			return;
		}

		String sql6 = "insert into orders(order_id, customer_id, order_status, order_purchase_timestamp) values ('"
				+ Tid + "','" + ucid + "','paid','" + date3 + "')";
				//s.executeUpdate(sql6);
		try {
			s.executeUpdate(sql6);
			//conn.commit();
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cMain.jsp'>...Return(sql6 error)</a>");
			return;
		}

		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zip = request.getParameter("zip");
		
		s.close();
		conn.close();
	%>

	<div class="site-nav-bg">
		<div class="site-nav w1200">
			<p class="sn-back-home">
				<i class="layui-icon layui-icon-home"></i> <a href="cMain.jsp">Main</a>
			</p>
			<div class="sn-quick-menu">
				<div class="login">
					<a href="#">Welcome_<%=cid%></a>
				</div>
				<div class="sp-cart">
					<a href="#">Shopping_Cart</a>&nbsp; &nbsp;
				</div>
				<div class="login">
					<a href="index.jsp">Exit</a>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 text-center">.</div>
		<div class="col-md-4 text-center"
			style="background-color:rgba(0,0,0,0.1);">
			<h2>Order Details</h2>
			<h4>OrderID:&nbsp;<%=Tid%></h4>
			<h4>Customer:&nbsp;<%=cid%></h4>
			<h4>Seller:&nbsp;<%=sid%></h4>
			<h4>Product:&nbsp;<%=pid%></h4>
			<h4>Quantity:&nbsp;<%=quantity%></h4>
			<h4>TotalPrice:&nbsp;<%=totalPrice%></h4>
			<h4>Payment:&nbsp;<%=payment%></h4>
			<h4>Address:&nbsp;<%=city%>,&nbsp;<%=state %>,&nbsp;<%=zip %></h4>
			<a href="cMain.jsp"><h4 class="btn btn-success">Back to Home</h4></a>
						
			</div>
		<div class="col-md-4 text-center">.</div>
	</div>
</body>
</html>
