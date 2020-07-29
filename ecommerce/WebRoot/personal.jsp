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

<title>personal</title>

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
		var upassword = document.getElementById("upwd").value;
		if (upassword == "") {
			alert("Password cannot be null！");
			return false;
		}
		if (!confirm("Confirm to submit the personal profile change？")) {
			window.event.returnValue = false;
		}
	}
</script>

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">

	<%
		String id = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String type = (String) session.getAttribute("type");

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql = "select upwd from user where uid='" + id + "'";
		ResultSet ck = s.executeQuery(sql);
		ck.next();
		String upwd = ck.getString("upwd");
		String zip = null;
		String city = null;
		String state = null;

		if (type.equals("customer")) {
			String sql2 = "select customer_zip_code_prefix, customer_city, customer_state from customers where customer_id='"
					+ ucsid + "'";
			ResultSet ck2 = s.executeQuery(sql2);
			ck2.next();
			zip = ck2.getString("customer_zip_code_prefix");
			city = ck2.getString("customer_city");
			state = ck2.getString("customer_state");
		}

		else if (type.equals("seller")) {
			String sql3 = "select seller_zip_code_prefix, seller_city, seller_state from sellers where seller_id='"
					+ ucsid + "'";
			ResultSet ck3 = s.executeQuery(sql3);
			ck3.next();
			zip = ck3.getString("seller_zip_code_prefix");
			city = ck3.getString("seller_city");
			state = ck3.getString("seller_state");
		}

		s.close();
		conn.close();
	%>
	<div>
	<%
	if(type.equals("customer")) {
	 %>
		<h4>
			&nbsp;<a href="cMain.jsp">HOME</a>
		</h4>
		<%} else {%>
		<h4>
			&nbsp;<a href="sMain.jsp">HOME</a>
		</h4>
		<%} %>
	</div>
	<br>
	<div class="text-center">
		<h1>Personal</h1>
	</div>

	<div class="row">

		<div class="col-md-3 text-center">.</div>
		<div class="col-md-6 text-center">
			<h4>
				ICON: <img border=0 height=100 src="IMG/Touxiang.jpg">
			</h4><br>

			<form action="personalChange.jsp" method="post" onsubmit="return del()">
				<h4>
					Username:&nbsp;<%=id%></h4>
				<h4>
					Password:&nbsp;<input style="width:200px" type="text" id="upwd"
						name="upwd" placeholder="Password">
				</h4>
				<h4>
					Zip:&nbsp;<input style="width:100px" type="text" id="zip"
						name="upwd" value="<%=zip%>">
				</h4>
				<h4>
					City:&nbsp;<input style="width:200px" type="text" id="city"
						name="city" value="<%=city%>">
				</h4>
				<h4>
					State:&nbsp;<input style="width:200px" type="text" id="state"
						name="state" value="<%=state%>">
				</h4>
				<input class="btn btn-primary" type="submit" value="Submit">

			</form>
		</div>
		<div class="col-md-3 text-center">.</div>

	</div>

</body>
</html>
