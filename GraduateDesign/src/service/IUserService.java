package service;

import entity.*;
import java.util.List;

public interface IUserService {
	public User login( String email, String password);
    
	public Staff staffLogin(String email,String password);
	
	public User register(User user);
	
	public boolean modify(User user);
	
	public List<GoodsInfo> search(String name);
	
	public BidInfo loadBidInfo(long id);
	
	public void addBidInfo(long id,String url);
	
	public leaveWords loadLeaveWords(long id);
	
	public void addLeaveWords(long id,String url);
}
