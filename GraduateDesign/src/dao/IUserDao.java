package dao;

import java.util.List;

import entity.User;

public interface IUserDao {
  
	public List<User> findAll();
	public User findById( long id );
	public User findByeMail( String eMail );
	public boolean deleteById(long id);
	public User save( User user);
	public boolean update( User user );
	public void uploadImg(User user);
	public void modifyById(long id,String email,String name,String nickName,String telephone,String postBoy,String address);
	
}
