package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.user;
import dao.loginD;

public class loginS extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("uname");
		String pwd=request.getParameter("upwd");
		user person=new user(name,pwd);
		loginD login=new loginD();
		int num=login.login(person);
		if(num>0)
		{
			response.sendRedirect("cMain.jsp");
		}else if(num==0)
		{
			response.sendRedirect("index.jsp");
		}
		else if(num<0)
		{
			response.sendRedirect("index.jsp");
		}
		System.out.println(num);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
