package entity;

import java.io.Serializable;

public class User implements Serializable {
   private long UserId;
   private String UserName;
   private String Password;
   private String Telephone;
   private String eMail;
   private String TruName;
   private String Address;
   private String PostBoy;
   private String PassHint;
   private String ImagePath;

   public String getImagePath() {
	return ImagePath;
}

public void setImagePath(String imagePath) {
	ImagePath = imagePath;
}

//两种构造函数
   public User(){}
    
   public User(String userName, String password, String telephone, String eMail,
		String truName, String address, String postBoy, String passHint,String imagePath) {
	super();
	UserName = userName;
	Password = password;
	Telephone = telephone;
	this.eMail = eMail;
	TruName = truName;
	Address = address;
	PostBoy = postBoy;
	PassHint = passHint;
	ImagePath=imagePath;
}


    public User(long userId, String userName, String password, String telephone,
		String eMail, String truName, String address, String postBoy,
		String passHint) 
   {
	  super();
	  UserId = userId;
	  UserName = userName;
	  Password = password;
	  Telephone = telephone;
	  this.eMail = eMail;
	  TruName = truName;
	  Address = address;
	  PostBoy = postBoy;
	  PassHint = passHint;
   }

   //getter()和setter()方法
   public long getUserId() 
   {
	return UserId;
   }

   public void setUserId(long userId) 
   {
	UserId = userId;
   }

   public String getUserName() 
   {
	return UserName;
   }

   public void setUserName(String userName)
   {
	UserName = userName;
   }

   public String getPassword() 
   {
	return Password;
   }

   public void setPassword(String password) 
   {
	Password = password;
   }

   public String getTelephone() 
   {
	return Telephone;
   }

   public void setTelephone(String telephone) 
   {
	Telephone = telephone;
   }

   public String geteMail() 
   {
	return eMail;
   }

   public void seteMail(String eMail) 
   {
	this.eMail = eMail;
   }

   public String getTruName() 
   {
	return TruName;
   }

   public void setTruName(String truName) 
   {
	TruName = truName;
   }

   public String getAddress() 
   {
	return Address;
   }

   public void setAddress(String address) 
   {
	Address = address;
   }

   public String getPostBoy() 
   {
	return PostBoy;
   }

   public void setPostBoy(String postBoy) 
   {
	PostBoy = postBoy;
   }

   public String getPassHint() 
   {
	return PassHint;
   }

   public void setPassHint(String passHint) 
   {
	PassHint = passHint;
   }
   
   //重写hashCode()函数和equals()函数和toString()函数
   @Override
   public int hashCode() {
	   final int prime = 31;
	   int result = 1;
	   result = prime * result + (int)UserId;
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
	   User other = (User) obj;
	   if (UserId != other.UserId)
		   return false;
	   return true;
    }
   @Override
   public String toString() {
	   return "User [UserId=" + UserId + ", UserName=" + UserName + ", Password="
			   + Password + ", Telephone=" + Telephone + ", eMail=" + eMail
			   + ", TruName=" + TruName + ", Address=" + Address + ", PostBoy="
			   + PostBoy + ", PassHint=" + PassHint + "]";
   }

public User(long userId, String userName, String password, String telephone,
		String eMail, String truName, String address, String postBoy,
		String passHint, String imagePath) {
	super();
	UserId = userId;
	UserName = userName;
	Password = password;
	Telephone = telephone;
	this.eMail = eMail;
	TruName = truName;
	Address = address;
	PostBoy = postBoy;
	PassHint = passHint;
	ImagePath = imagePath;
}
   
   
   
}
