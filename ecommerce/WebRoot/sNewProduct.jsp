<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>sNewProduct</title>

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
		var uname = document.getElementById("pname").value;
		var price = document.getElementById("price").value;
		if (pname == "") {
			alert("Product_name cannot be null！");
			return false;
		}
		if (price == "") {
			alert("Price cannot be null！");
			return false;
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

	<div class="text-center">
		<h1>New Product</h1>
	</div>

	<div class="text-center">
		<form action="sNewProductChange.jsp" method="post"
			onsubmit="return check()">
			<h4>
				Name:&nbsp;&nbsp;<input style="width:200px" type="text"
					id="pname" name="pname" placeholder="name">
			</h4>
			<h4>
				Category:&nbsp;&nbsp; <select style="width:200px" id="category" name="category">
					<option value="perfumaria">perfumaria</option>
					<option value="automotivo">automotivo</option>
					<option value="cama_mesa_banho">cama_mesa_banho</option>
					<option value="utilidades_domesticas">utilidades_domesticas</option>
					<option value="relogios_presentes">relogios_presentes</option>
					<option value="cool_stuff">cool_stuff</option>
					<option value="consoles_games">consoles_games</option>
					<option value="cama_mesa_banho">cama_mesa_banho</option>
					<option value="moveis_decoracao">moveis_decoracao</option>
					<option value="beleza_saude">beleza_saude</option>
					<option value="fashion_calcados">fashion_calcados</option>
					<option value="informatica_acessorios">informatica_acessorios</option>
					<option value="brinquedos">brinquedos</option>
					<option value="pet_shop">pet_shop</option>
					<option value="esporte_lazer">esporte_lazer</option>
					<option value="ferramentas_jardim">ferramentas_jardim</option>
					<option value="moveis_sala">moveis_sala</option>
					<option value="construcao_ferramentas_construcao">construcao_ferramentas_construcao</option>
				</select>
			</h4>
			
			<h4>
				Price:&nbsp;&nbsp;$<input style="width:100px" type="text" id="price"
					name="price" placeholder="price">
			</h4>
			<h4>
				Weight:&nbsp;&nbsp;<input style="width:100px" type="text" id="weight"
					name="weight" placeholder="weight">g
			</h4><h4>
				Length:&nbsp;&nbsp;<input style="width:100px" type="text" id="length"
					name="length" placeholder="length">cm
			</h4><h4>
				Width:&nbsp;&nbsp;<input style="width:100px" type="text" id="width"
					name="width" placeholder="width">cm
			</h4><h4>
				Height:&nbsp;&nbsp;<input style="width:100px" type="text" id="height"
					name="height" placeholder="height">cm
			</h4>
			


			<input class="btn btn-primary" type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="btn btn-info" type="reset" value="Reset">
		</form>
	</div>


</body>
</html>
