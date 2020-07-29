<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%@ page import="bean.Product"%>
<%@ page import="bean.Review"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<jsp:useBean id="tool" class="bean.MyTools" scope="page" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>cItem</title>

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
<style>
div.immg {
	max-width: 150px;
	max-height: 200px;
}
</style>
</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<%
		String Cid = (String) session.getAttribute("userid");
	%>
	<div class="site-nav-bg">
		<div class="site-nav w1200">
			<p class="sn-back-home">
				<i class="layui-icon layui-icon-home"></i> <a href="cMain.jsp">Main</a>
			</p>
			<div class="sn-quick-menu">
				<div class="login">
					<a href="personal.jsp">Welcome_<%=Cid%></a>&nbsp;
				</div>
				<div class="sp-cart">
					<a href="cShoppingCart.jsp">Shopping_Cart</a>&nbsp;
				</div>
				<div class="sp-cart">
					<a href="cOrder.jsp">Order</a>&nbsp;
				</div>
				<div class="login">
					<a href="index.jsp">Exit</a>&nbsp;
				</div>
			</div>
		</div>
	</div>

	<div class="header">
		<div class="headerLayout w1200">
			<div class="headerCon">
				<h1 class="mallLogo">
					<a href="#" title="LOGO">LOGO </a>
				</h1>
				<div class="mallSearch">
					<form action="" class="layui-form" novalidate>
						<input type="text" name="title" required lay-verify="required"
							autocomplete="off" class="layui-input" placeholder="请输入需要的商品">
						<button class="layui-btn" lay-submit lay-filter="formDemo">
							<i class="layui-icon layui-icon-search"></i>
						</button>
						<input type="hidden" name="" value="">
					</form>
				</div>
			</div>
		</div>
	</div>


	<div class="content content-nav-base datails-content">
		<div class="main-nav">
			<div class="inner-cont0">
				<div class="inner-cont1 w1200">
					<div class="inner-cont2">
						<a href="cMain.jsp" class="active">All</a> <a href="#">Sales</a> <a
							href="#">News</a> <a href="#">About</a>
					</div>
				</div>
			</div>
		</div>
		<div class="data-cont-wrap w1200">
			<div class="crumb">
				<a href="javascript:;">Index</a> <span>></span> <a href="cMain.jsp">Main</a>
				<span>></span> <a href="javascript:;">Details</a>
			</div>

			<%
				String pid = request.getParameter("index");
				 int i=tool.strToint(request.getParameter("index2"));

				try {
					Class.forName("com.mysql.jdbc.Driver");
				} catch (ClassNotFoundException e) {
				}

				String url = "jdbc:mysql://localhost:8889/ecommerce";
				Connection conn = DriverManager.getConnection(url, "root", "root");

				Statement s = conn.createStatement();

				String sql = "select product_price, product_category_name,product_weight_g, product_length_cm, product_height_cm,product_width_cm from products where product_id='"
						+ pid + "'";
				ResultSet ck = s.executeQuery(sql);
				ck.next();
				String price = ck.getString("product_price");
				String category = ck.getString("product_category_name");
				String weight = ck.getString("product_weight_g");
				String length = ck.getString("product_length_cm");
				String height = ck.getString("product_height_cm");
				String width = ck.getString("product_width_cm");

				String sql3 = "select seller_id from product_seller where product_id='" + pid + "'";
				ResultSet ck3 = s.executeQuery(sql3);
				ck3.next();
				String sid = ck3.getString("seller_id");

				String sql4 = "select seller_city, seller_state from sellers where seller_id ='" + sid + "'";
				ResultSet ck4 = s.executeQuery(sql4);
				ck4.next();
				String scity = ck4.getString("seller_city");
				String sstate = ck4.getString("seller_state");
			%>
			<div class="product-intro layui-clear">
				<div class="preview-wrap">
					<img width=400 height=300 src="IMG/product/<%=pid%>.jpg">
				</div>
				<div class="itemInfo-wrap">
					<div class="itemInfo">
						<div class="title">
							<h4><%=pid%></h4>

						</div>
						<div class="summary">

							<p class="activity">
								<span>Price:</span><strong class="price"><i>$</i><%=price%></strong>

							</p>
						</div>
						<div class="choose-attrs">
							<div class="number layui-clear">
								<h5>
									Category:&nbsp;&nbsp;&nbsp;&nbsp;<%=category%></h5>
								<h5>
									Weight:&nbsp;&nbsp;&nbsp;&nbsp;<%=weight%></h5>
								<h5>
									Length:&nbsp;&nbsp;&nbsp;&nbsp;<%=length%></h5>
								<h5>
									Width:&nbsp;&nbsp;&nbsp;&nbsp;<%=width%></h5>
								<h5>
									Height:&nbsp;&nbsp;&nbsp;&nbsp;<%=height%></h5>

							</div>
						</div>
						<div class="choose-btns">
							<a href="cBuy.jsp?index=<%=pid%>"><button
									class="layui-btn layui-btn-primary purchase-btn">Buy</button></a>
							<a href="cAccessCar.jsp?action=add&index=<%=i%>"><button class="layui-btn  layui-btn-danger car-btn">
								<i class="layui-icon layui-icon-cart-simple"></i>Add to Cart
							</button></a>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
	<hr>
	<div class="row" style="margin-top:10px;">
		<div class="col-md-2 text-center">.</div>
		<div class="col-md-8 text-center">
			<h2>Details</h2>
			<br>
			<div class="item">
				<h4>
					Product:&nbsp;&nbsp;&nbsp;&nbsp;<%=pid%></h4>
				<h4>
					Category:&nbsp;&nbsp;&nbsp;&nbsp;<%=category%></h4>
				<h4>
					Weight:&nbsp;&nbsp;&nbsp;&nbsp;<%=weight%></h4>
				<h4>
					Length:&nbsp;&nbsp;<%=length%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Width:&nbsp;&nbsp;<%=width%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Height:&nbsp;&nbsp;<%=height%></h4>
				<h4>
					Seller:&nbsp;&nbsp;&nbsp;&nbsp;<a href="cSellerAllP.jsp?index=<%=sid%>"><font color="blue"><%=sid%></font></a></h4>
				<h4>
					Seller Address:&nbsp;&nbsp;&nbsp;&nbsp;<%=scity%>,&nbsp;&nbsp;
					<%=sstate%></h4>
				<br> <img src="IMG/product/<%=pid%>.jpg"> <br> <br>
			</div>
			<hr>
			<div class="comments">
				<h2>Reviews</h2>
				<br> <br>
				<%
					String sql2 = "SELECT customer_id, review_comment_title, review_comment_message,review_creation_date,review_score FROM order_reviews, order_items,orders where order_reviews.order_id = order_items.order_id and order_reviews.order_id=orders.order_id and order_items.product_id ='"
							+ pid + "'";
					ResultSet ck2 = s.executeQuery(sql2);

					int i2 = 0;
					while (ck2.next()) {
						String customerID = ck2.getString("customer_id");
						String title = ck2.getString("review_comment_title");
						String message = ck2.getString("review_comment_message");
						String createDate = ck2.getString("review_creation_date");
						int score = ck2.getInt("review_score");
						//Review r = new Review();
						//r.setCustomerID(customerID);
						//r.setCreateDate(createDate);
						//r.setTitle(title);
						//r.setMessage(message);
						//r.setScore(score);
				%>

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
							if (message.equals("")) {
						%>
						<h4>This user did not fill in the review...</h4>
						<%
							} else {
						%>
						<h4><%=message%></h4>
						<%
							}
						%>

						<br>

						<div class="bottom-comment">
							<div class="comment-date"><%=createDate%></div>
							<ul class="comment-actions">
								<li class="reply"><%=customerID%></li>
							</ul>
						</div>
					</div>
				</div>
				<%
					i2 = i2 + 1;
					}
					s.close();
					conn.close();
				%>
			</div>

		</div>
		<div class="col-md-2 text-center">.</div>

	</div>









</body>
</html>
