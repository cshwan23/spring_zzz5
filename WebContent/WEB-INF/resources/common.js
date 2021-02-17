//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//검색화면에서 검색 결과물의 페이징 번호 출력 소스 리턴
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getPagingNumber(
	totRowCnt               // 검색 결과 총 행 개수
	, selectPageNo_str         // 선택된 현재 페이지 번호
	, rowCntPerPage_str     // 페이지 당 출력행의 개수
	, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
	, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
) {
	//--------------------------------------------------------------
	// name=nowPage을 가진 hidden 태그없으면 경고하고 중지하는 자바스크립트 소스 생성해 저장
	//--------------------------------------------------------------
	if( $('[name=selectPageNo]').length==0 ){
		alert("name=selectPageNo 을 가진 hidden 태그가 있어야 getPagingNumber(~) 함수 호출이 가능함.');" );
		return;
	}
	var arr = [];
	try{
		if( totRowCnt==0 ){	return ""; }
		if( jsCodeAfterClick==null || jsCodeAfterClick.length==0){
			alert("getPagingNumber(~) 함수의 5번째 인자는 존재하는 함수명이 와야 합니다");
			return "";
		}
		//--------------------------------------------------------------
		// 페이징 처리 관련 데이터 얻기
		//--------------------------------------------------------------
		if( selectPageNo_str==null || selectPageNo_str.length==0 ) {
			selectPageNo_str="1";  // 선택한 현재 페이지 번호 저장
		}
		if( rowCntPerPage_str==null || rowCntPerPage_str.length==0 ) {
			rowCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
		}
		if( pageNoCntPerPage_str==null || pageNoCntPerPage_str.length==0 ) {
			pageNoCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
		}
		//---
		var selectPageNo = parseInt(selectPageNo_str, 10);
		var rowCntPerPage = parseInt(rowCntPerPage_str,10);
		var pageNoCntPerPage = parseInt(pageNoCntPerPage_str,10);
		if( rowCntPerPage<=0 || pageNoCntPerPage<=0 ) { return; }
		//--------------------------------------------------------------
		//최대 페이지 번호 얻기
		//--------------------------------------------------------------
		var maxPageNo=Math.ceil( totRowCnt/rowCntPerPage );
			if( maxPageNo<selectPageNo ) { selectPageNo = 1; }

		//--------------------------------------------------------------
		// 선택된 페이지번호에 따라 출력할 [시작 페이지 번호], [끝 페이지 번호] 얻기
		//--------------------------------------------------------------
		var startPageNo = Math.floor((selectPageNo-1)/pageNoCntPerPage)*pageNoCntPerPage+1;  // 시작 페이지 번호
		var endPageNo = startPageNo+pageNoCntPerPage-1;                                      // 끝 페이지 번호
			if( endPageNo>maxPageNo ) { endPageNo=maxPageNo; }
			/*//--------------------------------------------------------------
			// <참고>위 코딩은 아래 코딩으로 대체 가능
			//--------------------------------------------------------------
			var startPageNo = 1;
			var endPageNo = pageNoCntPerPage;
			while( true ){
				if( selectPageNo <= endPageNo ){ startPageNo = endPageNo - pageNoCntPerPage + 1; break; }
				endPageNo = endPageNo + pageNoCntPerPage;
			}*/

		//---
		var cursor = " style='cursor:pointer' ";
		//arr.push( "<table border=0 cellpadding=3 style='font-size:13'  align=center> <tr>" );
		//--------------------------------------------------------------
		// [처음] [이전] 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=right width=110> " );
		if( startPageNo>pageNoCntPerPage ) {
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('1');"
							+jsCodeAfterClick+";\">[처음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
				+(startPageNo-1)+"');"+jsCodeAfterClick+";\">[이전]</span>   " );
		}
		//--------------------------------------------------------------
		// 페이지 번호 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=center>  " );
		for( var i=startPageNo ; i<=endPageNo; ++i ){
			if(i>maxPageNo) {break;}
			if(i==selectPageNo || maxPageNo==1 ) {
				arr.push( "<b>"+i +"</b> " );
			}else{
				arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
							+(i)+"');"+jsCodeAfterClick+";\">["+i+"]</span> " );
			}
		}
		//--------------------------------------------------------------
		// [다음] [마지막] 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=left width=110>  " );
		if( endPageNo<maxPageNo ) {
			arr.push( "   <span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(endPageNo+1)+"');"+jsCodeAfterClick+";\">[다음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(maxPageNo)+"');"+jsCodeAfterClick+";\">[마지막]</span>" );
		}
		//arr.push( "</table>" );
		return arr.join( "" );
	}catch(ex){
		alert("getPagingNumber(~) 메소드 호출 시 예외발생!");
		return "";
	}
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function printPagingNumber(
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	totRowCnt               // 검색 결과 총 행 개수
	, selectPageNo_str         // 선택된 현재 페이지 번호
	, rowCntPerPage_str     // 페이지 당 출력행의 개수
	, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
	, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
) {
	document.write(
		getPagingNumber(
			totRowCnt               // 검색 결과 총 행 개수
			, selectPageNo_str         // 선택된 현재 페이지 번호
			, rowCntPerPage_str     // 페이지 당 출력행의 개수
			, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
			, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
		)
	);
}












//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 테이블 색깔 지정 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function setTableTrBgColor(
		tableClassV			// 테이블의  class 속성값
		, headerColor		// tr 태그 중 헤더부분 배경색
		, oddBgColor		// tr 태그 중 홀수 tr 배경색
		, evenBgColor		// tr 태그 중 짝수 tr 배경색
		, mouseOnBgColor 	// tr 태그 중 마우스 댔을 때 배경색
){
	try{
		//------------------------------------------------------
		// 첫 째 tr. 즉 헤더가 되는 tr 태그를 관리하는 JQuery 객체 생성하기
		//------------------------------------------------------
		var firstTrObj = $("."+tableClassV+" tr:eq(0)");
		//------------------------------------------------------
		// 첫 째 tr 태그 이후 tr 태그를 관리하는 JQuery 객체 생성하기
		//------------------------------------------------------
		var trObjs = firstTrObj.siblings("tr");
		//------------------------------------------------------
		// 첫째 tr, 짝수 tr, 홀수 tr 배경색 지정하기
		//------------------------------------------------------
		firstTrObj.css("background",headerColor);
		trObjs.filter(":odd").css("background",evenBgColor);
		trObjs.filter(":even").css("background",oddBgColor);
		//------------------------------------------------------
		// 첫째 tr 태그 이후 tr 태그에 마우스 대거나 뗄 때 배경색 지정하기
		//------------------------------------------------------
		trObjs.hover(
				function( ){
					$(this).css("background",mouseOnBgColor);
				},
				function( ){
					if( $(this).index( )%2==0 ){
						$(this).css("background",evenBgColor);
					}else{
						$(this).css("background",oddBgColor);
					}
				}
		);
	}catch(e){
		alert("setTableTrBgColor( ~ ) 함수호출  시 에러 발생!");
	}
}



//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  입력양식이 비어 있거나 미체크 시 true 리턴 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function isEmpty( jqueryObj ){
	try{	
		var flag = true;
		if(  jqueryObj.is(":checkbox") || jqueryObj.is(":radio")  ){
			if(jqueryObj.filter(":checked").length>0){ flag = false; }
		}
		else{
			var value = jqueryObj.val( );
			if( value!=null && value.split(" ").join("")!="" ){
				flag=false;
			}
		}
		return flag;
	}catch(e){
		alert("isEmpty( ~ ) 함수호출  시 에러 발생! " + e.message );
		return false;
	}
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  입력양식이 비어 있거나 미체크 시 경고하고 true 리턴 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function checkEmpty( selector, alertMsg ){
	try{	
		var jqueryObj = $(selector);
		if( isEmpty( jqueryObj )  ){
			alert(alertMsg);
			if( jqueryObj.is(":checkbox")==false && jqueryObj.is(":radio")==false ){
				jqueryObj.val("");
				jqueryObj.focus( );
			}
			return true;
		}else {
			return false;
		}
	}catch(e){
		alert("checkEmpty( ~, ~ ) 함수호출  시 에러 발생! "+ e.message );
		return false;
	}
}




//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  입력양식의 value 값이 패턴에 맞지 않으면 경고하고 true 리턴 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function checkPattern( selector, regExpObj , alertMsg ){
	try{	
		var jqueryObj = $(selector);
		var value = jqueryObj.val();
		if( regExpObj.test(value)==false ) {
			alert(alertMsg);
			jqueryObj.val("");
			return true
		}
		else{
			return false;
		}
	}catch(e){
		alert("checkPattern( ~, ~ ) 함수호출  시 에러 발생!");
		return false;
	}
}	


//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  table 태그 내부의 각 th 또는 td 내부의 문자 앞뒤에 원하는 개수의 공백 넣어주는 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function inputBlank_to_tdth( table_selector, blankCnt  ){
	try{	
		var blankStr = "";
		for(var i=1 ; i<=blankCnt ; i++){
			blankStr = blankStr + "&nbsp;"
		}
		var tableObj = $(table_selector);
		tableObj.find("td,th").each(function(){
			var thTdObj = $(this);
			// 각 셀 안의 문자 앞뒤에 원하는 개수의 공백 넣어주기
			thTdObj.html(
				blankStr + thTdObj.html() + blankStr
			);
		});
	}catch(e){
		alert("inputBlank_to_tdth( ~, ~ ) 함수호출  시 에러 발생!");
	}
}



//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  입력양식에 value 값을 삽입하거나 체크해주는 함수 선언.
//  매개변수로  선택자가 들어온다.
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function inputData( 
	selector   // JQuery 객체가 사용할 선택자 문자열
	, data     // 위 선택자가 가르키는 입력양식에 삽입할 데이터. 또는 체크할 놈이 가진 value 값
){
	try{
		//-----------------------------------------------------------
		// 만약 data 가 null 또는 undefined 면 함수 중단
		//-----------------------------------------------------------
		if( data==null || data==undefined ) { return; }
		//-----------------------------------------------------------
		// 만약 길이가 없거나 공백으로만 구성되어 있으면 함수 중단
		if( (data+"").split(" ").join("")=="" ) { return; }
		//-----------------------------------------------------------
		// selector 가 가르키는 입력 양식을 관리하는 JQuery 객체 생성하기
		//-----------------------------------------------------------
		var obj = $(selector);
		//-----------------------------------------------------------
		// selector 가 가르키는 입력 양식이 없으면 경고하고 함수 중단하기
		//-----------------------------------------------------------
		if( obj.length==0 ){
			alert("inputData( "+selector+", "+data+" ) 함수 호출 시  ["+selector+"] 란  선택자가 가르키는  입력양식이 없습니다.");
			return;
		}
		//-----------------------------------------------------------
		// 만약 입력 양식이 checkbox 또는 radio면
		// 매개변수 data 안의 데이터를 value 값으로 가진 놈을 체크하기
		//-----------------------------------------------------------
		if(obj.is(":checkbox") || obj.is(":radio")){
			obj.filter("[value='"+data+"']").prop("checked",true);
		}
		//-----------------------------------------------------------
		// 만약 입력 양식이 checkbox 또는 radio가 아니면
		// 매개변수 data 안의 데이터를 입력양식의 value 값으로  삽입하기
		//-----------------------------------------------------------
		else{
			obj.val(data);
		}
	}catch(e){
		alert("inputData( '"+selector+"','"+data+"' ) 함수 호출 시 에러 발생!");
	}
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  checkbox또는 radio 의 체크 개수 구하는 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getCheckedCnt( selector ) {
	var jqueryObj = $(selector);
	if( jqueryObj.length==0 ){
		alert( "선택자 " + selector + " 가 가르키는 입력양식이 없습니다.");
		return 0;
	}
	return jqueryObj.filter(":checked").length;
}
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//  입력 양식의 value 값을 리턴하는 함수.
//  <참고>checkbox 또는 radio 라면 체크된 놈의 value 값을 얻는다,
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getValue( selector ) {
	var jqueryObj = $(selector);
	if( jqueryObj.length==0 ){
		alert( "선택자 " + selector + " 가 가르키는 입력양식이 없습니다.");
		return "";
	}
	var result = "";
	if( jqueryObj.is(":checkbox") ){
		if( jqueryObj.filter(":checked").length>0 ) {
			result = [];
			jqueryObj.filter(":checked").each(function(){
				result.push(  $(this).val()  );
			});
		}
	}
	else if( jqueryObj.is(":radio") ){
		if( jqueryObj.is(":checked") ){
			result = jqueryObj.val();
		}
	}
	else{
		if( isEmpty(jqueryObj)==false ){
			result = jqueryObj.val();
		}
	}
	return result;
}



//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 비동기 방식으로 서버에 접속하는 함수 선언.
// 파일업로드  또는 비파일업로드 모두 적용 가능한 함수이다.
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function ajax( 
		url_addr        // 서버의 접속 url
		,formName       // 서버로 전송할 파라미터값을 내포한 form 태그 name 값
		,callback_func  // 서버의 응답이 왔을때 실행할 익명함수 선언
) {
		try{
				//---------------------------------------------------------------
				// form 태그를 관리하는 JQuery 객체 생성하기
				//---------------------------------------------------------------
				var formObj =  $("[name="+formName+"]");
				//---------------------------------------------------------------
				if( formObj.length==0 ){
					alert( "ajax 함수 호출 시 2번째 인자에 입력되는 "+formName+" 라는 form 태그가 없습니다." ) ; 
					return;
				}
				//---------- ----------------------------------------------------
				// form 태그 안에 파일업로드 입력양식의 존재 여부 얻기
				//---------------------------------------------------------------
				var isFile =  formObj.find("[type='file']").length>0;
				//---------------------------------------------------------------
				// JQuery 객체의 ajax 메소드 호출로 비동기 방식으로 서버에 접속하기.
				//---------------------------------------------------------------
				$.ajax({
					//----------------------------
					// 호출할 서버쪽 URL 주소 설정
					//----------------------------
					url : url_addr
					//----------------------------
					// 전송 방법 설정
					//----------------------------
					, type : "post"
					//-----------------------------------
					// 전송하는 파라미터명, 파라미터값을 "파명=파값&~" 형태의 문자열로 변경할 지 여부 설정하기.
					// form 태그 안에 파일업로드 입력양식이 있으면 false, 없으면 true 로 설정한다.
					// 서버로 보내는 데이터에 파일이 있으면 문자열로 변경하지 말고 FormData 객체 그대로 보내야한다.
					//-----------------------------------
					,processData: isFile?false:true
					//-----------------------------------
					// "content-type" 라는 헤더명의 헤더값 설정하기.
					// contentType:true   면 헤더값으로 "application/x-www-form-urlencoded" 가 설정된다.
					// contentType:false  면 헤더값으로 "multipart/form-data" 가 설정된다.
					// 파일이 있으므로  "multipart/form-data" 로 해야한다.
					//-----------------------------------
					,contentType:isFile?false:true 
					//-----------------------------------
					// 서버로 보내는 데이터  설정하기.
					// form 태그 안에 파일업로드 입력양식이 있으면 new FormData 객체 설정하고,
					// 없으면  data: "파명=파값&~" 형태 또는 data: {"파명":파값, ~} 또는 data: $("[name=폼이름]").serialize() 로 설정한다.
					//-----------------------------------
					,data: isFile?(new FormData(formObj.get(0))):(formObj.serialize())
					//----------------------------
					// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					//----------------------------	
					,success : callback_func
					//----------------------------
					// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
					//----------------------------
					, error : function(){
						alert( url_addr + " 접속 시 서버 응답 실패! 관리자에게 문의 바람!");
					}
				});

		}catch(e){
			alert(  "ajax 함수 호출 시 에러 발생!" + e.message );
		}
}
