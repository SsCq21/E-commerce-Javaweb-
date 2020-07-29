<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>cCommented</title>

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
<script defer
	src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="stylesheet" type="text/css" href="res/static/css/reviews.css">

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<%
		String cid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String oid = request.getParameter("index");
	%>
	<div>

		&nbsp;<a href="cMain.jsp">HOME</a> &nbsp;<a href="#">Welcome_<%=cid%></a>

		&nbsp;<a href="#">Shopping_Cart</a> &nbsp;<a href="cOrder.jsp">Order</a>


		&nbsp;<a href="index.jsp">Exit</a>

	</div>

	<p style="margin:20px"></p>
	<div class="text-center">
		<h2>Comment submitted successfully!^_^</h2>
	</div>

	<%
		String title = request.getParameter("title");
		String score2 = request.getParameter("score");
		int score = Integer.parseInt(score2);
		String review = request.getParameter("review");

		java.util.Date date = new java.util.Date();
		String date2 = date.toString();
		String date3 = new SimpleDateFormat("yyyy-MM-dd").format(date);

		String reviewdate = new SimpleDateFormat("yyyyMMdd").format(date);
		String rid = reviewdate + cid + oid;

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();

		String sql = "Insert into order_reviews(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date) values ('"
				+ rid + "','" + oid + "','" + score + "','" + title + "','" + review + "','" + date3 + "')";
		try {
			s.executeUpdate(sql);
		} catch (SQLException e) {
			out.println(e);
			out.println("<a href='cOrder.jsp'>...Return(sql error)</a>");
			return;
		}

		s.close();
		conn.close();
	%>
	<div class="comments">
		<div class="comment-wrap">
			<div class="photo">
				<div class="avatar"
					style="background-image: url('IMG/Touxiang.jpg')"></div>
			</div>
			<div class="comment-block">
				<p class="comment-text">
					<%
						if (title.equals("")) {
					%>
				
				<h3>
					<font color="grey">Default Title</font>
				</h3>
				<%
					} else {
				%>
				<h3><%=title%></h3>

				<%
					}
				%>
				<br>
				<h4>
					<font color="red">Score:</font>
					<%
						int m = 0;
						while (m < score) {
					%>
					<span class="fa fa-star checked"></span>
					<%
						m = m + 1;
						}
					%>
				</h4>
				<br>
				<%
					if (review.equals("")) {
				%>
				<h4>This user did not fill in the review...</h4>
				<%
					} else {
				%>
				<h4><%=review%></h4>
				<%
					}
				%>

				<br>

				<div class="bottom-comment">
					<div class="comment-date"><%=date3%></div>
					<ul class="comment-actions">
						<li class="reply">CustomerID:<%=cid%></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<br>
	<div class="text-center">
		<a href="cOrder.jsp">Back to Order</a>
	</div>
</body>
</html>
