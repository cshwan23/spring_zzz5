package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// URL 주소로 접속하면 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언
	// @Controller 를 붙임으로써 [컨트롤러 클래스]임을 지정한다.
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
@Controller

public class LoginController {


	
	//***************************************
	// 속성변수 loginService 선언하고, 
	// @Autowired 에 의해 LoginService 라는 인터페이스를
	// 구현한 클래스를 객체화하여 저장한다.
	//***************************************
		// @Autowired 이 붙은 속성변수에는 인터페이스 자료형을 쓰고
		// 이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
		// LoginService 라는 인터페이스를 구현한 클래스의 이름을 몰라도 관계없다. 1개 존재하기만 하면된다.
		// LoginService 라는 인터페이스를 구현한 클래스의 이름을  바꾸어도 현재 이 클래스에는 바꿀 코딩이 없으므로
		// 연쇄 코디 수정을 막을 수 있다. 즉 결합성이 약화된다.
	@Autowired
	private LoginService loginService;

	//***************************************
	// 가상주소 /erp/loginForm.do 로 접근하면 호출되는 메소드 선언
	//***************************************
	@RequestMapping( value="/loginForm.do")
	public ModelAndView loginForm( ){
		//---------------------
		// [ModelAndView 객체] 생성하기
		// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
		// [ModelAndView 객체] 리턴하기
		//---------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("loginForm.jsp");
		return mav;
	}

	//***************************************
	// 위 loginProc(~) 메소드는 아래처럼 @ResponseBody 를 사용하면 JSP 페이지 호출없이
	// 리턴하는 로그인 정보 존재개수를 직접 클라이언트에게 전송할 수도 있다.
	// 단 서버가 보내는 데이터를 클라이언트가 받을 수 있도록 클라이언트가 코딩되어 있어야한다.
	//***************************************
	@RequestMapping(
			value="/loginProc2.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int getAdminIdCnt2( 
			// 클이보낸 요청 메시지를 관리하는 HttpServletRequest 객체가 매개변수들어온다.
			// HttpServletRequest 객체를 통해 파리미터값을 얻을수 있다.
			HttpServletRequest request
	) {
		//------------------------------------------------
		// 클이 보낸 요청 메시지 안의 "admin_id" 이름의 파라미터값 꺼내기
		// 클이 보낸 아이디를 꺼내라
		//------------------------------------------------
		String admin_id = request.getParameter("admin_id");
		//------------------------------------------------
		// 클이 보낸 요청 메시지 안의 "pwd" 이름의 파라미터값 꺼내기
		// 클이 보낸 암호를 꺼내라
		//------------------------------------------------s
		String pwd = request.getParameter("pwd");
		
		// 아이디 암호를 가지고 DB 연동을 해서 아이디의 존재개수를 리턴하기
		// ?????????
		
		
		return 1;
	}
	
	
	//***************************************
	// 아래 getAdminIdCnt(~) 메소드는 아래처럼 @ResponseBody 를 사용하면 JSP 페이지 호출없이
	// 리턴하는 로그인 정보 존재개수를 직접 클라이언트에게 전송할 수도 있다.
	// 단 서버가 보내는 데이터를 클라이언트가 받을 수 있도록 클라이언트가 코딩되어 있어야한다.
	//***************************************
	@RequestMapping(
			value="/loginProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int getAdminIdCnt( 
			//--------------------------------------
			// "admin_id" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 admin_id 에 저장하고 들어온다.
			//--------------------------------------
			@RequestParam( value="admin_id" ) String admin_id
			//--------------------------------------
			// "pwd" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 pwd 에 저장하고 들어온다.
			//--------------------------------------
			, @RequestParam( value="pwd" ) String pwd
			//--------------------------------------
			// "is_login" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 is_login 에 저장하고 들어온다.
			//--------------------------------------
			, @RequestParam( value="is_login" ,   required=false  ) String is_login
			//--------------------------------------
			// HttpSession 객체를 받아오는 매개변수 선언
			//--------------------------------------
			, HttpSession session
			//--------------------------------------
			// [HtppServletResponse 객체]가 들어올 매개변수 선언
			//--------------------------------------
			,HttpServletResponse response
	) {
		//--------------------------------------
		// HashMap 객체에 로그인 아이디,암호를 저장하기
		// HashMap 객체에 저장하는 이유는 하나로 모으기 위함이다.
		// 그래야 다른 객체로 객체 전달하기가 쉽다.
		// 더구나 mybatis 프레임워크를 사용하면
		// mybatis 프레임워크 쪽으로 더져지는 데이터는 무조건 하나이어야한다.
		//--------------------------------------
		Map<String,String> map = new HashMap<String,String>();
		map.put("admin_id", admin_id);
		map.put("pwd", pwd);
		//--------------------------------------
		// 로그인 아이디,암호의 존재 개수를 저장하는 변수 선언하기
		//--------------------------------------
		int admin_idCnt = 0;
		//--------------------------------------
		// LoginServiceImpl 객체의 getAdminIdCnt 메소드를 호출해서 로그인 아이디,암호의 존재 개수얻기
		//--------------------------------------
		admin_idCnt = this.loginService.getAdminIdCnt(map);

		//--------------------------------------
		// 아이디와 암호의 존재 개수 1개면, 즉 아이디와 암호가 admin  테이블에 존재하면
		//--------------------------------------
		if( admin_idCnt==1 ) {
				//--------------------------------------
				// HttpSession 객체에 로그인 성공한 [아이디] 저장하기
				// HttpSession 객체에 로그인에 성공한 [아이디]를 저장하면
				// 연결 상태가 유지되는 한 모든 JSP 페이지에서 꺼내어 확인해 볼 수 있다
				//--------------------------------------
				session.setAttribute("admin_id",admin_id);

				//--------------------------------------
				// 매개변수 is_login 에 null 이 저장되어 있으면(=[아이디,암호 자동 입력]의사 없을 경우 )
				//--------------------------------------
				if(is_login==null) {
					// Cookie 객체를 생성하고 쿠키명-쿠키값을 ["admin_id"-"null"]로 하기
					Cookie cookie1 = new Cookie("admin_id",null);
					// Cookie 객체의 수명은 0으로 하기
					cookie1.setMaxAge(0);
					// Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-"null"]로 하기
					Cookie cookie2 = new Cookie("pwd",null);
					// Cookie 객체의 수명은 0으로 하기
					cookie2.setMaxAge(0);
					// Cookie 객체를 응답메시지에 저장하기. 
					// 결국 Cookie 객체가 소유한 쿠키명-쿠키값이 응답메시지에 저장되는 샘이다.
					// 응답메시지에 저장된 쿠키는 클라이언트쪽으로 전송되어 클라이언트쪽에 저장된다.
					response.addCookie(cookie1);
					response.addCookie(cookie2);
				}
				//--------------------------------------
				// 매개변수 is_login 에 "y" 이 저장되어 있으면(=[아이디,암호 자동 입력]의사 있을 경우 )
				//--------------------------------------
				else {
					// Cookie 객체를 생성하고 쿠키명-쿠키값을 ["admin_id"-"입력아이디"]로 하기
					Cookie cookie1 = new Cookie("admin_id",admin_id);
					// Cookie 객체의 수명은 60*60*24으로 하기
					cookie1.setMaxAge(60*60*24);
					// Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-"입력암호"]로 하기
					Cookie cookie2 = new Cookie("pwd",pwd);
					// Cookie 객체의 수명은 60*60*24으로 하기
					cookie2.setMaxAge(60*60*24);
					// Cookie 객체를 응답메시지에 저장하기. 
					// 결국 Cookie 객체가 소유한 쿠키명-쿠키값이 응답메시지에 저장되는 샘이다.
					// 응답메시지에 저장된 쿠키는 클라이언트쪽으로 전송되어 클라이언트쪽에 저장된다.
					response.addCookie(cookie1);
					response.addCookie(cookie2);
				}

		}


		//--------------------------------------
		// 로그인 아이디,암호의 존재 개수를 리턴하기
		//--------------------------------------
		return admin_idCnt;
	}
	
	
	//***************************************
	// 가상주소 /logout.do  로 접근하면 호출되는 메소드 선언
	//***************************************
	@RequestMapping( value="/logout.do")
	public ModelAndView logout( 
			//-------------------------------
			// [HttpSession 객체]가 들어올 매개변수 선언.
			// 매개변수에 자료형이 HttpSession이면 웹서버가
			// 생성한 HttpSession 객체가 들어온다.
			//-------------------------------
			HttpSession session 
	){
		//---------------------
		// HttpSession 객체에 저장된 로그인 아이디 삭제하기
		//---------------------
		session.removeAttribute("admin_id");

		//---------------------
		// [ModelAndView 객체] 생성하기
		// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
		// [ModelAndView 객체] 리턴하기
		//---------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("logout.jsp");
		System.out.println( "<접속성공> [접속 URI]->/logout.do  [호출메소드]->BoardController.logout(~) \n" );
		return mav;

	}
	
	
}

















