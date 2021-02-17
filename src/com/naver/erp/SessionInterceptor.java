package com.naver.erp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// URL 접속 시 [컨트롤러 클래스의 메소드] 호출 전 또는 후에 
// 실행될 메소드를 소유한 [SessionInterceptor 클래스] 선언.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 컨트롤러 클래스의 메소드] 호출 전 또는 후에 실행될 메소드를 소유한 클래스가 될 자격 조건
	//---------------------------------------------------------------
	//		<1> 스프링이 제공하는 [HandlerInterceptorAdapter 클래스]를 상속 받는다.
	//		<2> HandlerInterceptorAdapter 클래스의 preHandle 메소드를 재정의한다.
	// 		<3> servlet-context.xml 파일에 다음 태그를 삽입한다
	//---------------------------------------------------------------
			//		<interceptors>
			//		<interceptor>
			//			<mapping path="/**/*"/>
            //			<exclude-mapping path="/loginForm.do"/>
            //			<exclude-mapping path="/loginProc.do"/>
            //			<exclude-mapping path="/logout.do"/>
            //			<exclude-mapping path="/resources/**"/>
			//		    <beans:bean class="com.naver.erp.SessionInterceptor"></beans:bean>            
			//		</interceptor>        
			//		</interceptors>
	//---------------------------------------------------------------
		//*************************************************
		// [HandlerInterceptorAdapter 객체]의 메소드 종류와 호출 시점
		//*************************************************
		// preHandle()       : Controller 클래스의 메소드 실행 전에 호출. boolean 값을 return 하며 Controller 클래스의 특정 메소드 실행 여부를 결정
		// postHandle()      : Controller 클래스의 메소드 실행 후, JSP 를 실행 전에 호출
		// afterCompletion() : Controller 클래스의 메소드 실행 후, JSP 를 실행 후 호출됨. responseBody를 이용할 경우 값을 클라이언에게 전달 후 호출

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

public class SessionInterceptor extends HandlerInterceptorAdapter {	

	@Override
	public boolean preHandle(
		HttpServletRequest request 
		, HttpServletResponse response 
		, Object handler
	) throws Exception {
		//-------------------------------------
		// HttpSession 객체 얻기
		// HttpServletRequest 객체의 getSession() 메소드를 호출하면 HttpSession 객체를 얻을 수 있다.
		//-------------------------------------
		HttpSession session = request.getSession();   
		//-------------------------------------
		// Session 객체에서 키값이 admin_id 로 저장된 데이터 꺼내기. 
		// 즉 로그인 정보 꺼내기
		//-------------------------------------
		String admin_id = (String)session.getAttribute("admin_id");	
		//-------------------------------------
		// 꺼낸 admin_id 가 null 이면, 즉 로그인한 적이 없으면
		//-------------------------------------
		if(admin_id==null) {	
			//-------------------------------------
			// 현재 이 웹 서비스의 컨택스트 루트명 구하기.
			// HttpServletRequest 객체의 getContextPath() 메소드를 호출하면  컨택스트 루트명을 얻을 수 있다.
			//-------------------------------------
			String ctRoot  = request.getContextPath();  
			//-----------------
			// 클라이언트가 /loginForm.do 로 재 접속하라고 설정하기
			//-----------------
			response.sendRedirect( ctRoot + "/loginForm.do" );

			//-----------------
			// false 값을 리턴하기
			// false 값을 리턴하면 컨트롤러 클래스의 메소드는 호출되지 않는다.
			//-----------------
			return false;
		}
		//-------------------------------------
		// 꺼낸 admin_id 가 null 이 아니면, 즉 로그인한 적이 있으면
		//-------------------------------------
		else { 
			return true;
		}
		
	}

}
