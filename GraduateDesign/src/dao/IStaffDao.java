package dao;

import java.sql.Date;
import java.util.List;

import entity.Staff;

public interface IStaffDao {
   public List<Staff> findAll();
   public Staff findByEmail(String email);
   public void add(String name,String sex,String nation,String origin,Date birthday
		    ,String isMarried,String identification,String telephone,String address,Date entry
		    ,String department,String position,int priority,String imagePath,String email,String password);
   public boolean delById(int id);
   public void modifyById(int id,String name,String sex,String nation,String origin,Date birthday
		    ,String isMarried,String identification,String telephone,String address,Date entry
		    ,String department,String position,int priority,String imagePath,String email,String password);
}
