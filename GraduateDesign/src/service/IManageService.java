package service;

import java.sql.Date;
import java.util.List;

import entity.*;

public interface IManageService {
	 public List<User> load();
	 public boolean delete(long id);
	 public void modifyById(long id,String email,String name,String nickName,String telephone,String postBoy,String address);
	 
	 public List<news> loadNews();
	 public boolean deleteById(long id);
	 public void modifyById(long id,Date time,String context,String href);
	 public void add(String context,Date time,String href);
	 
	 public List<Notice> loadNotice();
	 public boolean deleteById(int id);
	 public void modifyById(int id,Date time,String context,String href);
	 public void addNotice(String context,Date time,String href);
	
	 public List<Staff> loadStaff();
	 public Staff loadStaffByEmail(String email);
	 public boolean deleteByStaffId(int id);
	 public void modifyByStaffId(int id, String name, String sex, String nation,String origin, Date birthday, 
			   String isMarried,String identification, String telephone, String address,Date entry, 
			   String department, String position, int priority,String imagePath,String email,String password);
	 public void addStaff(String name,String sex,String nation,String origin,Date birthday
			    ,String isMarried,String identification,String telephone,String address,Date entry
			    ,String department,String position,int priority,String imagePath,String email,String password);
	
	 public List<OfflineInfo> loadOfflineInfo();
	 public void add(String previewName,Date previewBegin,Date previewEnd,String previewProvince,
			  String previewLocate,String name,java.util.Date time,String locate);
	 public boolean deleteByOfflineInfoId(long id);
	 public void modifyOfflineInfoId(long id, String previewName, Date previewBegin,Date previewEnd, 
			 String previewProvince, String previewLocate,String name, java.util.Date time, String locate);
	 
	 public List<GoodsInfo> loadGoodsInfo();
	 public void addGoodsInfo(String GoodsName, String GoodsDescription,double BeginPrice, String ImagePath, 
			 int Amount, java.util.Date BeginTime,java.util.Date EndTime, long UserId);
	 public boolean deleteByGoodsInfoId(long id);
	 public void modifyGoodsInfo(long GoodsId,String GoodsName,String GoodsDescription,double BeginPrice
			  ,String ImagePath,int Amount,java.util.Date BeginTime,java.util.Date EndTime,long UserId);
	 public GoodsInfo findByGoodsId(long id);
	 public List<GoodsInfo> findOnBid();
	 
}
