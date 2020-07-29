package bean;

public class Review {
	
	private String orderID;
	private int score;
	private String title;
	private String message;
	private String createDate;
	private String customerID;
	private String sellerID;
	
	public String getOrderID() {
		return orderID;
	}
	
	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	
	public int getSocre() {
		return score;
	}
	
	public void setScore(int score) {
		this.score=score;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title=title;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getCreateDate() {
		return createDate;
	}
	
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public String getCustomerID() {
		return customerID;
	}
	
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	
	public String getSellerID() {
		return sellerID;
	}
	
	public void setSellerID(String sellerID) {
		this.sellerID = sellerID;
	}

}
