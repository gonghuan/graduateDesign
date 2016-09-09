package dao;

import java.util.List;
import java.sql.Date;
import entity.OfflineInfo;

public interface IOfflineInfoDao {
  public List<OfflineInfo> findAll();
  public void add(String previewName,Date previewBegin,Date previewEnd,String previewProvince,
		  String previewLocate,String name,java.util.Date time,String locate);
  public boolean del(long id);
  public void modify(long id,String previewName,Date previewBegin,Date previewEnd,String previewProvince,
		  String previewLocate,String name,java.util.Date time,String locate);
}
