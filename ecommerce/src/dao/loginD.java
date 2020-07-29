package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import bean.user;

public class loginD
{
	public int login(user person)
	{
		   String driver = "com.mysql.jdbc.Driver";
	       String url = "jdbc:mysql://localhost:8889/ecommerce";
	       String username = "root";
	       String password = "root";
	       Connection connection = null;
	       PreparedStatement pstmt=null;
	       ResultSet rs=null;
	       
	       
		try
		{
			Class.forName(driver);
			connection=DriverManager.getConnection(url,username,password);
			if(!connection.isClosed())
	        {System.out.print("successfully connected");}
			String sql="select * from user where uid = ? and upwd=?";
			pstmt=connection.prepareStatement(sql);
			pstmt.setString(1, person.getName());
			pstmt.setString(2, person.getPassword());
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				return 1;
			}
			else if(rs.next()==false)
			{
				return 0;
			}
			
		}catch(ClassNotFoundException e)
		{
			e.printStackTrace();
			return -1;
		}catch(SQLException e)
		{
			e.printStackTrace();
			return -1;
		}finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(pstmt!=null)
				{
					pstmt.close();
				}
				if(connection!=null)
				{
					connection.close();
				}
			}catch(SQLException e)
			{
				e.printStackTrace();
				return -1;
			}catch(Exception e) {
				e.printStackTrace();
				return -1;
			}
		}
		return 0;
	}
}