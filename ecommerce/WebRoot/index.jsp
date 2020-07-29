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

<title>index</title>
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

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

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
	<div class="text-center">
		<h1 style="text-align:center">LOGO</h1>
	</div>

	<p style="margin:80px"></p>


	<div class="row" style="margin-top:30px;">
		<div class="col-md-4 text-center">.</div>
		<div class="col-md-4 text-center"
			style="background-color:rgba(0,50,0,0.1);">
			<table border=0 width=100%>
				<tr>

					<form action="loginJudge.jsp" method="post"
						onsubmit="return check()">
						<table border="0" width=100%>
							<tr>
								<td align="center"><h3>Username:</h3></td>
								<td><input type="text" id="uname" name="uname"
									style="width: 180px" /></td>
							</tr>
							<tr>
								<td align="center"><h3>Password:</h3></td>
								<td><input type="password" id="upwd" name="upwd"
									style="width: 180px" /></td>
							</tr>
							<tr>
								<td align="center"><input class="btn btn-primary"
									type="submit" value="login" /></td>
								<td><input class="btn btn-danger" type="reset"
									value="reset" /></td>
							 <td><a href="register.jsp"><h4 class="btn btn-info">Register</h4></a></td>
							</tr>

						</table>
					</form>
				</tr>
			</table>
			
		</div>
		<div class="col-md-4 text-center">.</div>
	</div>
</body>
</html>
