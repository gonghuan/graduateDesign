package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import entity.BidInfo;
import exception.DaoException;

public class BidInfoDaoImpl implements IBidInfoDao {

	@Override
	public List<BidInfo> findAll() {
		String sql="select * from bidforgoods";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<BidInfo> list=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			list=new ArrayList<BidInfo>();
			while(rs.next()){
				BidInfo bidInfo=new BidInfo();
				bidInfo.setGoodsId(rs.getLong(1));
				bidInfo.setUrl(rs.getString(2));
				list.add(bidInfo);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}
		finally{DBUtil.release(rs, pst, conn);}
		return list;
	}

	@Override
	public BidInfo findById(long id) {
		String sql="select * from bidforgoods where GoodsId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		BidInfo goods=null;
		
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			pst.setLong(1, id);
			rs = pst.executeQuery();
			goods=new BidInfo();
			if( rs.next() ){
				goods.setGoodsId(rs.getLong(1));
				goods.setUrl(rs.getString(2));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(rs, pst, conn);
		}
		
		return goods;
	}

	@Override
	public boolean delById(long id) {
		// TODO Auto-generated method stub
		boolean isComplete=false;
		String sql="delete from bidforgoods where GoodsId=?";
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
	public void add(BidInfo bidInfo) {
		// TODO Auto-generated method stub
        String sql="insert into bidforgoods(GoodsId,url) values(?,?)";
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
	public void modify(BidInfo bidInfo) {
		// TODO Auto-generated method stub
		 String sql="update bidforgoods set url=? where GoodsId=?";
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
