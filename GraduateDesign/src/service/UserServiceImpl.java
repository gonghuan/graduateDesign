package service;

import entity.*;
import dao.*;

import java.util.List;

public class UserServiceImpl implements IUserService {
	IUserDao userDao=new UserDaoImpl();
	IGoodsDao goodsDao=new GoodsDaoImpl();
	IStaffDao staffDao=new StaffDaoImpl();
	IBidInfoDao bidInfoDao=new BidInfoDaoImpl();
	IWordsDao wordsDao=new wordsDaoImpl();
	@Override
	public User login(String email, String password) 
	{
		User user=userDao.findByeMail(email);
        if(user.geteMail()==null)
		{
        	return null;
        }
        else if( user.getPassword().equals( password )){
			return user;
		}else{
			return null;
		}
        
	}
	
	public Staff staffLogin(String email,String password){
		Staff staff=staffDao.findByEmail(email);
    	if(staff.getEmail()==null){
    		return null;
    	}
    	else if(staff.getPassword().equals(password)){
    		return staff;
    	}else{
    		return null;
    	}
	}

	@Override
	public User register(User user) 
	{
		if( userDao.findByeMail(user.geteMail()).getUserId()!=0 ){
			return null;		//如果数据库中已经有这个用户，就返回空
		}
		else{
			return userDao.save(user);
		}
	}
	
	@Override
	public boolean modify(User user)
	{
			return userDao.update(user);	
	}
    
	@Override
	public List<GoodsInfo> search(String name)
	{
		return goodsDao.findByGoodsName(name);
	}

	@Override
	public BidInfo loadBidInfo(long id) {
		// TODO Auto-generated method stub
		return bidInfoDao.findById(id);
	}

	@Override
	public void addBidInfo(long id, String url) {
		// TODO Auto-generated method stub
		BidInfo bidInfo=new BidInfo(id,url);
		bidInfoDao.add(bidInfo);
	}

	@Override
	public leaveWords loadLeaveWords(long id) {
		// TODO Auto-generated method stub
		return wordsDao.findById(id);
	}

	@Override
	public void addLeaveWords(long id, String url) {
		// TODO Auto-generated method stub
		leaveWords leavewords=new leaveWords(id,url);
		wordsDao.add(leavewords);
	}
	
}
