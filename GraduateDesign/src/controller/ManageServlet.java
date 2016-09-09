package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GoodsDaoImpl;
import dao.IGoodsDao;
import service.IManageService;
import service.ManageServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import entity.*;



public class ManageServlet extends HttpServlet{
	IManageService user=new ManageServiceImpl();
	IGoodsDao goods=new GoodsDaoImpl();
	protected void service(HttpServletRequest request,HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String path = request.getServletPath();
		// 截取得到 功能名ss
		int index1 = path.lastIndexOf("/")+1;
		int index2 = path.lastIndexOf(".manageAction");
		String actionName = path.substring(index1,index2);
		uploadStaff  upload=new uploadStaff();
		// 根据不同的功能名，调用不同的 action 处理类中的方法
		try{
			if(actionName.equals("load")){                      //当是加载事件时
				List<User> list=new ArrayList<User>();
				list=user.load();
				
				JSONArray array = new JSONArray();
				JSONObject member=null;
				
				for(int i=0;i<list.size();i++)
				{
					member=new JSONObject();
					member.put("id", list.get(i).getUserId());
					member.put("nickName", list.get(i).getUserName());
					member.put("name", list.get(i).getTruName());
					member.put("Email", list.get(i).geteMail());
					member.put("telephone", list.get(i).getTelephone());
					member.put("address",list.get(i).getAddress());
					member.put("postBoy", list.get(i).getPostBoy());
					array.put(member);
				}
				
				PrintWriter pw;
				try{
					pw = response.getWriter();
				    pw.print(array.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
			else if(actionName.equals("del")){                           //是删除事件时
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						long id=Long.parseLong(ids[i]);
						user.delete(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
			
			else if(actionName.equals("modify"))
			{
				JSONObject json=new JSONObject();
				try{
				long id=Long.parseLong(request.getParameter("id"));
				String name=request.getParameter("name");
				String nickName=request.getParameter("nickName");
				String email=request.getParameter("email").trim();
				String telephone=request.getParameter("telephone").trim();
				String postBoy=request.getParameter("postBoy").trim();
				String address=request.getParameter("address");
				user.modifyById(id, email, name, nickName, telephone, postBoy, address);
				json.put("success", true);
				}catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
			else if(actionName.equals("loadNews")){
				List<news> list=new ArrayList<news>();
				list=user.loadNews();
				
				JSONArray array = new JSONArray();
				JSONObject member=null;
				
				for(int i=0;i<list.size();i++)
				{
					member=new JSONObject();
					long x=list.get(i).getNewsId();
					String STR_FORMAT = "000000000000";
					DecimalFormat df = new DecimalFormat(STR_FORMAT);  
					member.put("id",df.format(x));
					member.put("context", list.get(i).getContent());
					member.put("time", list.get(i).getTime().toString());
					member.put("href", list.get(i).getHref());
					array.put(member);
				}
				
				PrintWriter pw;
				try{
					pw = response.getWriter();
				    pw.print(array.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("delNews")){
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						long id=Long.parseLong(ids[i]);
						user.deleteById(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("addNews")){
				JSONObject json=new JSONObject();
				try{
					String context=request.getParameter("context");
					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
					java.util.Date Time=df.parse(request.getParameter("time"));
					SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
					String str=df2.format(Time);
					Time=df2.parse(str);
					Date time=new Date(Time.getTime());
					String href=request.getParameter("href");
					user.add(context,time,href);
					json.put("success", true);
				}catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("modifyNews")){
				JSONObject json=new JSONObject();
				try{
				long id=Long.parseLong(request.getParameter("id"));
				String context=request.getParameter("context");
				SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
				java.util.Date Time=df.parse(request.getParameter("time"));
				SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
				String str=df2.format(Time);
				Time=df2.parse(str);
				Date time=new Date(Time.getTime());
				String href=request.getParameter("href");
				user.modifyById(id, time, context, href);
				json.put("success", true);
				}catch(Exception e)
				{e.printStackTrace();
				json.put("success", false);}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("loadNotice")){
				List<Notice> list=new ArrayList<Notice>();
				list=user.loadNotice();
				JSONArray array = new JSONArray();
				JSONObject member=null;
				
				for(int i=0;i<list.size();i++)
				{
					member=new JSONObject();
					int x=list.get(i).getNoticeId();
					String STR_FORMAT = "00000000";
					DecimalFormat df = new DecimalFormat(STR_FORMAT);  
					member.put("id",df.format(x));
					member.put("context", list.get(i).getContext());
					member.put("time", list.get(i).getTime().toString());
					member.put("href", list.get(i).getHref());
					array.put(member);
				}
				
				PrintWriter pw;
				try{
					pw = response.getWriter();
				    pw.print(array.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("delNotice")){
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						int id=Integer.parseInt(ids[i]);
						user.deleteById(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("addNotice")){
				JSONObject json=new JSONObject();
				try{
					String context=request.getParameter("context");
					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
					java.util.Date Time=df.parse(request.getParameter("time"));
					SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
					String str=df2.format(Time);
					Time=df2.parse(str);
					Date time=new Date(Time.getTime());
					String href=request.getParameter("href");
					user.addNotice(context, time, href);
					json.put("success", true);
				}catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("modifyNotice")){
				JSONObject json=new JSONObject();
				try{
				int id=Integer.parseInt(request.getParameter("id"));
				String context=request.getParameter("context");
				SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
				java.util.Date Time=df.parse(request.getParameter("time"));
				SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
				String str=df2.format(Time);
				Time=df2.parse(str);
				Date time=new Date(Time.getTime());
				String href=request.getParameter("href");
				user.modifyById(id, time, context, href);
				json.put("success", true);
				}catch(Exception e)
				{e.printStackTrace();
				json.put("success", false);}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("uploadStaffImg")){
				upload.doPost(request, response);
			}
			else if(actionName.equals("uploadStaff")){
				JSONObject json=new JSONObject();
				try{
				String imagePath=request.getParameter("imagePath");
				String name=request.getParameter("name");
				String sex=request.getParameter("sex");
				String nation=request.getParameter("nation");
				String origin=request.getParameter("province")+" "+request.getParameter("city");
				SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
				java.util.Date Time=df.parse(request.getParameter("birthday"));
				SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
				String str=df2.format(Time);
				Time=df2.parse(str);
				Date birthday=new Date(Time.getTime());
				String isMarried=request.getParameter("isMarried");
				String identification=request.getParameter("identification");
				String telephone=request.getParameter("telephone");
				java.util.Date Time2=df.parse(request.getParameter("entry"));
				df2 = new SimpleDateFormat("yy-MM-dd");
				str=df2.format(Time2);
				Time2=df2.parse(str);
				Date entry=new Date(Time2.getTime());
				String department=request.getParameter("department");
				String position=request.getParameter("position");
				int priority=Integer.parseInt(request.getParameter("priority"));
				String email=request.getParameter("email");
				String password=request.getParameter("password");
				String address=request.getParameter("address");
				user.addStaff(name, sex, nation, origin, birthday, isMarried, identification, telephone, 
						address, entry, department, position, priority, imagePath, email, password);
				json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("loadStaff")){
				
				List<Staff> list=new ArrayList<Staff>();
				list=user.loadStaff();
				JSONArray array = new JSONArray();
				JSONObject member=null;
				
				for(int i=0;i<list.size();i++)
				{
					member=new JSONObject();
					int x=list.get(i).getId();
					String STR_FORMAT = "00000000";
					DecimalFormat df = new DecimalFormat(STR_FORMAT);  
					member.put("id",df.format(x));
					member.put("name", list.get(i).getName());
					member.put("sex", list.get(i).getSex());
					member.put("telephone", list.get(i).getTelephone());
					member.put("email", list.get(i).getEmail());
					member.put("entry", list.get(i).getEntry().toString());
					member.put("department", list.get(i).getDepartment());
					member.put("position", list.get(i).getPosition());
					array.put(member);
				}
				
				PrintWriter pw;
				try{
					pw = response.getWriter();
				    pw.print(array.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
			else if(actionName.equals("delStaff")){
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						int id=Integer.parseInt(ids[i]);
						user.deleteByStaffId(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("loadStaffByEmail")){
				String email=request.getParameter("email");
				JSONObject json=new JSONObject();
				Staff staff=new Staff();
				staff=user.loadStaffByEmail(email);
				json.put("id", String.valueOf(staff.getId()));
				json.put("name", staff.getName());
				json.put("sex", staff.getSex());
				json.put("nation", staff.getNation());
				json.put("origin", staff.getOrigin());
				json.put("birthday", staff.getBirthday().toString());
				json.put("isMarried", staff.getIsMarried());
				json.put("identification", staff.getIdentification());
				json.put("telephone", staff.getTelephone());
				json.put("entry", staff.getEntry().toString());
				json.put("department",staff.getDepartment());
				json.put("position", staff.getPosition());
				json.put("priority", String.valueOf(staff.getPriority()));
				json.put("email", staff.getEmail());
				json.put("address",staff.getAddress());
				json.put("password", staff.getPassword());
				json.put("imagePath", staff.getImagePath());
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("modifyStaff")){
				JSONObject json=new JSONObject();
				try{
			    int id=Integer.parseInt(request.getParameter("id"));
				String imagePath=request.getParameter("imagePath");
				String name=request.getParameter("name");
				String sex=request.getParameter("sex");
				String nation=request.getParameter("nation");
				String origin=request.getParameter("province")+" "+request.getParameter("city");
				SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
				java.util.Date Time=df.parse(request.getParameter("birthday"));
				SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
				String str=df2.format(Time);
				Time=df2.parse(str);
				Date birthday=new Date(Time.getTime());
				String isMarried=request.getParameter("isMarried");
				String identification=request.getParameter("identification");
				String telephone=request.getParameter("telephone");
				java.util.Date Time2=df.parse(request.getParameter("entry"));
				df2 = new SimpleDateFormat("yy-MM-dd");
				str=df2.format(Time2);
				Time2=df2.parse(str);
				Date entry=new Date(Time2.getTime());
				String department=request.getParameter("department");
				String position=request.getParameter("position");
				int priority=Integer.parseInt(request.getParameter("priority"));
				String email=request.getParameter("email");
				String password=request.getParameter("password");
				String address=request.getParameter("address");
				user.modifyByStaffId(id, name, sex, nation, origin, birthday, isMarried, identification, 
					telephone, address, entry, department, position, priority, imagePath, email, password);
				json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("loadOfflineInfo")){
				List<OfflineInfo> list=new ArrayList<OfflineInfo>();
				list=user.loadOfflineInfo();
				JSONArray array = new JSONArray();
				JSONObject member=null;
				
				for(int i=0;i<list.size();i++)
				{
					member=new JSONObject();
					long x=list.get(i).getId();
					String STR_FORMAT = "000000000000";
					DecimalFormat df = new DecimalFormat(STR_FORMAT);  
					member.put("id",df.format(x));
					member.put("name", list.get(i).getName());
					member.put("previewBegin", list.get(i).getPreviewBegin().toString());
					member.put("previewEnd", list.get(i).getPreviewEnd().toString());
					member.put("previewProvince", list.get(i).getPreviewProvince());
					member.put("previewName", list.get(i).getPreviewName());
					member.put("previewLocate", list.get(i).getPreviewLocate());
					java.util.Date time=list.get(i).getTime();
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String str=sdf.format(time);
					member.put("time", str);
					member.put("locate", list.get(i).getLocate());
					array.put(member);
				}
				
				PrintWriter pw;
				try{
					pw = response.getWriter();
				    pw.print(array.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("delOfflineInfo")){
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						long id=Long.parseLong(ids[i]);
						user.deleteByOfflineInfoId(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("addOfflineInfo")){
				JSONObject json=new JSONObject();
				try{
					String previewName=request.getParameter("previewName");
					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
					java.util.Date Time=df.parse(request.getParameter("previewBegin"));
					java.util.Date Time2=df.parse(request.getParameter("previewEnd"));
					SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
					String str=df2.format(Time);
					Time=df2.parse(str);
					Time2=df2.parse(str);
					Date previewBegin=new Date(Time.getTime());
					Date previewEnd=new Date(Time2.getTime());
					String previewProvince=request.getParameter("previewProvince");
					String previewLocate=request.getParameter("previewLocate");
					String name=request.getParameter("name");
					String locate=request.getParameter("locate");
					SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd HH:mm:ss");
					java.util.Date time3=sdf.parse(request.getParameter("time"));
					Date time=new Date(time3.getTime());
					user.add(previewName, previewBegin, previewEnd, previewProvince, previewLocate,
							name, time, locate);
					json.put("success", true);
				}catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("modifyOfflineInfo")){
				JSONObject json=new JSONObject();
				try{
				long id=Long.parseLong(request.getParameter("id"));
				String previewName=request.getParameter("previewName");
				SimpleDateFormat df = new SimpleDateFormat("MM/dd/yy"); 
				
				java.util.Date Time=df.parse(request.getParameter("previewBegin"));
				java.util.Date Time2=df.parse(request.getParameter("previewEnd"));
				SimpleDateFormat df2 = new SimpleDateFormat("yy-MM-dd");
				String str=df2.format(Time);
				Time=df2.parse(str);
				Date previewBegin=new Date(Time.getTime());
				Date previewEnd=new Date(Time2.getTime());
				String previewProvince=request.getParameter("previewProvince");
				String previewLocate=request.getParameter("previewLocate");
				String name=request.getParameter("name");
				String locate=request.getParameter("locate");
				SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd HH:mm:ss");
				java.util.Date time3=sdf.parse(request.getParameter("time"));
				Date time=new Date(time3.getTime());
				user.modifyOfflineInfoId(id, previewName, previewBegin, previewEnd, previewProvince, 
						previewLocate, name, time, locate);
				json.put("success", true);
				}catch(Exception e)
				{e.printStackTrace();
				json.put("success", false);}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("loadTempGoods")){
				List<GoodsInfo> list=new ArrayList<GoodsInfo>();
				list=user.loadGoodsInfo();
				JSONArray array = new JSONArray();
				JSONObject member=null;
				
				for(int i=0;i<list.size();i++)
				{
					member=new JSONObject();
					long x=list.get(i).getGoodsId();
					String STR_FORMAT = "000000000000";
					DecimalFormat df = new DecimalFormat(STR_FORMAT);  
					member.put("GoodsId",df.format(x));
					member.put("GoodsName", list.get(i).getGoodsName());
					member.put("BeginPrice", list.get(i).getBeginPrice());
					member.put("Amount", list.get(i).getAmount());
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					java.util.Date BeginTime=list.get(i).getBeginTime();
					java.util.Date EndTime=list.get(i).getEndTime();
					String beginTime=sdf.format(BeginTime);
					String endTime=sdf.format(EndTime);
					member.put("BeginTime", beginTime);
					member.put("EndTime", endTime);
					member.put("UserId", list.get(i).getUserId());
					member.put("ImagePath", "../"+list.get(i).getImagePath());
					member.put("GoodsDescription", list.get(i).getGoodsDescription());
					array.put(member);
				}
				
				PrintWriter pw;
				try{
					pw = response.getWriter();
				    pw.print(array.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("delTempGoods")){
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						long id=Long.parseLong(ids[i]);
						user.deleteByGoodsInfoId(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("modifyTempGoods")){
				JSONObject json=new JSONObject();
				try{
				long id=Long.parseLong(request.getParameter("id"));
				String GoodsName=request.getParameter("GoodsName");
				String Str=request.getParameter("BeginPrice");
				double BeginPrice=Double.parseDouble(Str);
				String amount=request.getParameter("Amount");
				int Amount=Integer.parseInt(amount);
				SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd HH:mm:ss");
				String BeginTime=request.getParameter("BeginTime");
				String EndTime=request.getParameter("EndTime");
				java.util.Date beginTime=sdf.parse(BeginTime);
				java.util.Date endTime=sdf.parse(EndTime);
				//Timestamp beginTime=new Timestamp(a.getTime());
				//Timestamp endTime=new Timestamp(b.getTime());
				String userId=request.getParameter("UserId");
				long UserId=Long.parseLong(userId);
				String ImagePath=request.getParameter("ImagePath");
				String GoodsDescription=request.getParameter("GoodsDescription");
				user.modifyGoodsInfo(id, GoodsName, GoodsDescription, BeginPrice, ImagePath, 
						Amount, beginTime, endTime, UserId);;
				json.put("success", true);
				}catch(Exception e)
				{e.printStackTrace();
				json.put("success", false);}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("AcceptTempGoods")){
				JSONObject json=new JSONObject();
				String[] ids=request.getParameter("ids").split(","); 
				try{
					for(int i=0;i<ids.length;i++){
						long id=Long.parseLong(ids[i]);
						GoodsInfo goodsInfo=user.findByGoodsId(id);
						goods.save(goodsInfo);
						user.deleteByGoodsInfoId(id);
					}
					json.put("success", true);
				}
				catch(Exception e){
					e.printStackTrace();
					json.put("success", false);
				}
				PrintWriter pw;
				try{                                             //将值通过json形式返回
					pw = response.getWriter();
				    pw.print(json.toString());
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(actionName.equals("loadOnBid")){
				List<GoodsInfo> list=user.findOnBid();
				JSONArray array=new JSONArray();
				if(!list.isEmpty()){
				for(int i=0;i<list.size();i++){
					GoodsInfo goods=list.get(i);
					JSONObject json=new JSONObject();
					DecimalFormat df=new DecimalFormat("000000000000");
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String beginTime=sdf.format(goods.getBeginTime());
					String endTime=sdf.format(goods.getEndTime());
					String id=df.format(goods.getGoodsId());
					json.put("goodsId", id);
					json.put("ImagePath", goods.getImagePath());
					json.put("beginTime", beginTime);
					json.put("endTime", endTime);
					json.put("goodsName", goods.getGoodsName());
					json.put("beginPrice",goods.getBeginPrice());
					json.put("amount", goods.getAmount());
					json.put("description", goods.getGoodsDescription());
					json.put("userId", goods.getUserId());
					array.put(json);
				}
				}
				else{
					array.put(false);
				}
				PrintWriter pw=response.getWriter();
				pw.print(array.toString());
			}
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("exception", e);
			request.getRequestDispatcher("error.jsp")
				.forward(request, response);
		}
	}
}
