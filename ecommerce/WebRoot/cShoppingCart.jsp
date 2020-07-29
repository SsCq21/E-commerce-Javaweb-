<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="bean.Product" import="java.sql.*"%>
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

<title>cShoppingCart</title>

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
	<div class="text-center">
		<h1>Shopping Cart</h1>
	</div>
	<br>

	<%
		ArrayList buylist = car.getBuylist();
		float total = 0;
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
						<td align="center"></td>
					</tr>
				</thead>
				<%
					if (buylist == null | buylist.size() == 0) {
				%>
				<tr height="100">
					<td colspan="6" align="center"><h3><font color="grey">Shopping
							Cart is null！ </h3></td>
				</tr>
				<tr height="100">
					<td colspan="6" align="center"><a href="cMain.jsp"><h
								class="btn btn-success">Back to Shop</h></a></td>
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
							//product.setvalue(value);
							total += value;
				%>



				<tbody>
					<tr>
						<td align="center"><%=pid%></td>
						<td align="center"><img border=0 height=100
							src="IMG/product/<%=pid%>.jpg"></td>
						<td align="center">$<%=price%></td>
						<td align="center"><a
							href="cAccessCar.jsp?action=addone&name=<%=pid%>"><h
									class="btn btn-info">+</h></a> <input style="width:30px"
							type="text" name="num" value="<%=num%>" readonly> <a
							href="cAccessCar.jsp?action=remove&name=<%=pid%>"><h
									class="btn btn-info">-</h></a></td>
						<td align="center"><font color="red">$<%=value%></font></td>
						<td align="center"><a
							href="cAccessCar.jsp?action=removethis&name=<%=pid%>"><h
									class="btn btn-warning">X</h></a></td>
					</tr>
				</tbody>
				<%
					}
				%>

			</table>
		</div>
		<div class="col-md-1 text-center">.</div>
	</div>

	<div class="row">
		<div class="col-md-2">.</div>
		<div class="col-md-8">
			<div class="text-right">
				<h4>
					Total:<font color="red">$<%=total%></font>
				</h4>
			</div>
			<div class="text-center">
				<h4>
					<a href="cCartBuy.jsp"><h class="btn btn-success">Buy</h></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
						href="cAccessCar.jsp?action=clear"><h class="btn btn-danger">Clear</h></a>
				</h4>
			</div>
			<%
				}
			%>
		</div>
		<div class="col-md-2">.</div>
	</div>
</body>
</html>
