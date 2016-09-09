package entity;
import java.sql.Date;

public class OfflineInfo {
  private long id;
  private String previewName;
  private Date previewBegin;
  private Date previewEnd;
  private String previewProvince;
  private String previewLocate;
  private String name;
  private java.util.Date time;
  private String locate;
  
  
public OfflineInfo() {
	super();
}

public OfflineInfo(long id, String previewName, Date previewBegin,
		Date previewEnd, String previewProvince, String previewLocate,
		String name, Date time, String locate) {
	super();
	this.id = id;
	this.previewName = previewName;
	this.previewBegin = previewBegin;
	this.previewEnd = previewEnd;
	this.previewProvince = previewProvince;
	this.previewLocate = previewLocate;
	this.name = name;
	this.time = time;
	this.locate = locate;
}

public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public String getPreviewName() {
	return previewName;
}
public void setPreviewName(String previewName) {
	this.previewName = previewName;
}
public Date getPreviewBegin() {
	return previewBegin;
}
public void setPreviewBegin(Date previewBegin) {
	this.previewBegin = previewBegin;
}
public Date getPreviewEnd() {
	return previewEnd;
}
public void setPreviewEnd(Date previewEnd) {
	this.previewEnd = previewEnd;
}
public String getPreviewProvince() {
	return previewProvince;
}
public void setPreviewProvince(String previewProvince) {
	this.previewProvince = previewProvince;
}
public String getPreviewLocate() {
	return previewLocate;
}
public void setPreviewLocate(String previewLocate) {
	this.previewLocate = previewLocate;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public java.util.Date getTime() {
	return time;
}
public void setTime(java.util.Date time) {
	this.time = time;
}
public String getLocate() {
	return locate;
}
public void setLocate(String locate) {
	this.locate = locate;
}

@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + (int) (id ^ (id >>> 32));
	result = prime * result + ((locate == null) ? 0 : locate.hashCode());
	result = prime * result + ((name == null) ? 0 : name.hashCode());
	result = prime * result
			+ ((previewBegin == null) ? 0 : previewBegin.hashCode());
	result = prime * result
			+ ((previewEnd == null) ? 0 : previewEnd.hashCode());
	result = prime * result
			+ ((previewLocate == null) ? 0 : previewLocate.hashCode());
	result = prime * result
			+ ((previewName == null) ? 0 : previewName.hashCode());
	result = prime * result
			+ ((previewProvince == null) ? 0 : previewProvince.hashCode());
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
	OfflineInfo other = (OfflineInfo) obj;
	if (id != other.id)
		return false;
	if (locate == null) {
		if (other.locate != null)
			return false;
	} else if (!locate.equals(other.locate))
		return false;
	if (name == null) {
		if (other.name != null)
			return false;
	} else if (!name.equals(other.name))
		return false;
	if (previewBegin == null) {
		if (other.previewBegin != null)
			return false;
	} else if (!previewBegin.equals(other.previewBegin))
		return false;
	if (previewEnd == null) {
		if (other.previewEnd != null)
			return false;
	} else if (!previewEnd.equals(other.previewEnd))
		return false;
	if (previewLocate == null) {
		if (other.previewLocate != null)
			return false;
	} else if (!previewLocate.equals(other.previewLocate))
		return false;
	if (previewName == null) {
		if (other.previewName != null)
			return false;
	} else if (!previewName.equals(other.previewName))
		return false;
	if (previewProvince == null) {
		if (other.previewProvince != null)
			return false;
	} else if (!previewProvince.equals(other.previewProvince))
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
	return "offlineInfo [id=" + id + ", previewName=" + previewName
			+ ", previewBegin=" + previewBegin + ", previewEnd=" + previewEnd
			+ ", previewProvince=" + previewProvince + ", previewLocate="
			+ previewLocate + ", name=" + name + ", time=" + time + ", locate="
			+ locate + "]";
}
  
  
}
