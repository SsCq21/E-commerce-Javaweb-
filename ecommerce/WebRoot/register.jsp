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

<title>Register</title>

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
		var uname = document.getElementById("uname").value;
		var upassword = document.getElementById("upwd").value;
		if (uname == "") {
			alert("Username cannot be null！");
			return false;
		}
		if (upassword == "") {
			alert("Password cannot be null！");
			return false;
		}
	}
</script>

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<h4>
		&nbsp;&nbsp;<a href="index.jsp">Login</a>
	</h4>
	<div class="text-center">
		<h1>Register</h1>
	</div>

	<div class="text-center">
		<form action="registerJudge.jsp" method="post" onsubmit="return check()">
			<h4>
				Username:&nbsp;&nbsp;<input style="width:200px" type="text" id="uname"
					name="uname" placeholder="Username">
			</h4>
			<h4>
				Password:&nbsp;&nbsp;<input style="width:200px" type="text" id="upwd"
					name="upwd" placeholder="Password">
			</h4>
			<h4>
				Zip:&nbsp;&nbsp;<input style="width:150px" type="text" id="zip" name="zip"
					placeholder="Zip">
			</h4>
			<h4>
				City:&nbsp;&nbsp;<input style="width:200px" type="text" id="city" name="city"
					placeholder="City">
			</h4>
			<h4>
				State:&nbsp;&nbsp;<input style="width:200px" type="text" id="state" name="state"
					placeholder="State">
			</h4>
			<h4>
				Type:&nbsp;&nbsp; <select style="width:150px" id="type" name="type">
					<option value="customer">Customer</option>
					<option value="seller">Seller</option>
				</select>
			</h4>


			<input class="btn btn-primary" type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="btn btn-info" type="reset" value="Reset">
		</form>
	</div>


</body>
</html>
