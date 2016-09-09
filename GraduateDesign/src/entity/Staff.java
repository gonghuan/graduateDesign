package entity;

import java.sql.Date;


public class Staff {
  private int id;
  private String name;
  private String sex;
  private String nation;
  private String origin;
  private Date birthday;
  private String isMarried;
  private String identification;
  private String telephone;
  private String address;
  private Date entry;
  private String department;
  private String position;
  private int priority;
  private String imagePath;
  private String email;
  private String password;
  
public Staff() {
	super();
}



public Staff(int id, String name, String sex, String nation, String origin,
		Date birthday, String isMarried, String identification,
		String telephone, String address, Date entry, String department,
		String position, int priority, String imagePath,String email,String password) {
	super();
	this.id = id;
	this.name = name;
	this.sex = sex;
	this.nation = nation;
	this.origin = origin;
	this.birthday = birthday;
	this.isMarried = isMarried;
	this.identification = identification;
	this.telephone = telephone;
	this.address = address;
	this.entry = entry;
	this.department = department;
	this.position = position;
	this.priority = priority;
	this.imagePath = imagePath;
	this.email=email;
	this.password=password;
}



public String getPassword() {
	return password;
}



public void setPassword(String password) {
	this.password = password;
}



public int getId() {
	return id;
}



public void setId(int id) {
	this.id = id;
}



public String getName() {
	return name;
}



public void setName(String name) {
	this.name = name;
}



public String getSex() {
	return sex;
}



public void setSex(String sex) {
	this.sex = sex;
}



public String getNation() {
	return nation;
}



public void setNation(String nation) {
	this.nation = nation;
}



public String getOrigin() {
	return origin;
}



public void setOrigin(String origin) {
	this.origin = origin;
}



public Date getBirthday() {
	return birthday;
}



public void setBirthday(Date birthday) {
	this.birthday = birthday;
}



public String getIsMarried() {
	return isMarried;
}



public void setIsMarried(String isMarried) {
	this.isMarried = isMarried;
}



public String getIdentification() {
	return identification;
}



public void setIdentification(String identification) {
	this.identification = identification;
}



public String getTelephone() {
	return telephone;
}



public void setTelephone(String telephone) {
	this.telephone = telephone;
}



public String getAddress() {
	return address;
}



public void setAddress(String address) {
	this.address = address;
}



public Date getEntry() {
	return entry;
}



public void setEntry(Date entry) {
	this.entry = entry;
}



public String getDepartment() {
	return department;
}



public void setDepartment(String department) {
	this.department = department;
}



public String getPosition() {
	return position;
}



public void setPosition(String position) {
	this.position = position;
}



public int getPriority() {
	return priority;
}



public void setPriority(int priority) {
	this.priority = priority;
}



public String getImagePath() {
	return imagePath;
}



public void setImagePath(String imagePath) {
	this.imagePath = imagePath;
}



public String getEmail() {
	return email;
}



public void setEmail(String email) {
	this.email = email;
}



@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((address == null) ? 0 : address.hashCode());
	result = prime * result + ((birthday == null) ? 0 : birthday.hashCode());
	result = prime * result
			+ ((department == null) ? 0 : department.hashCode());
	result = prime * result + ((entry == null) ? 0 : entry.hashCode());
	result = prime * result + id;
	result = prime * result
			+ ((identification == null) ? 0 : identification.hashCode());
	result = prime * result + ((imagePath == null) ? 0 : imagePath.hashCode());
	result = prime * result + ((isMarried == null) ? 0 : isMarried.hashCode());
	result = prime * result + ((name == null) ? 0 : name.hashCode());
	result = prime * result + ((nation == null) ? 0 : nation.hashCode());
	result = prime * result + ((origin == null) ? 0 : origin.hashCode());
	result = prime * result + ((position == null) ? 0 : position.hashCode());
	result = prime * result + priority;
	result = prime * result + ((sex == null) ? 0 : sex.hashCode());
	result = prime * result + ((telephone == null) ? 0 : telephone.hashCode());
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
	Staff other = (Staff) obj;
	if (address == null) {
		if (other.address != null)
			return false;
	} else if (!address.equals(other.address))
		return false;
	if (birthday == null) {
		if (other.birthday != null)
			return false;
	} else if (!birthday.equals(other.birthday))
		return false;
	if (department == null) {
		if (other.department != null)
			return false;
	} else if (!department.equals(other.department))
		return false;
	if (entry == null) {
		if (other.entry != null)
			return false;
	} else if (!entry.equals(other.entry))
		return false;
	if (id != other.id)
		return false;
	if (identification == null) {
		if (other.identification != null)
			return false;
	} else if (!identification.equals(other.identification))
		return false;
	if (imagePath == null) {
		if (other.imagePath != null)
			return false;
	} else if (!imagePath.equals(other.imagePath))
		return false;
	if (isMarried == null) {
		if (other.isMarried != null)
			return false;
	} else if (!isMarried.equals(other.isMarried))
		return false;
	if (name == null) {
		if (other.name != null)
			return false;
	} else if (!name.equals(other.name))
		return false;
	if (nation == null) {
		if (other.nation != null)
			return false;
	} else if (!nation.equals(other.nation))
		return false;
	if (origin == null) {
		if (other.origin != null)
			return false;
	} else if (!origin.equals(other.origin))
		return false;
	if (position == null) {
		if (other.position != null)
			return false;
	} else if (!position.equals(other.position))
		return false;
	if (priority != other.priority)
		return false;
	if (sex == null) {
		if (other.sex != null)
			return false;
	} else if (!sex.equals(other.sex))
		return false;
	if (telephone == null) {
		if (other.telephone != null)
			return false;
	} else if (!telephone.equals(other.telephone))
		return false;
	return true;
}



@Override
public String toString() {
	return "Staff [id=" + id + ", name=" + name + ", sex=" + sex + ", nation="
			+ nation + ", origin=" + origin + ", birthday=" + birthday
			+ ", isMarried=" + isMarried + ", identification=" + identification
			+ ", telephone=" + telephone + ", address=" + address + ", entry="
			+ entry + ", department=" + department + ", position=" + position
			+ ", priority=" + priority + ", imagePath=" + imagePath
			+ ", email=" + email + ", password=" + password + "]";
}


  
}
