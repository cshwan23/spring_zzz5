package com.naver.erp;

import java.util.Map;

public interface LoginDAO {
	//+++++++++++++++++++++++++++++++++++++++
	// 로그인 정보의 개수를 리턴하는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++++
	public int getAdminIdCnt( 
		//---------------------------------------------------
		// 매개변수로 클이 입력한 아이디와 암호가 저장된 HashMap 객체가 들어온다.
		// <참고>Map 인터페이스를 구현한 클래스가 HashMap 클래스이다.
		//       그러므로 HashMap 객체가 들어와도 자료형은 Map 을 쓸수 있다.
		//---------------------------------------------------
		Map<String,String> admin_id_pwd 
	);
}
