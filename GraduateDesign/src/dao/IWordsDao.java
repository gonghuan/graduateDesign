package dao;

import java.util.List;

import entity.leaveWords;

public interface IWordsDao {
	 public List<leaveWords> findAll();
	  public leaveWords findById(long id);
	  public boolean delById(long id);
	  public void add(leaveWords bidInfo);
	  public void modify(leaveWords bidInfo);
}
