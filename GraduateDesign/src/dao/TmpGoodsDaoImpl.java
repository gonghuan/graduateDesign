package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import entity.GoodsInfo;
import exception.DaoException;

public class TmpGoodsDaoImpl implements ITmpGoodsDao {

	@Override
	public List<GoodsInfo> findAll() {
		// TODO Auto-generated method stub
		String sql = "select * from tempgoods";
		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		List<GoodsInfo> list = null;
		try {
			conn = DBUtil.getConnection();
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();
			
			list = new ArrayList<GoodsInfo>();
			while( rs.next() ){
				GoodsInfo goodsInfo = new GoodsInfo();
				goodsInfo.setGoodsId(rs.getLong("GoodsId"));
				goodsInfo.setAmount(rs.getInt("Amount"));
				goodsInfo.setBeginPrice(rs.getDouble("BeginPrice"));
				goodsInfo.setBeginTime(rs.getTimestamp("BeginTime"));
				goodsInfo.setEndTime(rs.getTimestamp("EndTime"));
				goodsInfo.setGoodsDescription(rs.getString("GoodsDescription"));
				goodsInfo.setGoodsName(rs.getString("GoodsName"));
				goodsInfo.setImagePath(rs.getString("ImagePath"));
				goodsInfo.setUserId(rs.getLong("UserId"));
				list.add(goodsInfo);
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
	public boolean delByTmpGoodsId(long id) {
		// TODO Auto-generated method stub
		String sql="delete from tempgoods where GoodsId=?";
		boolean isComplete=false;
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
	public void addTmpGoods(String GoodsName, String GoodsDescription,
			double BeginPrice, String ImagePath, int Amount, java.util.Date BeginTime,
			java.util.Date EndTime, long UserId) {
		// TODO Auto-generated method stub
        String sql="insert into tempgoods(GoodsName,GoodsDescription,BeginPrice,ImagePath,Amount,BeginTime"
        		+ ",EndTime,UserId) values(?,?,?,?,?,?,?,?)";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst = conn.prepareStatement( sql, 
					Statement.RETURN_GENERATED_KEYS);
        	pst.setString(1, GoodsName);
        	pst.setString(2, GoodsDescription);
        	pst.setDouble(3, BeginPrice);
        	pst.setString(4, ImagePath);
        	pst.setInt(5, Amount);
        	Timestamp beginTime=new Timestamp(BeginTime.getTime());
        	Timestamp endTime=new Timestamp(EndTime.getTime());
        	pst.setTimestamp(6, beginTime);
        	pst.setTimestamp(7, endTime);
        	pst.setLong(8, UserId);
        	pst.executeUpdate();
        	
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{
        	DBUtil.release(pst, conn);
        }
	}

	@Override
	public void modifyTmpGoods(long GoodsId, String GoodsName,
			String GoodsDescription, double BeginPrice, String ImagePath,
			int Amount, java.util.Date BeginTime, java.util.Date EndTime, long UserId) {
		// TODO Auto-generated method stub
        String sql="update tempgoods set GoodsName=?,GoodsDescription=?,BeginPrice=?,ImagePath=?,Amount=?,"
        		+ "BeginTime=?,EndTime=?,UserId=? where GoodsId=?";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setString(1, GoodsName);
        	pst.setString(2, GoodsDescription);
        	pst.setDouble(3, BeginPrice);
        	pst.setString(4, ImagePath);
        	pst.setInt(5,Amount);
        	Timestamp beginTime=new Timestamp(BeginTime.getTime());
        	Timestamp endTime=new Timestamp(EndTime.getTime());
        	pst.setTimestamp(6, beginTime);
        	pst.setTimestamp(7, endTime);
        	pst.setLong(8, UserId);
        	pst.setLong(9, GoodsId);
        	pst.executeUpdate();
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{
        	DBUtil.release(pst, conn);
        }
	}


	@Override
	public GoodsInfo findById(long id) {
		// TODO Auto-generated method stub
		String sql="select * from tempgoods where GoodsId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		GoodsInfo goodsInfo=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			pst.setLong(1, id);
			rs=pst.executeQuery();
			while(rs.next()){
				goodsInfo=new GoodsInfo();
				goodsInfo.setAmount(rs.getInt("Amount"));
				goodsInfo.setBeginPrice(rs.getDouble("BeginPrice"));
				goodsInfo.setBeginTime(rs.getTimestamp("BeginTime"));
				goodsInfo.setEndTime(rs.getTimestamp("EndTime"));
				goodsInfo.setGoodsDescription(rs.getString("GoodsDescription"));
				goodsInfo.setGoodsId(rs.getLong("GoodsId"));
				goodsInfo.setGoodsName(rs.getString("GoodsName"));
				goodsInfo.setImagePath(rs.getString("ImagePath"));
				goodsInfo.setUserId(rs.getLong("UserId"));
			}
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}
		return goodsInfo;
	}

}
