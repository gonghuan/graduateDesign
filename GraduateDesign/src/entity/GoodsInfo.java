package entity;

import java.io.Serializable;

import java.util.Date;

public class GoodsInfo implements Serializable {
	private long GoodsId;
	private String GoodsName;
	private String GoodsDescription;
	private double BeginPrice;
	private String ImagePath;
	private int Amount;
	private Date BeginTime;
	private Date EndTime;
	private long UserId;
	
	//两种构造函数
	public GoodsInfo(){};
	public GoodsInfo(int goodsId, String goodsName, String goodsDescription,
			double beginPrice, String imagePath, int amount, Date beginTime,
			Date endTime, long userId) {
		super();
		GoodsId = goodsId;
		GoodsName = goodsName;
		GoodsDescription = goodsDescription;
		BeginPrice = beginPrice;
		ImagePath = imagePath;
		Amount = amount;
		BeginTime = beginTime;
		EndTime = endTime;
		UserId = userId;
	}
	
	//getters()和setters()方法
	public long getGoodsId() {
		return GoodsId;
	}
	public void setGoodsId(long goodsId) {
		GoodsId = goodsId;
	}
	public String getGoodsName() {
		return GoodsName;
	}
	public void setGoodsName(String goodsName) {
		GoodsName = goodsName;
	}
	public String getGoodsDescription() {
		return GoodsDescription;
	}
	public void setGoodsDescription(String goodsDescription) {
		GoodsDescription = goodsDescription;
	}
	public double getBeginPrice() {
		return BeginPrice;
	}
	public void setBeginPrice(double beginPrice) {
		BeginPrice = beginPrice;
	}
	public String getImagePath() {
		return ImagePath;
	}
	public void setImagePath(String imagePath) {
		ImagePath = imagePath;
	}
	public int getAmount() {
		return Amount;
	}
	public void setAmount(int amount) {
		Amount = amount;
	}
	public Date getBeginTime() {
		return BeginTime;
	}
	public void setBeginTime(Date beginTime) {
		BeginTime = beginTime;
	}
	public Date getEndTime() {
		return EndTime;
	}
	public void setEndTime(Date endTime) {
		EndTime = endTime;
	}
	public long getUserId() {
		return UserId;
	}
	public void setUserId(long userId) {
		UserId = userId;
	}
	
	//重写hashCode()和equals()以及toString()函数
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result +(int)GoodsId;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		GoodsInfo other = (GoodsInfo) obj;
		if (GoodsId != other.GoodsId)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "GoodsInfo [GoodsId=" + GoodsId + ", GoodsName=" + GoodsName
				+ ", GoodsDescription=" + GoodsDescription + ", BeginPrice="
				+ BeginPrice + ", ImagePath=" + ImagePath + ", Amount="
				+ Amount + ", BeginTime=" + BeginTime + ", EndTime=" + EndTime
				+ ", UserId=" + UserId + "]";
	}
	
	
	
}
