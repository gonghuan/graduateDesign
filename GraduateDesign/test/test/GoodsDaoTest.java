package test;

import static org.junit.Assert.*;

import java.util.Iterator;
import java.util.List;

import org.junit.Test;

import dao.*;
import entity.GoodsInfo;

public class GoodsDaoTest {
    IGoodsDao dao=new GoodsDaoImpl();
	@Test
	public void test() {
		List<GoodsInfo> list=dao.findByGoodsName("紫砂壶");
		Iterator<GoodsInfo> a=list.iterator();
		while(a.hasNext()){
		System.out.println(a.next().getGoodsName());}
	}

}
