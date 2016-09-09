package dao;

import java.util.Date;
import java.util.List;

import entity.GoodsInfo;

public interface ITmpGoodsDao {
  public List<GoodsInfo> findAll();
  public GoodsInfo findById(long id);
  public boolean delByTmpGoodsId(long id);
  public void addTmpGoods(String GoodsName,String GoodsDescription,double BeginPrice,String ImagePath,int Amount,
		  Date BeginTime,Date EndTime,long UserId);
  public void modifyTmpGoods(long GoodsId,String GoodsName,String GoodsDescription,double BeginPrice
		  ,String ImagePath,int Amount,Date BeginTime,Date EndTime,long UserId);
}
