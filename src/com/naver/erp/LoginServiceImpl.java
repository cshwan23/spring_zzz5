package com.naver.erp;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [서비스 클래스]인 [LoginServiceImpl 클래스] 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [서비스 클래스]에는 @Service 와 @Transactional 를 붙인다.
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// @Service			=> [서비스 클래스] 임을 지정하고 bean 태그로 자동 등록된다.
	// @Transactional	=> [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@Service
@Transactional
public class LoginServiceImpl implements LoginService{
	//======================================
	// 속성변수 loginDAO 선언하고, LoginDAO 라는 인터페이스를
	// 구현한 클래스를 객체화하여 저장
	//======================================
		// @Autowired 이 붙은 속성변수에는 인터페이스 자료형을 쓰고
		// 이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
		// LoginDAO 라는 인터페이스를 구현한 클래스의 이름을 몰라도 관계없다.
		// 1개 존재하기만 하면된다.
	//======================================
	@Autowired
	private LoginDAO loginDAO;

	//+++++++++++++++++++++++++++++++++++++
	// 로그인 정보의 개수를 리턴하는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++
	public int getAdminIdCnt( 
		Map<String,String> admin_id_pwd 
	) {
		//------------------------------------------------
		// LoginDAOImpl 객체의 getAdminIdCnt 메소드 호출하여 아이디 암호 존재 개수를 얻기
		//------------------------------------------------
		int adminCnt = this.loginDAO.getAdminIdCnt(admin_id_pwd);
		//------------------------------------------------
		//아이디 암호 존재 개수를 리턴하기
		//------------------------------------------------
		return adminCnt;
	}

}
