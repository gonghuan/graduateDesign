package dao;

import entity.GoodsInfo;
import java.util.List;

public interface IGoodsDao {
	
	public GoodsInfo findByGoodsId(long id);
	public List<GoodsInfo> findByGoodsName(String name);
	public GoodsInfo save(GoodsInfo goodsInfo);
	public boolean update( GoodsInfo goodsInfo );
	public List<GoodsInfo> findOnBid();
}
