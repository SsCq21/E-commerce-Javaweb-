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

<title>cMain</title>

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
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		}

		String url = "jdbc:mysql://localhost:8889/ecommerce";
		Connection conn = DriverManager.getConnection(url, "root", "root");
		String Cid = (String) session.getAttribute("userid");
		
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
					<form action="cSearch.jsp" class="layui-form" novalidate>
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
		<div class="commod-cont-wrap">
			<div class="commod-cont w1200 layui-clear">
				<div class="left-nav">
					<div class="title">All Product</div>
					<div class="list-box">
						<dl>
							<dt>Daily</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=perfumaria">Perfumaria</a>
							</dd>
							<dd>
								<a href="cTypeSearch.jsp?index=beleza_saude">Beleza_Saude</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating..</a>
							</dd>
						</dl>
						<dl>
							<dt>Auto</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=automotivo">Automotivo</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating..</a>
							</dd>
						</dl>
						<dl>
							<dt>Furniture</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=cama_mesa_banho">Cama_Mesa_Banho</a></dd>
								<dd><a href="cTypeSearch.jsp?index=utilidades_domesticas">Utilidades_Domesticas</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
						<dl>
							<dt>Electronic</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=relogios_presentes">Relogios_Presentes</a>
							</dd>
							<dd>
								<a href="cTypeSearch.jsp?index=consoles_games">Consoles_Games</a>
							</dd>
							<dd>
								<a href="cTypeSearch.jsp?index=moveis_decoracao">Moveis_Decoracao</a>
							</dd>
							<dd>
								<a href="cTypeSearch.jsp?index=informatica_acessorios">Informatica_Acessorios</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
						<dl>
							<dt>Food</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=cool_stuff">Cool_Stuff</a>
							</dd>
							<dd>
								<a href="cTypeSearch.jsp?index=esporte_lazer">Esporte_Lazer</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
						<dl>
							<dt>Clothes</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=fashion_calcados">Fashion_Calcados</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
						<dl>
							<dt>Toys</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=brinquedos">Brinquedos</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
						<dl>
							<dt>Tools</dt>
							<dd>
								<a href="cTypeSearch.jsp?index=ferramentas_jardim">Ferramentas_Jardim</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
						<dl>
							<dt>Pet</dt>
							<dd>
								<a href="cTypeSearch.jsp?pet_shop">Pet_Shop</a>
							</dd>
							<dd>
								<a href="javascript:;">Updating...</a>
							</dd>
						</dl>
					</div>
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
								

								String sql = "select product_id,product_category_name,product_price from products";
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
									<a href="cItem.jsp?index=<%=pid%>&index2=<%=i%>"><img height=300
										width=280 src="IMG/product/<%=pid%>.jpg"></a>
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
						<!-- 模版引擎导入 -->
						<!-- <script type="text/html" id="demo">
              {{# layui.each(d.menu.milk.content,function(index,item){}}    
                <div class="item">
                  <div class="img">
                    <a href="javascript:;"><img src="{{item.img}}"></a>
                  </div>
                  <div class="text">
                    <p class="title"></p>
                    <p class="price">
                      <span class="pri">{{item.pri}}</span>
                      <span class="nub">{{item.nub}}</span>
                    </p>
                  </div>
                </div>
              {{# }); }}
            </script> -->
						<div id="demo0" style="text-align: center;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	
		layui.config({
			base : '../res/static/js/util/' //存放新模块的目录，(不是layui的模块目录
		}).use([ 'mm', 'laypage', 'jquery' ], function() {
			var laypage = layui.laypage,
				$ = layui.$,
				mm = layui.mm;
			laypage.render({
				elem : 'demo0',
				count : 100 //数据总数
			});
	
	
		
			//  var html = demo.innerHTML;
			//  var listCont = document.getElementById('list-cont');
			//  // console.log(layui.router("#/about.html"))
			// mm.request({
			//     url: '../json/commodity.json',
			//     success : function(res){
			//       console.log(res)
			//       listCont.innerHTML = mm.renderHtml(html,res)
			//     },
			//     error: function(res){
			//       console.log(res);
			//     }
			//   })
	
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
