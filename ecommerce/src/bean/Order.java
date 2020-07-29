package bean;

public class Order {
	public Order() {
	}

	private String oid;
	private String uscid;
	private String odate;
	private String ostatus;
	private String ptype;
	private Double pvalue;

	public String getoid() {
		return oid;
	}

	public void setoid(String oid) {
		this.oid = oid;
	}

	public String getuscid() {
		return oid;
	}

	public void setuscid(String uscid) {
		this.uscid = uscid;
	}

	public String getodate() {
		return oid;
	}

	public void setodate(String odate) {
		this.odate = odate;
	}

	public String getostatus() {
		return ostatus;
	}

	public void setostatus(String ostatus) {
		this.ostatus = ostatus;
	}

	public String getptype() {
		return ptype;
	}

	public void setptype(String ptype) {
		this.ptype = ptype;
	}

	public double getpvalue() {
		return pvalue;
	}

	public void setpvalue(double pvalue) {
		this.pvalue = pvalue;
	}

}
