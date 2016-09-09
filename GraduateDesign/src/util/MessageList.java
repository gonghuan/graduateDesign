package util;

import java.util.Iterator;  
import java.util.concurrent.LinkedBlockingQueue; 

public class MessageList {
	 private static MessageList list = null;             //创建静态的信息链，本质上是个阻塞队列
	 private static Object key = new Object();  
	  
	    private MessageList() {  
	        
	    }  
	  
	    public static MessageList getInstance() {  
	        synchronized (key) {  
	            if (list == null) {
	                list = new MessageList();  
	            }  
	            return list;  
	        }  
	    }  
	  
	    private LinkedBlockingQueue<String> queue = new LinkedBlockingQueue<String>();  
	  
	    public boolean isEmpty() {  
	        return queue.isEmpty();  
	    }  
	  
	    public int size() {  
	        return queue.size();  
	    }  
	  
	    public String get() {  
	        try {  
	        	return queue.take();  
	        } catch (InterruptedException e) {  
	            e.printStackTrace();  
	            return null;  
	        }  
	    }  
	    
	    public String getNotDel(){
	    	try {  
	        	return queue.peek();  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	            return null;  
	        }  
	    }
	  
	    public void clear() {  
	        queue.clear();  
	    }  
	  
	    public void add(String msg) {  
	        try {  
	            queue.put(msg);  
	        } catch (InterruptedException e) {  
	            e.printStackTrace();  
	        }  
	    }  
	  
	    public Iterator<String> iterator() {  
	        return queue.iterator();  
	    }  
	    
	    public int getLength(){
	    	return queue.size();
	    }
}
