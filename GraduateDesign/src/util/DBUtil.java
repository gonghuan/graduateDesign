package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	private static final String driver = "com.mysql.jdbc.Driver";
	private static final String url = "jdbc:mysql://localhost:3306/GraduateDesign?useUnicode=true&characterEncoding=UTF-8";
	private static final String username = "root";
	private static final String pwd = "";
	// 静态代码块，会DBUtil.class被加载到内存的时候，执行这个静态代码块
	// 静态代码块，只会执行一次，驱动也只需要加载一次！
	static{
		try {
			Class.forName( driver );
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException( "驱动加载失败", e );
		}		
	}
	public static Connection getConnection(){
		try {
			return DriverManager.getConnection(url, username, pwd);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException( "获得连接失败", e );
		}
	}
	
	public static void release( ResultSet rs, Statement pst, Connection conn){
		if( rs!=null ){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw new RuntimeException("资源释放失败", e );
			}
		}
		if( pst!=null ){
			try {
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw new RuntimeException( "资源释放失败", e );
			}
		}
		if( conn!=null ){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw new RuntimeException( "资源释放失败", e );
			}
		}
	}
	
	public static void release( Statement pst, Connection conn){
		if( pst!=null ){
			try {
				pst.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw new RuntimeException( "资源释放失败", e );
			}
		}
		if( conn!=null ){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				throw new RuntimeException( "资源释放失败", e );
			}
		}
	}
}
