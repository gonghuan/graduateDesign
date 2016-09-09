package controller;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.util.*;
import java.text.SimpleDateFormat;
import java.text.ParseException; 
import java.sql.Date;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.*;
import java.io.*;
import entity.*;
import dao.*;

public class uploadGoods extends HttpServlet {
	 private static final long serialVersionUID = 1L;
	 File imageFile;
	 IGoodsDao uploadgoods=new GoodsDaoImpl();
	 ITmpGoodsDao uploadtemp=new TmpGoodsDaoImpl();
	 protected void doPost(HttpServletRequest request, HttpServletResponse resp) 
	            throws ServletException, IOException { 
	        String requestType = request.getContentType();
	        request.setCharacterEncoding("utf-8");
	        if (requestType != null && requestType.indexOf("multipart/form-data") != -1) { 
	        	DiskFileItemFactory factory = new DiskFileItemFactory();   //创建磁盘工厂
	    		factory.setSizeThreshold(1024 * 1024);
	    		ServletFileUpload upload = new ServletFileUpload(factory);  //创建处理工具
	            upload.setHeaderEncoding("utf-8"); 
	            try { 
					List<FileItem> items = upload.parseRequest(request);
	                Iterator<FileItem> iter = items.iterator(); 
	                //String webRoot = request.getSession().getServletContext().getRealPath("/");
	                String webRoot=request.getSession().getServletContext().getRealPath("/");
	                while (iter.hasNext()) {  
	                    FileItem item = (FileItem) iter.next();
	                    if (!item.isFormField()) { 
	                        String suffix = item.getName().substring(item.getName().lastIndexOf(".")); 
	                        String name = String.valueOf(System.currentTimeMillis()); 
	                        StringBuffer sourcePath = new StringBuffer(); 
	                        sourcePath.append(webRoot); 
	                        sourcePath.append(File.separator); 
	                        sourcePath.append("goodsTmp"); 
	                        sourcePath.append(File.separator); 
	                        sourcePath.append(name); 
	                        sourcePath.append("_source"); 
	                        sourcePath.append(suffix); 
	                        
	                        imageFile= new File(sourcePath.toString()); 
	                        if (!imageFile.getParentFile().exists()) { 
	                            imageFile.getParentFile().mkdirs(); 
	                        } 
	                        item.write(imageFile); 
	                        
	                        JSONObject result = new JSONObject(); 
	                        result.put("result","1"); 
	                        result.put("path", imageFile.getName()); 
	                        /*String result="{\"result\":\"1\",\"path\":"
	                        		+ "\"http://localhost:8080/GraduateDesign/WebRoot/tmp/" +imageFile.getName()
	                        		+"\""+"}";*/ 
	                         //json必须以{"键":"值","键","值"}的形式返回
	                        //resp.setContentType("application/json");
	                        
	                        this.responseJSON(resp, result.toString()); 
	                        /*Object obj=request.getSession().getAttribute("User"); //得到user的信息
	                        if(obj==null){
	                        	request.getSession().setAttribute("User", null);
	                        	request.getRequestDispatcher("login.jsp").forward(request, resp); ;}
	                        else{User user=(User)obj; 
	                             String urlPath=user.getImagePath();
	                             urlPath=urlPath.substring(urlPath.indexOf("/")+1);
	                             if(urlPath!=null){
	                             new File(webRoot+File.separator+"tmp"+File.separator+urlPath).delete();}
	                              } */
	                    } 
	                } 
	            } catch (FileUploadException e) { 
	                // TODO Auto-generated catch block 
	                e.printStackTrace(); 
	            } catch (Exception e) { 
	                // TODO Auto-generated catch block 
	                e.printStackTrace(); 
	            } 
	            
	        } 
	        else { 
	        	java.sql.Date beginTime,endTime;//用于存储拍卖开始时间和结束时间
	        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	            Integer x1 = Integer.parseInt(request.getParameter("x1")); 
	            Integer y1 = Integer.parseInt(request.getParameter("y1")); 
	            Integer x2 = Integer.parseInt(request.getParameter("x2"));
	            Integer y2 = Integer.parseInt(request.getParameter("y2"));
	            Integer width=Integer.parseInt(request.getParameter("width"));
	            Integer height=Integer.parseInt(request.getParameter("height"));
	            String goodsName=request.getParameter("goodsName");
	            Double beginPrice=Double.parseDouble(request.getParameter("beginPrice"));
	            Integer amount=Integer.parseInt(request.getParameter("amount"));
	            String description=request.getParameter("description");
	            String path = request.getParameter("path"); 	           
	            String fileName = path.substring(path.lastIndexOf("/")+1); 
	            String suffix = fileName.substring(fileName.lastIndexOf(".")); 
	               
	            String webRoot = request.getSession().getServletContext().getRealPath("/"); 
	               
	            StringBuffer sourcePath = new StringBuffer(); 
	            sourcePath.append(webRoot); 
	            sourcePath.append(File.separator); 
	            sourcePath.append("goodsTmp"); 
	            sourcePath.append(File.separator); 
	            sourcePath.append(fileName); 
	               
	            StringBuffer targetPath = new StringBuffer(); 
	            targetPath.append(webRoot); 
	            targetPath.append(File.separator); 
	            targetPath.append("goodsTmp"); 
	            targetPath.append(File.separator); 
	            targetPath.append(fileName.substring(0, fileName.lastIndexOf("_"))); 
	            targetPath.append(suffix); 
	               
	            cutImage(suffix.substring(1), sourcePath.toString(), targetPath.toString(),width,height, 
	                    x1, y1, x2, y2); 
	            
	            new File(sourcePath.toString()).delete();
	            Object obj=request.getSession().getAttribute("User"); //得到user的信息，准备写入数据库
                if(obj==null){
                	request.getSession().setAttribute("User", null);
                	request.getRequestDispatcher("login.jsp").forward(request, resp);}
                else{
                	User user=(User)obj;long userId=user.getUserId();
                 user.setImagePath("goodsTmp/"+fileName.substring(0, fileName.lastIndexOf("_"))+suffix);
                 GoodsInfo goods=new GoodsInfo();      //用于写入数据库中的tempgoods表
                 try{
  	               String x=request.getParameter("beginTime");
  	               java.util.Date begintime=sdf.parse(x);
  	               beginTime=new java.sql.Date(begintime.getTime());
  	               String y=request.getParameter("endTime");
  	               java.util.Date endtime=sdf.parse(y);
  	               endTime=new java.sql.Date(endtime.getTime());
  	               goods.setAmount(amount);
                   goods.setBeginPrice(beginPrice);
                   goods.setBeginTime(beginTime);
                   goods.setEndTime(endTime);
                   goods.setGoodsDescription(description);
                   goods.setGoodsName(goodsName);
                   goods.setUserId(userId);
                   goods.setImagePath(user.getImagePath());
                   uploadtemp.addTmpGoods(goodsName, description, beginPrice, user.getImagePath(), 
                		   amount, beginTime, endTime, userId);
                   JSONObject result = new JSONObject(); 
   	               result.put("result", 1); 
   	               result.put("path", "tmp/" + fileName.substring(0, fileName.lastIndexOf("_")) + suffix); 
   	               resp.setContentType("application/json"); 
   	               this.responseJSON(resp, result.toString()); 
  	            }
  	            catch(Exception e){
  	            	 e.printStackTrace(); 
  	            }
                 
                }
	               
	            
	            
	        } 
	    } 
	    protected void responseJSON(HttpServletResponse response, String jsonStr) { 
	        response.setCharacterEncoding("utf-8"); 
	        PrintWriter writer; 
	        try { 
	            writer = response.getWriter(); 
	            writer.write(jsonStr); 
	            writer.flush();
	            writer.close();
	        } catch (IOException e) { 
	        } 
	    } 
	    public static void cutImage(String suffix, String sourcePath, String targetPath, int width,int height,
	            int x1, int y1, int x2, int y2) { 
	        try { 
	            Image img; 
	            ImageFilter cropFilter; 
	            File sourceImgFile = new File(sourcePath); 
	            BufferedImage bi = ImageIO.read(sourceImgFile); 
	            int srcWidth = bi.getWidth(); 
	            int srcHeight = bi.getHeight(); 
	            int destWidth = x2 - x1; 
	            int destHeight = y2 - y1; 
	            if (srcWidth >= destWidth && srcHeight >= destHeight) { 
	                Image image = bi.getScaledInstance(width, height, 
	                        Image.SCALE_DEFAULT);      //进行图像的压缩
	                cropFilter = new CropImageFilter(x1, y1, destWidth, destHeight); 
	                img = Toolkit.getDefaultToolkit().createImage( 
	                        new FilteredImageSource(image.getSource(), cropFilter)); 
	                BufferedImage tag = new BufferedImage(destWidth, destHeight, 
	                        BufferedImage.TYPE_INT_RGB); 
	                Graphics g = tag.getGraphics(); 
	                g.drawImage(img, 0, 0, null); 
	                g.dispose(); 
	                ImageIO.write(tag, suffix, new File(targetPath));                
	            } 
	        } catch (Exception e) { 
	            e.printStackTrace(); 
	        } 
	    } 
	
}
