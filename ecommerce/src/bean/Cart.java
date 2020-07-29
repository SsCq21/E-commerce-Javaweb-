package bean;

import java.util.ArrayList;

public class Cart {
	private ArrayList buylist = new ArrayList();

	public ArrayList getBuylist() {
		return buylist;
	}

	public void addItem(Product product) {
		if (product != null) {
			int i = 0;
			for (; i < buylist.size(); i++) {
				Product temp = (Product) buylist.get(i);
				if (temp.getPid().equals(product.getPid())) {
					temp.setamount(temp.getamount() + 1);
					break;
				}
			}
			if (i == buylist.size()) {
				buylist.add(product);
			}
		}
	}

	public void removeItem(String name) {
		for (int i = 0; i < buylist.size(); i++) {
			Product temp = (Product) buylist.get(i);
			if (temp.getPid().equals(name)) {
				if (temp.getamount() > 1) {
					temp.setamount(temp.getamount() - 1);
					break;
				} else if (temp.getamount() == 1) {
					buylist.remove(i);
					break;
				}
			}
		}
	}

	public void removethis(String name) {
		for (int i = 0; i < buylist.size(); i++) {
			Product temp = (Product) buylist.get(i);
			if (temp.getPid().equals(name)) {
				if (temp.getamount() > 1) {
					buylist.remove(i);
					break;
				} else if (temp.getamount() == 1) {
					buylist.remove(i);
					break;
				}
			}
		}
	}

	public void addone(String name) {
		for (int i = 0; i < buylist.size(); i++) {
			Product temp = (Product) buylist.get(i);
			if (temp.getPid().equals(name)) {
				if (temp.getamount() > 1) {
					temp.setamount(temp.getamount() + 1);
					break;
				} else if (temp.getamount() == 1) {
					temp.setamount(temp.getamount() + 1);
					break;
				}
			}
		}
	}

	public void buy(String name) {
		for (int i = 0; i < buylist.size(); i++) {
			Product temp = (Product) buylist.get(i);
			if (temp.getPid().equals(name)) {
				if (temp.getamount() > 1) {
					temp.setamount(temp.getamount() - 1);
					break;
				} else if (temp.getamount() == 1) {
					buylist.remove(i);
					break;
				}
			}
		}
	}

	public void clearCar() {
		buylist.clear();
	}

}
