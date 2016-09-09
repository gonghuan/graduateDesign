package dao;

import java.sql.Date;
import java.util.List;

import entity.Notice;

public interface INoticeDao {
	 public List<Notice> findAll();
	  public boolean deleteById(int id);
	  public void add(String context,Date time,String href);
	  public void modifyById(int id,Date time,String context,String href);
}
