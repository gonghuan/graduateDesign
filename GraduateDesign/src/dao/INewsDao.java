package dao;

import java.sql.Date;
import java.util.List;

import entity.news;

public interface INewsDao {
  public List<news> findAll();
  public boolean deleteById(long id);
  public void add(String context,Date time,String href);
  public void modifyById(long id,Date time,String context,String href);
}
