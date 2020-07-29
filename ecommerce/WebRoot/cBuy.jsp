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

<title>cBuy</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

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
	
	<link rel="stylesheet" type="text/css" href="res/static/css/input.css">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

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

<script type="text/javascript">
	function check() {
		var zip = document.getElementById("zip").value;
		var city = document.getElementById("city").value;
		var state = document.getElementById("state").value;
		var payment = document.getElementById("payment").value;
		if (zip == "") {
			alert("Zip cannot be null！");
			return false;
		}
		if (city == "") {
			alert("City cannot be null！");
			return false;
		}
		if (state == "") {
			alert("State cannot be null！");
			return false;
		}
		if (payment == "") {
			alert("Please select the payment！");
			return false;
		}
		
		if (!confirm("Confirm to submit the Order？")) {
			window.event.returnValue = false;
		}
	}
</script>
</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<%
		String pid = request.getParameter("index");
		String cid = (String) session.getAttribute("userid");

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql = "select product_price from products";
		ResultSet ck = s.executeQuery(sql);
		ck.next();

		double price = ck.getDouble("product_price");
		int number = 1;
		double total = number * price;

		String sql2 = "select customer_zip_code_prefix, customer_city, customer_state from customers, user where customers.customer_id = user.ucsid and uid = '"
				+ cid + "'";
		ResultSet ck2 = s.executeQuery(sql2);
		ck2.next();

		String zip = ck2.getString("customer_zip_code_prefix");
		String city = ck2.getString("customer_city");
		String state = ck2.getString("customer_state");
		
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
					<a href="#">Shopping Cart</a>&nbsp; &nbsp;
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
			Buy Info
			<table width=100%>
				<tr>
					<td align="center"><h3>
							CustomerID:<%=" " + cid%></h3></td>
				</tr>
				<tr>
					<td align="center"><h3>
							Product Name:<%=" " + pid%></h3></td>
				</tr>
				<tr>
					<td align="center"><h3></h3></td>
				</tr>
				<tr>
					<td align="center"><img border=0 height=170
						src="IMG/product/<%=pid%>.jpg"></td>
				</tr>
				<tr>
					<td align="center">
						<h4>
							Price:&nbsp;$<input type="text" id="p" size="4" value="<%=price%>"
								readonly="readonly"
								style="border:none;background-color:transparent">
						</h4>
					</td>
				</tr>
				<tr>
					<td align="center">
						<form method="POST" action="cBuyTrans.jsp?index=<%=pid%>" onsubmit="return check()">
							<h4>
								Quantity:&nbsp;<input style="width:50px" type="text" id="number" name="number" size="5"
									value="1" oninput="changen()"
									onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
									onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
							</h4>
							<h4>
								<p id="demo">
									Total Price:&nbsp;<font color="red">$<%=" " + total%></font></p>
							</h4>
							<h4>
								City:&nbsp;<input style="width:200px" type="text" id="city" name="city" size="10"
									value="<%=city%>">
							</h4>
							<h4>
								State:&nbsp;<input style="width:200px" type="text" id="state" name="state" size="10"
									value="<%=state%>">
							</h4>
							<h4>
								Zip:&nbsp;<input style="width:100px" type="text" id="zip" name="zip" size="10"
									value="<%=zip%>">
							</h4>
							<h4>
								Payment: &nbsp;<input type="radio" name="payment" value="credit_card">Credit_Card&nbsp;&nbsp;
								<input type="radio" name="payment" value="beleto">Boleto&nbsp;&nbsp;
								<input type="radio" name="payment" value="voucher">Voucher
							</h4>

							<input class="btn btn-success" type=submit value="Submit">
						</form>
					</td>
				</tr>
			</table>


		</div>
		<div class="col-md-4 text-center">.</div>
	</div>
	<br>

	<script>
function changen() {
var n=document.getElementById("number").value;
var p=document.getElementById("p").value;
var total=n*p;
document.getElementById("demo").innerHTML="TotalPrice: "+total;
}

</script>
</body>
</html>
