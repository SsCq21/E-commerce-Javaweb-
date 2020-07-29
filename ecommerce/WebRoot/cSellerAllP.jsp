<%@ page language="java" import="java.util.*" import="java.sql.*"
	pageEncoding="UTF-8"%>
<%@ page import="bean.Product"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>cSellerAllProducts</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="res/static/css/main.css">
<link rel="stylesheet" type="text/css" href="res/layui/css/layui.css">
<script type="text/javascript" src="res/layui/layui.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

</head>

<body style="background: url(IMG/CM.jpg);background-size:cover">
	<%
		String Cid = (String) session.getAttribute("userid");
		String ucsid = (String) session.getAttribute("ucsid");
		String sid = request.getParameter("index");

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");

		Statement s = conn.createStatement();
	%>

	<div class="site-nav-bg">
		<div class="site-nav w1200">
			<p class="sn-back-home">
				<i class="layui-icon layui-icon-home"></i> <a href="cMain.jsp">Main</a>
			</p>
			<div class="sn-quick-menu">
				<div class="login">
					<a href="personal.jsp">Welcome_<%=Cid%></a>
				</div>
				<div class="sp-cart">
					<a href="cShoppingCart.jsp">Shopping_Cart&nbsp;</a>
				</div>
				<div class="sp-cart">
					<a href="cOrder.jsp">Orders&nbsp;</a>
				</div>
				<div class="login">
					<a href="index.jsp">Exit</a>
				</div>
			</div>
		</div>
	</div>



	<div class="header">
		<div class="headerLayout w1200">
			<div class="headerCon">
				<h1 class="mallLogo">
					<a href="#" title="cMain"> <img src="">
					</a>
				</h1>
				<div class="mallSearch">
					<form action="" class="layui-form" novalidate>
						<input type="text" name="title" required lay-verify="required"
							autocomplete="off" class="layui-input" placeholder="search">
						<button class="layui-btn" lay-submit lay-filter="formDemo">
							<i class="layui-icon layui-icon-search"></i>
						</button>
						<input type="hidden" name="" value="">
					</form>
				</div>
			</div>
		</div>
	</div>


	<div class="content content-nav-base commodity-content">
		<div class="main-nav">
			<div class="inner-cont0">
				<div class="inner-cont1 w1200">
					<div class="inner-cont2">
						<a href="#" class="active">All</a> <a href="#">Sales</a> <a
							href="#">News</a> <a href="#">About</a>
					</div>
				</div>
			</div>
		</div>
		<%
		String sql3 = "select seller_zip_code_prefix, seller_city, seller_state from sellers where seller_id='"
					+ sid + "'";
			ResultSet ck3 = s.executeQuery(sql3);
			ck3.next();
			String zip = ck3.getString("seller_zip_code_prefix");
			String city = ck3.getString("seller_city");
			String state = ck3.getString("seller_state");
		 %>
		<div class="commod-cont-wrap">
			<div class="commod-cont w1200 layui-clear">
				<div class="left-nav">
					<div class="title">Seller</div>
					<h4>ID:&nbsp;<%=sid%></h4>
					<h4>City:&nbsp;<%=city%></h4>
					<h4>State:&nbsp;<%=state%></h4>
					<h4>Zip:&nbsp;<%=zip%></h4>
						
				</div>

				<div class="right-cont-wrap">
					<div class="right-cont">
						<div class="sort layui-clear">
							<a class="active" href="javascript:;" event='volume'>default</a>
							<a href="javascript:;" event='price'>Price</a> <a
								href="javascript:;" event=''>New</a> <a href="javascript:;"
								event=''></a>
						</div>
						<div class="prod-number">
							<span>200</span>
						</div>
						<div class="cont-list layui-clear" id="list-cont">
							<%
								String sql = "select distinct products.product_id,product_category_name,product_price from products, product_seller where products.product_id=product_seller.product_id and product_seller.seller_id='"
										+ sid + "'";
								ResultSet ck = s.executeQuery(sql);

								int i = 0;
								ArrayList productlist = new ArrayList();
								while (ck.next()) {
									String pid = ck.getString("product_id");
									String typ = ck.getString("product_category_name");
									double price = ck.getDouble("product_price");
									Product p = new Product();
									p.setPid(pid);
									p.settype(typ);
									p.setprice(price);
									p.setvalue(price);
									p.setamount(1);
									productlist.add(i, p);
							%>
							<div class="item">
								<div class="img">
									<a href="cItem.jsp?index=<%=pid%>&index2=<%=i%>"><img
										height=300 width=280 src="IMG/product/<%=pid%>.jpg"></a>
								</div>
								<div class="text">
									<p class="title"><%=pid%></p>
									<p class="price">
										<span class="pri">Price</span> <span class="nub"><font color="red"><%=price%></font>
											_</span>
									</p>
								</div>
							</div>
							<%
								i = i + 1;
								}
								session.setAttribute("productlist", productlist);

								s.close();
								conn.close();
							%>


						</div>

						<div id="demo0" style="text-align: center;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	
		layui.config({
			base : '../res/static/js/util/'
		}).use([ 'mm', 'laypage', 'jquery' ], function() {
			var laypage = layui.laypage,
				$ = layui.$,
				mm = layui.mm;
			laypage.render({
				elem : 'demo0',
				count : 100
			});
	
			$('.sort a').on('click', function() {
				$(this).addClass('active').siblings().removeClass('active');
			})
			$('.list-box dt').on('click', function() {
				if ($(this).attr('off')) {
					$(this).removeClass('active').siblings('dd').show()
					$(this).attr('off', '')
				} else {
					$(this).addClass('active').siblings('dd').hide()
					$(this).attr('off', true)
				}
			})
	
		});
	</script>
</body>
</html>
