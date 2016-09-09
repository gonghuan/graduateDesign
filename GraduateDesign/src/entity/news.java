package entity;

import java.sql.Date;
public class news {
  private long newsId;
  private Date time;
  private String content;
  private String href;
  
  public news(long newsId, Date time, String content, String href) {
	super();
	this.newsId = newsId;
	this.time = time;
	this.content = content;
	this.href = href;
  }
  
  public news() {
	super();
  }

  public long getNewsId() {
	return newsId;
  }
  public void setNewsId(long newsId) {
	this.newsId = newsId;
  }
  public Date getTime() {
	return time;
  }
  public void setTime(Date time) {
	this.time = time;
  }
  public String getContent() {
	return content;
  }
  public void setContent(String content) {
	this.content = content;
  }
  public String getHref() {
	return href;
  }
  public void setHref(String href) {
	this.href = href;
  }

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((content == null) ? 0 : content.hashCode());
	result = prime * result + ((href == null) ? 0 : href.hashCode());
	result = prime * result + (int) (newsId ^ (newsId >>> 32));
	result = prime * result + ((time == null) ? 0 : time.hashCode());
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
	news other = (news) obj;
	if (content == null) {
		if (other.content != null)
			return false;
	} else if (!content.equals(other.content))
		return false;
	if (href == null) {
		if (other.href != null)
			return false;
	} else if (!href.equals(other.href))
		return false;
	if (newsId != other.newsId)
		return false;
	if (time == null) {
		if (other.time != null)
			return false;
	} else if (!time.equals(other.time))
		return false;
	return true;
}

@Override
public String toString() {
	return "news [newsId=" + newsId + ", time=" + time + ", content=" + content
			+ ", href=" + href + "]";
}
  
}
