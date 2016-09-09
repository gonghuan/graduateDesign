package dao;


import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

import util.DBUtil;


import entity.news;
import exception.DaoException;

public class NewsDaoImpl implements INewsDao {

	@Override
	public List<news> findAll() {
		String sql="select * from news";
		Connection conn=null;
		PreparedStatement pst=null;
		ResultSet rs=null;
		List<news> list=null;
		try{
			conn=DBUtil.getConnection();
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			list=new ArrayList<news>();
			while(rs.next()){
				news news=new news();
				news.setNewsId(rs.getLong("newsId"));
				news.setTime(rs.getDate("time"));
				news.setContent(rs.getString("context"));
				news.setHref(rs.getString("href"));
				list.add(news);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
			throw new DaoException(e);
		}
		finally{DBUtil.release(rs, pst, conn);}
		return list;
	}

	@Override
	public boolean deleteById(long id) {
		// TODO Auto-generated method stub
		boolean isComplete=false;
		String sql="delete from news where newsId=?";
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
	public void add(String context,Date time,String href) {
		// TODO Auto-generated method stub
        String sql="insert into news(time,context,href) values(?,?,?)";
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
	public void modifyById(long id,Date time,String context,String href) {
		// TODO Auto-generated method stub
        String sql="update news set time=?,context=?,href=? where newsId=?";
        Connection conn=null;
        PreparedStatement pst=null;
        try{
        	conn=DBUtil.getConnection();
        	pst=conn.prepareStatement(sql);
        	pst.setDate(1, time);
        	pst.setString(2, context);
        	pst.setString(3, href);
        	pst.setLong(4, id);
        	pst.execute();
        }catch(SQLException e){
        	e.printStackTrace();
        	throw new DaoException(e);
        }finally{DBUtil.release(pst, conn);}
	}

}
