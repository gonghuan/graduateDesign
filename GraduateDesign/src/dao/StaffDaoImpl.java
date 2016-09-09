package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import entity.Staff;
import exception.DaoException;

public class StaffDaoImpl implements IStaffDao {

	@Override
	public List<Staff> findAll() {
		// TODO Auto-generated method stub
		String sql="select * from staff";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<Staff> list=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			list=new ArrayList<Staff>();
			while(rs.next()){
				Staff staff=new Staff();
				staff.setId(rs.getInt("id"));
				staff.setName(rs.getString("name"));
				staff.setSex(rs.getString("sex"));
				staff.setNation(rs.getString("nation"));
				staff.setOrigin(rs.getString("origin"));
				staff.setBirthday(rs.getDate("birthday"));
				staff.setIsMarried(rs.getString("IsMarried"));
				staff.setIdentification(rs.getString("identification"));
				staff.setTelephone(rs.getString("telephone"));
				staff.setAddress(rs.getString("address"));
				staff.setEntry(rs.getDate("entry"));
				staff.setDepartment(rs.getString("department"));
				staff.setPosition(rs.getString("position"));
				staff.setPriority(rs.getInt("priority"));
				staff.setImagePath(rs.getString("imagePath"));
				staff.setEmail(rs.getString("email"));
				staff.setPassword(rs.getString("password"));
				list.add(staff);
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}finally{DBUtil.release(rs, pst, conn);}
		
		return list;
	}

	@Override
	public void add(String name,String sex,String nation,String origin,Date birthday
		    ,String isMarried,String identification,String telephone,String address,Date entry
		    ,String department,String position,int priority,String imagePath,String email,String password) {
		// TODO Auto-generated method stub
        String sql="insert into staff(name,sex,nation,origin,birthday,IsMarried,identification,telephone"
        		+",address,entry,department,position,priority,imagePath,email,password) "
        		+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst = conn.prepareStatement( sql, 
					Statement.RETURN_GENERATED_KEYS);
        	pst.setString(1, name);
        	pst.setString(2, sex);
        	pst.setString(3, nation);
        	pst.setString(4, origin);
        	pst.setDate(5, birthday);
        	pst.setString(6, isMarried);
        	pst.setString(7, identification);
        	pst.setString(8, telephone);
        	pst.setString(9, address);
        	pst.setDate(10, entry);
        	pst.setString(11, department);
        	pst.setString(12, position);
        	pst.setInt(13, priority);
        	pst.setString(14, imagePath);
        	pst.setString(15, email);
        	pst.setString(16, password);
        	pst.executeUpdate();
        	
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{
        	DBUtil.release(pst, conn);
        }
	}

	@Override
	public boolean delById(int id) {
		String sql="delete from staff where id=?";
		boolean isComplete=false;
		Connection conn=null;
		PreparedStatement pst=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			pst.setInt(1, id);
			pst.executeUpdate();
			isComplete=true;
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}finally{DBUtil.release(pst, conn);}
		return isComplete;
	}

	@Override
	public void modifyById(int id, String name, String sex, String nation,
			String origin, Date birthday, String isMarried,
			String identification, String telephone, String address,
			Date entry, String department, String position, int priority,
			String imagePath,String email,String password) {
		// TODO Auto-generated method stub
        String sql="update staff set name=?,sex=?,nation=?,origin=?,birthday=?,IsMarried=?,identification=? "
        		+ ",telephone=?,address=?,entry=?,department=?,position=?,priority=?,imagePath=?"
        		+ ",email=?,password=? where id=?";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setString(1, name);
        	pst.setString(2, sex);
        	pst.setString(3, nation);
        	pst.setString(4, origin);
        	pst.setDate(5, birthday);
        	pst.setString(6, isMarried);
        	pst.setString(7, identification);
        	pst.setString(8, telephone);
        	pst.setString(9, address);
        	pst.setDate(10, entry);
        	pst.setString(11, department);
        	pst.setString(12, position);
        	pst.setInt(13, priority);
        	pst.setString(14, imagePath);
        	pst.setString(15, email);
        	pst.setString(16, password);
        	pst.setInt(17, id);
        	pst.executeUpdate();
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{
        	DBUtil.release(pst, conn);
        }
	}

	@Override
	public Staff findByEmail(String email) {
		// TODO Auto-generated method stub
		String sql="select * from staff where email=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		Staff staff=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			pst.setString(1, email);
			rs=pst.executeQuery();
			staff=new Staff();
			while(rs.next()){
				staff.setId(rs.getInt("id"));
				staff.setName(rs.getString("name"));
				staff.setAddress(rs.getString("address"));
				staff.setBirthday(rs.getDate("birthday"));
				staff.setDepartment(rs.getString("department"));
				staff.setEntry(rs.getDate("entry"));
				staff.setIdentification(rs.getString("identification"));
				staff.setImagePath(rs.getString("imagePath"));
				staff.setIsMarried(rs.getString("IsMarried"));
				staff.setNation(rs.getString("nation"));
				staff.setOrigin(rs.getString("origin"));
				staff.setPosition(rs.getString("position"));
				staff.setPriority(rs.getInt("priority"));
				staff.setSex(rs.getString("sex"));
				staff.setTelephone(rs.getString("telephone"));
				staff.setEmail(rs.getString("email"));
				staff.setPassword(rs.getString("password"));
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}finally{
			DBUtil.release(rs, pst, conn);
		}
		return staff;
	}

}
