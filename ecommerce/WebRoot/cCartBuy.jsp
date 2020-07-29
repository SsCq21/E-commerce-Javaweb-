<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="bean.Product"%>
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

<title>cCartBuy</title>

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
	<div class="text-center">
		<h1>Cart_Buy_Order</h1>
	</div>
	<br>

	<%
		ArrayList buylist = car.getBuylist();
		double total = 0;
	%>
	<div class="row">
		<div class="col-md-1 text-center">.</div>
		<div class="col-md-10 text-center">
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
					if (buylist == null | buylist.size() == 0) {
				%>
				<tr height="100">
					<td colspan="5" align="center"><font color="grey">Shopping
							Cart is null！</td>
				</tr>
				<%
					} else {
						for (int i = 0; i < buylist.size(); i++) {
							Product product = new Product();
							product = (Product) buylist.get(i);
							String pid = product.getPid();
							double price = product.getprice();
							int num = product.getamount();
							double value = price * num;
							total += value;
							session.setAttribute("total",total);
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
					}
				%>

			</table>

			<h4>
				Total:&nbsp;<font color="red">$<%=total%></font>
			</h4>
			<h4>
				Username:&nbsp;<%=cid%></h4>
			<%
				try {
					Class.forName("com.mysql.jdbc.Driver");
				} catch (ClassNotFoundException e) {
				}

				String url = "jdbc:mysql://localhost:8889/ecommerce";
				Connection conn = DriverManager.getConnection(url, "root", "root");

				Statement s = conn.createStatement();

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
			<form method="POST" action="cCartTrans.jsp" onsubmit="return check()">
				<h4>
					City:&nbsp;<input style="width:200px" type="text" id="city"
						name="city" size="10" value="<%=city%>">
				</h4>
				<h4>
					State:&nbsp;<input style="width:200px" type="text" id="state"
						name="state" size="10" value="<%=state%>">
				</h4>
				<h4>
					Zip:&nbsp;<input style="width:100px" type="text" id="zip"
						name="zip" size="10" value="<%=zip%>">
				</h4>
				<h4>
					Payment: &nbsp;<input type="radio" name="payment"
						value="credit_card">Credit_Card&nbsp;&nbsp; <input
						type="radio" name="payment" value="beleto">Boleto&nbsp;&nbsp;
					<input type="radio" name="payment" value="voucher">Voucher
				</h4>
				<input class="btn btn-success" type=submit value="Submit">
			</form>
		</div>

		<div class="col-md-1">.</div>
	</div>
</body>
</html>
