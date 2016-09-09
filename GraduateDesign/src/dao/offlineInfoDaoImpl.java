package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import entity.OfflineInfo;
import exception.DaoException;

public class offlineInfoDaoImpl implements IOfflineInfoDao {

	@Override
	public List<OfflineInfo> findAll() {
		String sql="select * from offlineInfo";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<OfflineInfo> list=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			list=new ArrayList<OfflineInfo>();
			while(rs.next()){
				OfflineInfo offlineInfo=new OfflineInfo();
				offlineInfo.setId(rs.getLong("id"));
				offlineInfo.setPreviewName(rs.getString("previewName"));
				offlineInfo.setPreviewBegin(rs.getDate("previewBegin"));
				offlineInfo.setPreviewEnd(rs.getDate("previewEnd"));
				offlineInfo.setPreviewProvince(rs.getString("previewProvince"));
				offlineInfo.setPreviewLocate(rs.getString("previewLocate"));
				offlineInfo.setName(rs.getString("name"));
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				try{
				java.util.Date time=rs.getTimestamp("time");
				String str=df.format(time);
				java.util.Date Time=df.parse(str);
				offlineInfo.setTime(Time);
				}
				catch(Exception e){e.printStackTrace();}
				offlineInfo.setLocate(rs.getString("locate"));
				list.add(offlineInfo);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}
		finally{DBUtil.release(rs, pst, conn);}
		return list;
	}

	@Override
	public void add(String previewName,Date previewBegin,Date previewEnd,String previewProvince,
			  String previewLocate,String name,java.util.Date time,String locate) {
		// TODO Auto-generated method stub
		String sql="insert into offlineInfo(previewName,previewBegin,previewEnd,previewProvince,previewLocate,"
				+ "name,time,locate) values(?,?,?,?,?,?,?,?)";
        Connection conn=null;
        PreparedStatement pst=null;
        try {
			conn = DBUtil.getConnection();
			
            //pst = conn.prepareStatement(sql);
			
			// 创建可以返回自动生成主键值id 的pst对象
			pst = conn.prepareStatement( sql, 
					Statement.RETURN_GENERATED_KEYS);
			
			pst.setString(1,previewName);
			pst.setDate(2, previewBegin);
			pst.setDate(3, previewEnd);
			pst.setString(4, previewProvince);
			pst.setString(5,previewLocate);
			pst.setString(6, name);
			Timestamp times = new Timestamp(time.getTime());
			pst.setTimestamp(7, times);
			pst.setString(8, locate);
			
			pst.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DaoException( e );
		} finally {
			DBUtil.release(pst, conn);
		}
	}

	@Override
	public boolean del(long id) {
		boolean isComplete=false;
		String sql="delete from offlineInfo where id=?";
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
	public void modify(long id, String previewName, Date previewBegin,
			Date previewEnd, String previewProvince, String previewLocate,
			String name, java.util.Date time, String locate) {
		// TODO Auto-generated method stub
        String sql="update offlineInfo set previewName=?,previewBegin=?,previewEnd=?,previewProvince=?,"
        		+ "previewLocate=?,name=?,time=?,locate=? where id=?";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setString(1, previewName);
        	pst.setDate(2, previewBegin);
        	pst.setDate(3, previewEnd);
        	pst.setString(4, previewProvince);
        	pst.setString(5, previewLocate);
        	pst.setString(6, name);
        	Timestamp times = new Timestamp(time.getTime());
        	pst.setTimestamp(7, times);
        	pst.setString(8, locate);
        	pst.setLong(9, id);
        	pst.executeUpdate();
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{DBUtil.release(pst, conn);}
	}

}
