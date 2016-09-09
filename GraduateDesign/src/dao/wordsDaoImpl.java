package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import entity.BidInfo;
import entity.leaveWords;
import exception.DaoException;

public class wordsDaoImpl implements IWordsDao {

	@Override
	public List<leaveWords> findAll() {
		// TODO Auto-generated method stub
		String sql="select * from leavewords";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<leaveWords> list=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			list=new ArrayList<leaveWords>();
			while(rs.next()){
				leaveWords leavewords=new leaveWords();
				leavewords.setGoodsId(rs.getLong(1));
				leavewords.setUrl(rs.getString(2));
				list.add(leavewords);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}
		finally{DBUtil.release(rs, pst, conn);}
		return list;
	}

	@Override
	public leaveWords findById(long id) {
		// TODO Auto-generated method stub
		String sql="select * from leavewords where GoodsId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		leaveWords leavewords=null;
		
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			pst.setLong(1, id);
			rs = pst.executeQuery();
			leavewords=new leaveWords();
			if( rs.next() ){
				leavewords.setGoodsId(rs.getLong(1));
				leavewords.setUrl(rs.getString(2));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(rs, pst, conn);
		}
		
		return leavewords;
	}

	@Override
	public boolean delById(long id) {
		// TODO Auto-generated method stub
		boolean isComplete=false;
		String sql="delete from leavewords where GoodsId=?";
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
	public void add(leaveWords bidInfo) {
		// TODO Auto-generated method stub
		String sql="insert into leavewords(GoodsId,url) values(?,?)";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setLong(1,bidInfo.getGoodsId());
        	pst.setString(2, bidInfo.getUrl());
        }catch(SQLException e){
        	e.printStackTrace();
			throw new DaoException( e );
        }finally{
        	DBUtil.release(pst, conn);
        }
	}

	@Override
	public void modify(leaveWords bidInfo) {
		// TODO Auto-generated method stub
		String sql="update leavewords set url=? where GoodsId=?";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setLong(2, bidInfo.getGoodsId());
        	pst.setString(1, bidInfo.getUrl());
        	pst.execute();
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{DBUtil.release(pst, conn);}
	}

}
