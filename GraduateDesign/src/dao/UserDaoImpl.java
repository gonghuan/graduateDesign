package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import exception.DaoException;
import util.DBUtil;
import entity.User;

public class UserDaoImpl implements IUserDao {

	@Override
	public List<User> findAll() {
		String sql = "select * from userinfo";
		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		List<User> list = null;
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			
			list = new ArrayList<User>();
			while( rs.next() ){
				User user = new User();
				user.setUserId( rs.getLong("UserId") );
				user.seteMail( rs.getString("eMail") );
				user.setPassword( rs.getString("Password") );
				user.setUserName( rs.getString("Username"));
				user.setAddress(rs.getString("Address"));
				user.setPostBoy(rs.getString("PostBoy"));
				user.setTelephone(rs.getString("Telephone"));
				user.setTruName(rs.getString("TruName"));
				user.setPassHint(rs.getString("PassHint"));
				user.setImagePath(rs.getString("ImagePath"));
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally{
			DBUtil.release(rs, pst, conn);
		}
		
		return list;
	}

	@Override
	public User findById(long id) {
		String sql="select * from userinfo where UserId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		User user=new User();
		
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			pst.setLong(1, id);
			rs = pst.executeQuery();
			if( rs.next() ){
				user = new User();
				user.setUserId( rs.getLong("UserId") );
				user.seteMail( rs.getString("eMail") );
				user.setPassword( rs.getString("Password") );
				user.setUserName( rs.getString("Username"));
				user.setAddress(rs.getString("Address"));
				user.setPostBoy(rs.getString("PostBoy"));
				user.setTelephone(rs.getString("Telephone"));
				user.setTruName(rs.getString("TruName"));
				user.setPassHint(rs.getString("PassHint"));
				user.setImagePath(rs.getString("ImagePath"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(rs, pst, conn);
		}
		
		return user;
	}

	public User findByeMail(String eMail) {
		String sql="select * from userinfo where eMail=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		User user=new User();
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			pst.setString(1, eMail);
			rs = pst.executeQuery();
			if( rs.next() ){
				user = new User();
				user.setUserId( rs.getLong("UserId") );
				user.seteMail( rs.getString("eMail") );
				user.setPassword( rs.getString("Password") );
				user.setUserName( rs.getString("Username"));
				user.setAddress(rs.getString("Address"));
				user.setPostBoy(rs.getString("PostBoy"));
				user.setTelephone(rs.getString("Telephone"));
				user.setTruName(rs.getString("TruName"));
				user.setPassHint(rs.getString("PassHint"));
				user.setImagePath(rs.getString("ImagePath"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(rs, pst, conn);
		}
		
		return user;
	}

	@Override
	public User save(User user) {
		String sql = "insert into userinfo( eMail,Password"
				  + ",UserName,Address,PostBoy,Telephone,TruName"
				  + ",PassHint,ImagePath )"
				  + " values (?,?,?,?,?,?,?,?,?)";
				Connection conn = null;
				PreparedStatement pst = null;
				ResultSet rs = null;
				try {
					conn = DBUtil.getConnection();
					
                    //pst = conn.prepareStatement(sql);
					
					// 创建可以返回自动生成主键值id 的pst对象
					pst = conn.prepareStatement( sql, 
							Statement.RETURN_GENERATED_KEYS);
					
					pst.setString(1, user.geteMail());
					pst.setString(2, user.getPassword());
					pst.setString(3, user.getUserName());
					pst.setString(4, user.getAddress());
					pst.setString(5, user.getPostBoy());
					pst.setString(6, user.getTelephone());
					pst.setString(7, user.getTruName());
					pst.setString(8, user.getPassHint());
					pst.setString(9, user.getImagePath());
					
					int num = pst.executeUpdate();
					if( num!=1 )
						return null;
					
					// 在执行sql语句时，将所生成的主键值直接返回
					// 可以避免再次创建sql语句从db中，再次查询
					
					rs = pst.getGeneratedKeys(); //生成的键值以结果集形式返回
					if( rs.next() )		// 此时只有一个字段是自动生成的，只需要遍历一次
						user.setUserId( rs.getLong(1) );//"GENERATE_KEY_ID"
					/*
					// 根据传入的user对象，分别将业务相关的属性值保存到db中
					//    但jvm内存中的user对象的id是空的，还没有值！
					//    所以需要从数据库中，根据email重新获得一个新的对象
					user = findByEmail( user.getEmail() );
					// 这样的写法，不够优雅！需要进行再次数据库的操作！！
					 */
				} catch (SQLException e) {
					e.printStackTrace();
					throw new DaoException( e );
				} finally {
					DBUtil.release(rs, pst, conn);
				}
				return user;
	}

	@Override
	public boolean update(User user) {
		String sql = "update userinfo set eMail=?, Password=? "
				+ ",UserName=?,Address=?,PostBoy=?,Telephone=?"
				+ ",TruName=?,PassHint=?"+ " where UserId=?";
		
		Connection conn = null;
		PreparedStatement pst = null;
		
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, user.geteMail());
			pst.setString(2, user.getPassword());
			pst.setString(3, user.getUserName());
			pst.setString(4, user.getAddress());
			pst.setString(5, user.getPostBoy());
			pst.setString(6, user.getTelephone());
			pst.setString(7, user.getTruName());
			pst.setString(8, user.getPassHint());
			pst.setLong(9, user.getUserId());
			
			int num = pst.executeUpdate();
			if( num==1 )
				return true;
			else
				return false;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(pst, conn);
		}
	
	}
	
	@Override
	public void uploadImg(User user){
		String sql = "update userinfo set ImagePath=?"+ " where UserId=?";
		
		Connection conn = null;
		PreparedStatement pst = null;
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, user.getImagePath());
			
			pst.setLong(2, user.getUserId());
			pst.executeUpdate();
				
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(pst, conn);
		}
	
	}

	@Override
	public boolean deleteById(long id) {
		// TODO Auto-generated method stub
		boolean isComplete=false;
		String sql="delete from userinfo where userId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			pst.setLong(1, id);
			pst.executeUpdate();
			isComplete=true;
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}finally{DBUtil.release(pst, conn);}
		return isComplete;
	}
	
	@Override
	public void modifyById(long id,String email,String name,String nickName,String telephone,
			String postBoy,String address ){
		String sql="update userinfo set eMail=?,UserName=?,Address=?,PostBoy=?,Telephone=?"
				+ ",TruName=?"+ " where UserId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			pst.setString(1, email);
			pst.setString(2, nickName);
			pst.setString(3, address);
			pst.setString(4,postBoy);
			pst.setString(5, telephone);
			pst.setString(6, name);
			pst.setLong(7, id);
			pst.executeUpdate();
		}
		catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}finally{DBUtil.release(pst, conn);}
	}

}
