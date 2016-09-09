package controller;


import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.UserAction;

import java.io.*;

public class ControllerServlet extends HttpServlet {
	UserAction userAction = new UserAction();
	@Override
	protected void service(HttpServletRequest request,
				HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String path = request.getServletPath();// /login.action
		// 截取得到 功能名ss
		int index1 = path.lastIndexOf("/")+1;
		int index2 = path.lastIndexOf(".action");
		String actionName = path.substring(index1,index2);
		// 根据不同的功能名，调用不同的 action 处理类中的方法
		try{
			if( actionName.equals("login") ){
				userAction.login(request, response);
			} else if( actionName.equals("register") ){
				userAction.register(request, response);
			  }
				else if(actionName.equals("modify")){
					userAction.modify(request, response);
				}
				else if(actionName.equals("search")){
					userAction.search(request, response);
				}
				else if(actionName.equals("loadBid")){
					
					userAction.loadBid(request,response);
				} 
				else if(actionName.equals("bidForGoods")){
					userAction.bidForGoods(request,response);
				}
				else if(actionName.equals("loadWords")){
					userAction.loadWords(request,response);
				}
				else if(actionName.equals("transWords")){
					userAction.transWords(request,response);
				}
		} catch (Exception e){
			e.printStackTrace();
			request.setAttribute("exception", e);
			request.getRequestDispatcher("error.jsp")
				.forward(request, response);
		}
	}
	
	
}
