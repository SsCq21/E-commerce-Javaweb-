package bean;

public class MyTools {
	public static int strToint(String str) {
		if(str==null||str.equals(""))
			str="0";
		int i=0;
		
		try { i=Integer.parseInt(str);		}
		catch(Exception ex) {
			System.out.println(ex.getMessage()); 
		}
		
		
		return i;
	}
	public static double strTodouble(String str) {
		if(str==null||str.equals(""))
			str="0";
		double i2=0.0;
		try { i2=Double.parseDouble(str);		}
		catch(Exception ex) {
			System.out.println(ex.getMessage()); 
		}
		return i2;
	}
	public static String toChinese(String str) {
		if(str==null) str="";
		try {
			byte a[]=str.getBytes("UTF-8");
			str=new String(a);
		}
		catch(Exception ex) {
			System.out.println(ex.getMessage()); 
		}
		return str;
	}


}
