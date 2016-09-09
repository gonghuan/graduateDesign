package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import entity.BidInfo;
import entity.GoodsInfo;
import entity.Staff;
import entity.User;
import entity.leaveWords;
import service.*;
import util.MessageList;

public class UserAction {
IUserService userService = new UserServiceImpl();
	
	protected void login(HttpServletRequest request,
				HttpServletResponse response)
			throws ServletException, IOException {
		// 从请求中取得传过来的参数
		String email = request.getParameter("email").trim();
		String password = request.getParameter("password").trim();
		String type=request.getParameter("type");
		// 调用业务类中方法，进行登陆判断
		if(type.equals("用户")){
		User user = userService.login(email, password);
		if( user==null ){	//登陆失败，让用户重新登陆
			//页面的重定向
			request.setAttribute("message", "账号或密码错误");
	        request.getRequestDispatcher("error.jsp").forward(request, response);
		}else{				//登陆成功，转向WEB-INF/jsp/index.jsp页面
			// 将 用户user绑定到 会话中的 loginUser 属性上！
			
			request.getSession().setAttribute("User", user);
			// 请求的转发
			
			request.getRequestDispatcher("index.jsp")
				.forward(request, response);
		}
		
		}
		else{
			Staff staff=userService.staffLogin(email, password);
			if(staff==null){
				request.setAttribute("message","账号或密码错误");
				request.getRequestDispatcher("error.jsp").forward(request,response);
			}
			else{
				request.getSession().setAttribute("Staff",staff);
				request.getRequestDispatcher("Management.jsp").forward(request, response);
			}
		}
		
	}
	

	public void register(HttpServletRequest request,
					HttpServletResponse response)
			throws ServletException, IOException {

		// 从表单页面中取得参数
		User user = new User();
		String email = request.getParameter("email").trim();
		user.seteMail( email );
		user.setUserName( request.getParameter("userName"));
		user.setTruName( request.getParameter("truName"));
		user.setPassword( request.getParameter("password1").trim() );
		user.setAddress( request.getParameter("address"));
		user.setTelephone(request.getParameter("telephone").trim());
		user.setPostBoy(request.getParameter("postBoy").trim());
		user.setPassHint(request.getParameter("passHint"));
		/*String str = request.getParameter("birthday");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date birthday = sdf.parse(str);
			user.setBirthday(birthday);
		} catch (ParseException e) {
			e.printStackTrace();
			throw new RuntimeException( "生日的日期解析失败！", e );
		}*/

		// 调用 业务方法去注册
		user = userService.register( user );
		
		// 根据业务方法所返回结果，进行页面的转向
		if( user==null ){
			//页面的重定向
			request.setAttribute("message", "此邮箱 "+email+" 已经注册，请直接登陆！");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}else{				//登陆成功，转向WEB-INF/jsp/index.jsp页面
			// 将 用户user绑定到 会话中的 loginUser 属性上！
			//request.getSession().setAttribute("User", user);
			// 请求的转发
			request.getRequestDispatcher("login.jsp")
				.forward(request, response);   
		}     
	}
	
	
	public void modify(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException, IOException {
		String password=request.getParameter("password1");
		User testUser=new User();
		boolean ifsuc;  //用来判断是否正确的修改
		
		User user=new User();
		
		user.setTelephone(request.getParameter("telephone").trim());
		user.setUserId(Long.parseLong((request.getParameter("userId"))));
		user.setAddress(request.getParameter("address"));
		user.seteMail(request.getParameter("email").trim());
		user.setPassHint(request.getParameter("passHint"));
		user.setPostBoy(request.getParameter("postBoy").trim());
		user.setTruName(request.getParameter("truName"));
		user.setUserName(request.getParameter("userName"));
		
		testUser=(User)request.getSession().getAttribute("User"); //用来测试输入的旧密码是否正确
		if(password.length()!=0 && testUser.getPassword().equals(password)!=false 
				&& request.getParameter("password2").length()!=0){  //输入了旧密码并且正确
			user.setPassword(request.getParameter("password2").trim());
			ifsuc= userService.modify(user);
			if(ifsuc==false){
				request.setAttribute("message", "发生未知错误，请保证输入正确，重新尝试");
				request.getRequestDispatcher("error.jsp").forward(request, response);   
			}
			else{
				request.getSession().setAttribute("User", user);
			    request.getRequestDispatcher("UserInfo.jsp").forward(request, response); }
		}
		else{
			if(password.length()!=0&&testUser.getPassword().equals(password)==false){
				request.setAttribute("message", "旧密码输入错误");
				request.getRequestDispatcher("error.jsp").forward(request, response);  
			}
			else if(password.length()!=0&&testUser.getPassword().equals(password)==true
					&&request.getParameter("password2").length()==0){
				request.setAttribute("message", "新密码不能为空");
				request.getRequestDispatcher("error.jsp").forward(request, response); 
			}
			else if(password.length()==0 && request.getParameter("password2").length()==0)
			{
				user.setPassword(testUser.getPassword());
				ifsuc= userService.modify(user);
				if(ifsuc==false){
					request.setAttribute("message", "发生未知错误，请保证输入正确，重新尝试");
					request.getRequestDispatcher("error.jsp").forward(request, response);   
				}
				else{
					request.getSession().setAttribute("User", user);
				    request.getRequestDispatcher("UserInfo.jsp").forward(request, response);
				    }
			}
			else{request.setAttribute("message", "必须先验证旧密码是否正确");
			request.getRequestDispatcher("error.jsp").forward(request, response); 
			}
		}
		
	}
	public void search(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException, IOException {
		String searchName=request.getParameter("search_text").trim();
		List<GoodsInfo> list=new ArrayList<GoodsInfo>();
		list=userService.search(searchName);
		request.getSession().setAttribute("Goods", list);
		// 请求的转发
		request.getRequestDispatcher("SearchResult.jsp")
			.forward(request, response);
	}


	public void loadBid(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String id=request.getParameter("id");
		try{
			long GoodsId=Long.parseLong(id);
			BidInfo bidInfo=userService.loadBidInfo(GoodsId);
			if(bidInfo.getGoodsId()==0){
				
			}else{
				String url=bidInfo.getUrl();
				url=request.getSession().getServletContext().getRealPath("/")+url;
				File file=new File(url);
				Scanner scanner=null;
				StringBuffer buffer=new StringBuffer();
				JSONObject json1=new JSONObject();
				try{
					scanner = new Scanner(file, "utf-8");
					while(scanner.hasNext()){
						buffer.append(scanner.nextLine());
					}
					json1=JSONObject.fromString(buffer.toString());
					JSONArray array=json1.getJSONArray("record");
				PrintWriter pw=response.getWriter();
				pw.print(array.toString());
				pw.close();
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					 if (scanner != null) {
			                scanner.close();
			            }
					 
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}


	public void bidForGoods(HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		// TODO Auto-generated method stub
		long goodsId=Long.parseLong(request.getParameter("goodsId"));
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		double price=Double.parseDouble(request.getParameter("price"));
		String time=request.getParameter("time");
		BidInfo bidInfo=userService.loadBidInfo(goodsId);
		JSONObject rep=new JSONObject();     //用于返回的json数据
		JSONObject json=new JSONObject();
		JSONObject jsons=new JSONObject();
		json.put("bidderId", id);
		json.put("bidder", name);
		json.put("price", price);
		json.put("daytime", time);
		if(bidInfo!=null){
		String url=bidInfo.getUrl();
		url=request.getSession().getServletContext().getRealPath("/")+url;
		try{
		File file=new File(url);
		if(!file.exists()){   
			 jsons.put("record", json);
			 file.createNewFile();            //创建文件
			 FileOutputStream out=new FileOutputStream(file);    //本地文件写入流
			 out.write(jsons.toString().getBytes("utf-8"));      //通过比特流形式写入文件中
			 out.close();
			 rep.put("success", true);
		}else{
			Scanner scanner=new Scanner(file,"utf-8");
			StringBuffer buffer=new StringBuffer();
			while(scanner.hasNext()){
				buffer.append(scanner.nextLine());
			}
			scanner.close();
			JSONObject json1=new JSONObject();
			json1=JSONObject.fromString(buffer.toString());
			JSONArray array=json1.getJSONArray("record");
			array.put(json);
			jsons.put("record", array);
			FileOutputStream out=new FileOutputStream(file);
			out.write(jsons.toString().getBytes("utf-8"));
			out.close();
			rep.put("success", true);
		}
		}catch(Exception e){
			e.printStackTrace();
			rep.put("success", false);
		}
		}else{
			String url="bidInfo/"+goodsId+".json";
			long Id=Long.parseLong(id);
			userService.addBidInfo(Id, url);
			jsons.put("record", json);
			File file=new File(url);
			try{
			 file.createNewFile();            //创建文件
			 FileOutputStream out=new FileOutputStream(file);    //本地文件写出流
			 out.write(jsons.toString().getBytes("utf-8"));      //通过比特流形式写入文件中
			 out.close();
			 rep.put("success", true);
			 }catch(Exception e){
				 e.printStackTrace();
				rep.put("success", false);
			 }
		}
		
		PrintWriter pw;
		try {
			pw = response.getWriter();
			pw.print(rep.toString());
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


	public void loadWords(HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		// TODO Auto-generated method stub
		 String id=request.getParameter("id");
		 MessageList m = MessageList.getInstance();  
		 boolean end = false;
		 JSONArray array=new JSONArray();
		 int i=0;
		 while(!end){
			 String msg = m.get();
			 JSONObject json=JSONObject.fromString(msg);
			 String goodsId=(String)json.get("id");
			 Date date=new Date();
			 if(id.equals(goodsId)){
			   String str=json.getString("time");
			   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   Date time=sdf.parse(str);
			   if(date.getTime()-time.getTime()>=5000){
			   }
			   else{
				 m.add(msg); 
			     json.remove("id");
			     array.put(json.toString());
			   }
			 }else{
				m.add(msg);
			 }
			 i++;
			 if (i>=m.getLength()) {  
	              end = true;  
	            }  
		   
		 }
		 PrintWriter pw;
			try {
				pw = response.getWriter();
				pw.print(array.toString());
				pw.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
	}


	public void transWords(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		String id=request.getParameter("id");
		long GoodsId=Long.parseLong(id);
		String time=request.getParameter("time");
		String name=request.getParameter("name");
		String text=request.getParameter("text");
		String userId=request.getParameter("userId");
		JSONObject json=new JSONObject();
		JSONObject json1=new JSONObject();
		JSONObject jsons=new JSONObject();
		json.put("id", id);
		json.put("time", time);
		json.put("name", name);
		json.put("text", text);
		json.put("userId", userId);
		leaveWords words=userService.loadLeaveWords(GoodsId);
		if(words!=null){
		String url=words.getUrl();
		url=request.getSession().getServletContext().getRealPath("/")+url;
		if(json.toString()!=null){
		  MessageList list=MessageList.getInstance();
		  list.add(json.toString());  
		  try{
			    File file=new File(url);
				if(!file.exists()){  
					jsons.put("record", json);
					file.createNewFile();            //创建文件
					FileOutputStream out=new FileOutputStream(file);
					out.write(jsons.toString().getBytes("utf-8"));      //通过比特流形式写入文件中
					out.close();
				}
				else{
					Scanner scanner=new Scanner(file,"utf-8");
					StringBuffer buffer=new StringBuffer();
					while(scanner.hasNext()){
						buffer.append(scanner.nextLine());
					}
					scanner.close();
					JSONObject json2=new JSONObject();
					json2=JSONObject.fromString(buffer.toString());
					JSONArray array=json2.getJSONArray("record");
					array.put(json);
					jsons.put("record", array);
					FileOutputStream out=new FileOutputStream(file);
					out.write(jsons.toString().getBytes("utf-8"));
					out.close();
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		}else{
			String url="leaveWords/"+id+".json";
			long Id=Long.parseLong(id);
			userService.addLeaveWords(Id, url);;
			jsons.put("record", json);
			MessageList list=MessageList.getInstance();
			list.add(json.toString());  
			File file=new File(url);
			try{
			 file.createNewFile();            //创建文件
			 FileOutputStream out=new FileOutputStream(file);    //本地文件写出流
			 out.write(jsons.toString().getBytes("utf-8"));      //通过比特流形式写入文件中
			 out.close();
			 }catch(Exception e){
				 e.printStackTrace();
			 }
		}
		json1.put("success", true);
		PrintWriter pw;
		try {
			pw = response.getWriter();
			pw.print(json1.toString());
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
