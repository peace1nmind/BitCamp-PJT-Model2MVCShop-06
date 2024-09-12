package com.model2.mvc.common.aspect;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/*
 * FileName : PojoAspectJ.java
 *	:: XML �� ���������� aspect �� ����   
  */
@Aspect
@Component
public class LogAspectJ {

	///Constructor
	public LogAspectJ() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}
	
	//Around  Advice
	@Around("execution(* com.model2.mvc.service..*Impl.*(..))")
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		System.out.println("");
		System.out.println("[Around before] Method :"+
													joinPoint.getTarget().getClass().getName() +"."+
													joinPoint.getSignature().getName());
		if(joinPoint.getArgs().length !=0){
			for (int i = 0; i < joinPoint.getArgs().length; i++) {
				System.out.println("[Around before] Method Argument["+i+"] : "+ joinPoint.getArgs()[i]);
			}
			
		}
		//==> Ÿ�� ��ü�� Method �� ȣ�� �ϴ� �κ� 
		Object obj = joinPoint.proceed();

		System.out.println("[Around after] return Value.toString()  : "+obj);
		System.out.println("");
		
		return obj;
	}
	
	
	@Around("execution(* com.model2.mvc.web..*Controller.*(..))")
	public Object logRequest(ProceedingJoinPoint joinPoint) throws Throwable {
		
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		
        if (requestAttributes != null) {
            HttpServletRequest request = requestAttributes.getRequest();
            
            // ��û URI �α�
            String uri = request.getRequestURI();
            System.out.println("\n[ Request URI ] " + uri);
            
            // �Ķ���� �α�
            Enumeration<String> paramNames = request.getParameterNames();
            while(paramNames.hasMoreElements()) {
            	String key = paramNames.nextElement();
            	String value = request.getParameter(key);
            	
            	System.out.println(String.format("[ key ] %s [ value ] %s", key, value));
            }
            
            System.out.println();
        }
		
		return joinPoint.proceed();
	}
	
}//end of class