package com.model2.mvc.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.model2.mvc.service.domain.User;


/*
 * FileName : LogonCheckInterceptor.java
 *  �� Controller ȣ���� interceptor �� ���� ��ó��/��ó��/�Ϸ�ó���� ����
 *  	- preHandle() : Controller ȣ���� ��ó��   
 * 			(true return ==> Controller ȣ�� / false return ==> Controller ��ȣ�� ) 
 *  	- postHandle() : Controller ȣ�� �� ��ó��
 *    	- afterCompletion() : view ������ ó��
 *    
 *    ==> �α����� ȸ���̸� Controller ȣ�� : true return
 *    ==> �� �α����� ȸ���̸� Controller �� ȣ�� : false return
 */

// ���� ���� �� : https://chatgpt.com/share/6273a0c4-c625-4a9c-ba89-3a76e7266874
// HandlerInterceptor�� HHTP ��û ó���ܰ迡�� �����Ͽ� ����ä�� ������ ��� �޼��������� ���Ͻð� ����� Spring AOP�� ������� �ʴ´�
public class LogonCheckInterceptor extends HandlerInterceptorAdapter {

	///Field
	// �α��� ���¿� ���� ���� Ȯ�� URI ������
	@Value("#{uriProperties['checkURIs']}")
	private String[] checkURIs;
	
	public String[] getCheckURIs() {
		return checkURIs;
	}

	public void setCheckURIs(String[] checkURIs) {
		this.checkURIs = checkURIs;
	}

	
	///Constructor
	public LogonCheckInterceptor(){
		System.out.println("\nCommon :: "+this.getClass()+"\n");		
	}
	
	
	///Method
	public boolean preHandle(	HttpServletRequest request,
														HttpServletResponse response, 
														Object handler) throws Exception {
		
		System.out.println("\n[ LogonCheckInterceptor start ]");
		
		//==> �α��� ����Ȯ��
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		//==> �α����� ȸ���̶��...
		if(   user != null   )  {
			//==> �α��� ���¿��� ���� �Ұ� URI
			String uri = request.getRequestURI();
			
//			if(		uri.indexOf("addUserView") != -1 	|| 	uri.indexOf("addUser") != -1 || 
//					uri.indexOf("loginView") != -1 			||	uri.indexOf("login") != -1 		|| 
//					uri.indexOf("checkDuplication") != -1 ){
			if (checkUri(uri)) {
				request.getRequestDispatcher("/index.jsp").forward(request, response);
				
				System.out.println("[ �α��� ����! �α��� �� ���ʿ��� �䱸 ]");
				System.out.println("[ LogonCheckInterceptor end ]\n");
				
				return false;
			}
			
			System.out.println("[ �α��� ���� ... ]");
			System.out.println("[ LogonCheckInterceptor end........]\n");
			
			return true;
			
		}else{ //==> �� �α����� ȭ���̶��...
			//==> �α��� �õ� ��.....
			String uri = request.getRequestURI();
			
//			if(		uri.indexOf("addUserView") != -1 	|| 	uri.indexOf("addUser") != -1 || 
//					uri.indexOf("loginView") != -1 			||	uri.indexOf("login") != -1 		|| 
//					uri.indexOf("checkDuplication") != -1 ){
			if (checkUri(uri)) {
				System.out.println("[ �α� �õ� ���� .... ]");
				System.out.println("[ LogonCheckInterceptor end........]\n");
				
				return true;
			}
			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			
			System.out.println("[ �α��� ���� ... ]");
			System.out.println("[ LogonCheckInterceptor end........]\n");
			
			return false;
		}
	}
	
	
	private boolean checkUri(String uri) {
		
		boolean uriFlag = false;
		
		for (String checkURI : checkURIs) {
			System.out.println("\t"+checkURI);
			if (uri.indexOf(checkURI) != -1) {
				uriFlag = true;
			}
		}
				
		return uriFlag;
	}
	
}//end of class