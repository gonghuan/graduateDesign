package entity;

public class leaveWords {
   private long GoodsId;
   private String url;
   
   
public leaveWords() {
	super();
}


public leaveWords(long goodsId, String url) {
	super();
	GoodsId = goodsId;
	this.url = url;
}


public long getGoodsId() {
	return GoodsId;
}


public void setGoodsId(long goodsId) {
	GoodsId = goodsId;
}


public String getUrl() {
	return url;
}


public void setUrl(String url) {
	this.url = url;
}


@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + (int) (GoodsId ^ (GoodsId >>> 32));
	result = prime * result + ((url == null) ? 0 : url.hashCode());
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
	leaveWords other = (leaveWords) obj;
	if (GoodsId != other.GoodsId)
		return false;
	if (url == null) {
		if (other.url != null)
			return false;
	} else if (!url.equals(other.url))
		return false;
	return true;
}


@Override
public String toString() {
	return "leaveWords [GoodsId=" + GoodsId + ", url=" + url + "]";
}
   
}
