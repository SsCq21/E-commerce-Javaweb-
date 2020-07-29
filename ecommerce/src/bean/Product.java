package bean;

public class Product {
	public Product() {
	}

	private String Pid;
	private String Pname;
	private int inventory;
	private int amount;
	private String type;
	private String image;
	private double price;
	private double value;
	private String salesperson;
	private int sale;
	private double profit;
	private int weight;

	private int Pquantity;

	public String getPid() {
		return Pid;
	}

	public void setPid(String Pid) {
		this.Pid = Pid;
	}

	public String getPname() {
		return Pname;
	}

	public void setPname(String Pname) {
		this.Pname = Pname;
	}

	public int getinventory() {
		return inventory;
	}

	public void setinventory(int inventory) {
		this.inventory = inventory;
	}
	
	public int getamount() {
		return amount;
	}

	public void setamount(int amount) {
		this.amount = amount;
	}

	public String gettype() {
		return type;
	}

	public void settype(String type) {
		this.type = type;
	}

	public String getimage() {
		return image;
	}

	public void setimage(String image) {
		this.image = image;
	}

	public double getprice() {
		return price;
	}

	public void setprice(double price) {
		this.price = price;
	}
	
	public double getvalue() {
		return value;
	}

	public void setvalue(double value) {
		this.value = value;
	}

	public int getPquantity() {
		return Pquantity;
	}

	public void setPquantity(int Pquantity) {
		this.Pquantity = Pquantity;
	}

	public String getsalesperson() {
		return salesperson;
	}

	public void setsalesperson(String salesperson) {
		this.salesperson = salesperson;
	}

	public void setsale(int sale) {
		this.sale = sale;
	}

	public void setprofit(double profit) {
		this.profit = profit;
	}
	
	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

}
