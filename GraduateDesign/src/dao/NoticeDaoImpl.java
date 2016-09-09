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
import entity.Notice;
import exception.DaoException;

public class NoticeDaoImpl implements INoticeDao {

	@Override
	public List<Notice> findAll() {
		String sql="select * from notice";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<Notice> list=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			list=new ArrayList<Notice>();
			while(rs.next()){
				Notice notice=new Notice();
				notice.setNoticeId(rs.getInt("noticeId"));
				notice.setContext(rs.getString("context"));
				notice.setHref(rs.getString("href"));
				notice.setTime(rs.getDate("time"));
				list.add(notice);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}
		finally{DBUtil.release(rs, pst, conn);}
		return list;
	}

	@Override
	public boolean deleteById(int id) {
		// TODO Auto-generated method stub
		boolean isComplete=false;
		String sql="delete from notice where noticeId=?";
		Connection conn=null;
		PreparedStatement pst=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			pst.setInt(1, id);;
			pst.executeUpdate();
			isComplete=true;
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}finally{DBUtil.release(pst, conn);}
		return isComplete;
	}

	@Override
	public void add(String context, Date time, String href) {
		// TODO Auto-generated method stub
		 String sql="insert into notice(time,context,href) values(?,?,?)";
	        Connection conn=null;
	        PreparedStatement pst=null;
	        try {
				conn = DBUtil.getConnection();
				
	            //pst = conn.prepareStatement(sql);
				
				// 创建可以返回自动生成主键值id 的pst对象
				pst = conn.prepareStatement( sql, 
						Statement.RETURN_GENERATED_KEYS);
				
				pst.setDate(1, time);
				pst.setString(2, context);
				pst.setString(3, href);
				pst.executeUpdate();
			
			} catch (SQLException e) {
				e.printStackTrace();
				throw new DaoException( e );
			} finally {
				DBUtil.release(pst, conn);
			}
	}

	@Override
	public void modifyById(int id, Date time, String context, String href) {
		// TODO Auto-generated method stub
		String sql="update notice set time=?,context=?,href=? where noticeId=?";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setDate(1, time);
        	pst.setString(2, context);
        	pst.setString(3, href);
        	pst.setInt(4, id);
        	pst.execute();
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{DBUtil.release(pst, conn);}
	}

}
