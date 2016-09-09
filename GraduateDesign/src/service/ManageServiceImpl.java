package service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import dao.*;
import entity.GoodsInfo;
import entity.Notice;
import entity.OfflineInfo;
import entity.Staff;
import entity.User;
import entity.news;

public class ManageServiceImpl implements IManageService {
	IUserDao user=new UserDaoImpl();
	INewsDao news=new NewsDaoImpl();
	INoticeDao notice=new NoticeDaoImpl();
	IStaffDao staff=new StaffDaoImpl();
	IOfflineInfoDao offlineInfo=new offlineInfoDaoImpl(); 
	ITmpGoodsDao goodsInfo=new TmpGoodsDaoImpl();
	IGoodsDao goods=new GoodsDaoImpl();
	@Override
	public List<User> load() {
		// TODO Auto-generated method stub
		List<User> list=new ArrayList<User>();
		list=user.findAll();
		return list;
	}
	
	@Override
	public boolean delete(long id){
		return user.deleteById(id);
	}

	@Override
	public void modifyById(long id,String email,String name,String nickName,String telephone,
			String postBoy,String address) {
		// TODO Auto-generated method stub
		user.modifyById(id, email, name, nickName, telephone, postBoy, address);
	}

	@Override
	public List<news> loadNews() {
		return news.findAll();
	}

	@Override
	public boolean deleteById(long id) {
		return news.deleteById(id);
	}

	@Override
	public void modifyById(long id, Date time, String context, String href) {
		news.modifyById(id, time, context, href);
		
	}

	@Override
	public void add(String context, Date time, String href) {
		// TODO Auto-generated method stub
		news.add(context, time, href);
	}

	@Override
	public List<Notice> loadNotice() {
		// TODO Auto-generated method stub
		return notice.findAll();
	}

	@Override
	public boolean deleteById(int id) {
		// TODO Auto-generated method stub
		return notice.deleteById(id);
	}

	@Override
	public void modifyById(int id, Date time, String context, String href) {
		// TODO Auto-generated method stub
		notice.modifyById(id, time, context, href);
	}

	@Override
	public void addNotice(String context, Date time, String href) {
		// TODO Auto-generated method stub
		notice.add(context, time, href);
	}

	@Override
	public List<Staff> loadStaff() {
		// TODO Auto-generated method stub
		return staff.findAll();
	}

	@Override
	public boolean deleteByStaffId(int id) {
		// TODO Auto-generated method stub
		return staff.delById(id);
	}

	@Override
	public void modifyByStaffId(int id, String name, String sex, String nation,
			String origin, Date birthday, String isMarried,
			String identification, String telephone, String address,
			Date entry, String department, String position, int priority,
			String imagePath,String email,String password) {
		// TODO Auto-generated method stub
		staff.modifyById(id, name, sex, nation, origin, birthday, isMarried, identification, 
				telephone, address, entry, department, position, priority, imagePath,email,password);
	}

	@Override
	public void addStaff(String name, String sex, String nation, String origin,
			Date birthday, String isMarried, String identification,
			String telephone, String address, Date entry, String department,
			String position, int priority, String imagePath,String email,String password) {
		// TODO Auto-generated method stub
		staff.add(name, sex, nation, origin, birthday, isMarried, identification, telephone, 
				address, entry, department, position, priority, imagePath,email,password);
	}

	@Override
	public Staff loadStaffByEmail(String email) {
		Staff staffs=null;
		staffs=staff.findByEmail(email);
		return staffs;
	}

	@Override
	public List<OfflineInfo> loadOfflineInfo() {
		return offlineInfo.findAll();
	}

	@Override
	public void add(String previewName, Date previewBegin, Date previewEnd,
			String previewProvince, String previewLocate, String name,
			java.util.Date time, String locate) {
		// TODO Auto-generated method stub
		offlineInfo.add(previewName, previewBegin, previewEnd, previewProvince, previewLocate, 
				name, time, locate);
	}

	@Override
	public boolean deleteByOfflineInfoId(long id) {
		// TODO Auto-generated method stub
		return offlineInfo.del(id);
	}

	@Override
	public void modifyOfflineInfoId(long id, String previewName,
			Date previewBegin, Date previewEnd, String previewProvince,
			String previewLocate, String name, java.util.Date time,
			String locate) {
		// TODO Auto-generated method stub
		offlineInfo.modify(id, previewName, previewBegin, previewEnd, previewProvince, previewLocate,
				name, time, locate);
	}

	@Override
	public List<GoodsInfo> loadGoodsInfo() {
		// TODO Auto-generated method stub
		return goodsInfo.findAll();
	}

	@Override
	public void addGoodsInfo(String GoodsName, String GoodsDescription,
			double BeginPrice, String ImagePath, int Amount, java.util.Date BeginTime,
			java.util.Date EndTime, long UserId) {
		// TODO Auto-generated method stub
		goodsInfo.addTmpGoods(GoodsName, GoodsDescription, BeginPrice, ImagePath, Amount, 
				BeginTime, EndTime, UserId);
	}

	@Override
	public boolean deleteByGoodsInfoId(long id) {
		// TODO Auto-generated method stub
		return goodsInfo.delByTmpGoodsId(id);
	}

	@Override
	public void modifyGoodsInfo(long GoodsId, String GoodsName,
			String GoodsDescription, double BeginPrice, String ImagePath,
			int Amount, java.util.Date BeginTime, java.util.Date EndTime, long UserId) {
		// TODO Auto-generated method stub
		goodsInfo.modifyTmpGoods(GoodsId, GoodsName, GoodsDescription, BeginPrice, ImagePath, Amount, 
				BeginTime, EndTime, UserId);
	}

	@Override
	public GoodsInfo findByGoodsId(long id) {
		// TODO Auto-generated method stub
		return goodsInfo.findById(id);
	}

	@Override
	public List<GoodsInfo> findOnBid() {
		// TODO Auto-generated method stub
		return goods.findOnBid();
	}
}
