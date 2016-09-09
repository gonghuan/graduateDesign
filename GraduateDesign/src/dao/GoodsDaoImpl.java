package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.*;

import util.DBUtil;
import entity.GoodsInfo;
import exception.DaoException;

public class GoodsDaoImpl implements IGoodsDao {
  
	@Override
	public GoodsInfo findByGoodsId(long id) {
		
		String sql="select * from goodsinfo where GoodsId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		GoodsInfo goods=new GoodsInfo();
		
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			pst.setLong(1, id);
			rs = pst.executeQuery();
			if( rs.next() ){
				goods=new GoodsInfo();
				goods.setAmount(rs.getInt("Amount"));
				goods.setBeginPrice(rs.getDouble("BeginPrice"));
				goods.setBeginTime(rs.getTimestamp("BeginTime"));
				goods.setEndTime(rs.getTimestamp("EndTime"));
				goods.setGoodsDescription(rs.getString("GoodsDescription"));
				goods.setGoodsName(rs.getString("GoodsName"));
				goods.setImagePath(rs.getString("ImagePath"));
				goods.setUserId(rs.getLong("UserId"));
				
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
	public List<GoodsInfo> findByGoodsName(String name) {
		String sql="select * from goodsinfo where GoodsName like '%"+name+"%'";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<GoodsInfo> list=null;
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			list=new ArrayList<GoodsInfo>();
			while( rs.next() ){
				GoodsInfo goods=new GoodsInfo();
				goods.setGoodsId(rs.getLong("GoodsId"));
				goods.setAmount(rs.getInt("Amount"));
				goods.setBeginPrice(rs.getDouble("BeginPrice"));
				goods.setBeginTime(rs.getDate("BeginTime"));
				goods.setEndTime(rs.getDate("EndTime"));
				goods.setGoodsDescription(rs.getString("GoodsDescription"));
				goods.setGoodsName(rs.getString("GoodsName"));
				goods.setImagePath(rs.getString("ImagePath"));
				goods.setUserId(rs.getLong("UserId"));
				list.add(goods);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(rs, pst, conn);
		}
		
		return list;
		
	}

	@Override
	public GoodsInfo save(GoodsInfo goodsInfo) {
		String sql = "insert into goodsinfo( Amount,GoodsName"
				  + ",BeginPrice,ImagePath,BeginTime,EndTime,UserId"
				  + ",GoodsDescription )"
				  + " values (?,?,?,?,?,?,?,?)";
				Connection conn = null;
				PreparedStatement pst = null;
				ResultSet rs = null;
				try {
					conn = DBUtil.getConnection();
					
                  //pst = conn.prepareStatement(sql);
					
					// 创建可以返回自动生成主键值id 的pst对象
					pst = conn.prepareStatement( sql, 
							Statement.RETURN_GENERATED_KEYS);
					
					pst.setInt(1, goodsInfo.getAmount());
					pst.setString(2, goodsInfo.getGoodsName());
					pst.setDouble(3, goodsInfo.getBeginPrice());
					pst.setString(4, goodsInfo.getImagePath());
					Timestamp BeginTime=new Timestamp(goodsInfo.getBeginTime().getTime());
					Timestamp EndTime=new Timestamp(goodsInfo.getEndTime().getTime());
					pst.setTimestamp(5, BeginTime);
					pst.setTimestamp(6, EndTime);
					pst.setLong(7, goodsInfo.getUserId());
					pst.setString(8, goodsInfo.getGoodsDescription());
					
					int num = pst.executeUpdate();
					if( num!=1 )
						return null;
					
					// 在执行sql语句时，将所生成的主键值直接返回
					// 可以避免再次创建sql语句从db中，再次查询
					
					rs = pst.getGeneratedKeys(); //生成的键值以结果集形式返回
					if( rs.next() )		// 此时只有一个字段是自动生成的，只需要遍历一次
						goodsInfo.setGoodsId( rs.getLong(1) );//"GENERATE_KEY_ID"
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
				return goodsInfo;
	}

	@Override
	public boolean update(GoodsInfo goodsInfo) {
		String sql = "update goodsinfo set GoodsName=?, GoodsDescription=? "
				+ ",BeginPrice=?,ImagePath=?,Amount=?,BeginTime=?"
				+ ",EndTime=?,UserId=?"+ " where GoodsId=?";
		
		Connection conn = null;
		PreparedStatement pst = null;
		
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			
			pst.setString(1, goodsInfo.getGoodsName());
			pst.setString(2, goodsInfo.getGoodsDescription());
			pst.setDouble(3, goodsInfo.getBeginPrice());
			pst.setString(4, goodsInfo.getImagePath());
			pst.setInt(5, goodsInfo.getAmount());
			Timestamp BeginTime=new Timestamp(goodsInfo.getBeginTime().getTime());
			Timestamp EndTime=new Timestamp(goodsInfo.getEndTime().getTime());
			pst.setTimestamp(6, BeginTime);
			pst.setTimestamp(7, EndTime);
			pst.setLong(8, goodsInfo.getUserId());
			pst.setLong(9, goodsInfo.getGoodsId());
			
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
	public List<GoodsInfo> findOnBid() {
		// TODO Auto-generated method stub
		String sql="select * from goodsinfo order by EndTime";
		Connection conn=null;
		PreparedStatement pst=null;
	    ResultSet rs=null;
	    List<GoodsInfo> list=null;
	    try{
	    	conn=DBUtil.getConnection();
	    	pst=conn.prepareStatement(sql);
	    	rs=pst.executeQuery();
	    	list=new ArrayList<GoodsInfo>();
	    	while(rs.next()){
	    		GoodsInfo goods=new GoodsInfo();
	    		Date now=new Date();
	    		Date beginTime=rs.getTimestamp("BeginTime");
	    		Date endTime=rs.getTimestamp("endTime");
	    		if(endTime.getTime()-now.getTime()>0){
	    			goods.setAmount(rs.getInt("Amount"));
	    			goods.setBeginPrice(rs.getDouble("BeginPrice"));
	    			goods.setBeginTime(beginTime);
	    			goods.setEndTime(endTime);
	    			goods.setGoodsDescription(rs.getString("GoodsDescription"));
	    			goods.setGoodsId(rs.getLong("GoodsId"));
	    			goods.setGoodsName(rs.getString("GoodsName"));
	    			goods.setImagePath(rs.getString("ImagePath"));
	    			goods.setUserId(rs.getLong("UserId"));
	    			list.add(goods);
	    		}
	    	}
	    }catch(SQLException e){
	    	e.printStackTrace();
	    	throw new DaoException(e);
	    }finally{
	    	DBUtil.release(rs, pst, conn);
	    }
	    
		return list;
	}

}
