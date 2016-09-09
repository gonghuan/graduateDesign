package dao;

import java.util.List;

import entity.BidInfo;

public interface IBidInfoDao {
  public List<BidInfo> findAll();
  public BidInfo findById(long id);
  public boolean delById(long id);
  public void add(BidInfo bidInfo);
  public void modify(BidInfo bidInfo);
}
