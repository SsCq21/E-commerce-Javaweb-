package bean;

import java.sql.*;

public class DB {
	
	private Connection conn=null;
	private Statement stmt=null;
	
	public DB() {
		try {
      	  Class.forName("com.mysql.jdbc.Driver");
      	  conn=DriverManager.getConnection("jdbc:mysql://localhost:8889/ecommerce","root","root");
      	  stmt=conn.createStatement();
        } 
	catch (Exception ex) {
      	  System.err.println(ex.getMessage());;
        } 

	}
	public int executeUpdate(String sql)
	{
		int result=0;
		try {result=stmt.executeUpdate(sql);}
		catch(Exception ex)	{System.err.println(ex.getMessage());}
		return result;
	}
	public ResultSet executeQuery(String sql)
	{
		ResultSet rs=null;
		try{rs=stmt.executeQuery(sql);}
		catch(Exception ex)
		{System.err.println(ex.getMessage());} 
		return rs;
	}
	public void close()
	{
		try {
			stmt.close();
			conn.close();
		}
		catch(SQLException ex)
		{System.err.println(ex.getMessage());} 
	}


}
