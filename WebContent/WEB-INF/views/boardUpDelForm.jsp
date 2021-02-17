<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ****************************************************** -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!--								common.jsp 파일 내의 소스를 삽입하기 -->	
<!-- ****************************************************** -->
<%@include file="common.jsp" %>


<head><title>게시판 수정/삭제</title>
	<script>		
		//**********************************************************
		// body 태그 안의 모든 태그를 읽어들인 후 실행할 자스 코딩 설정
		//**********************************************************
		$(document).ready(function( ){
			$('[name=boardListForm]').hide();
			<c:forEach items="${paramValues.date}" var="date">
				$("[name=boardListForm] [name=date]").filter("[value=${date}]").prop("checked",true);
			</c:forEach>
		});
		//*******************************************
		// [게시판 등록 화면]에 입력된 데이터의 유효성 체크 함수 선언
		//*******************************************
		function checkBoardUpDelForm( upDel ){	
			alert(1)
			//------------------------------------------------
			// 매개변수로 들어온 upDel 에 "del" 이 저장되었으면
			// 즉, 삭제 버튼을 눌렀으면 암호 확인하고 삭제 여부를 물어보기
			//------------------------------------------------
			if(upDel=='del'){
				//if( checkEmpty( "[name=pwd]", "암호을 입력해주세요.") ){ return; }
				/*
				// 입력한 암호 얻기
				var pwd=$("[name=pwd]").val();
				// 입력한 암호가 비어있으면
				if(pwd.split(" ").join("")==""){
					// 경고하기
					alert("암호를 입력해 주세요");
					// 입력한 암호 비우기
					$("[name=pwd]").val("");
					// 커서 들여놓기
					$("[name=pwd]").focus();
					// 함수 중단하기
					return;
				}
				*/
				// confirm 상자 띄우고 취소 버튼 누르면 함수 중단하기
				if(confirm("정말 삭제 하시겠습니까?")==false) {return;}
			}
			//------------------------------------------------
			// 매개변수로 들어온 upDel 에 "up" 이 저장되었으면
			// 즉, 수정 버튼을 눌렀으면 각 입력양식의 유효성 체크하고 수정 여부 물어보기
			//------------------------------------------------
			else if(upDel=="up"){
					/*
					if( checkEmpty( "[name=writer]", "이름을 입력해주세요.") ){ return; }
					//------------------------------------------------------------------
					if( checkEmpty( "[name=subject]", "제목을 입력해주세요.") ){ return; }
					//------------------------------------------------------------------
					if( checkEmpty( "[name=email]", "이메일을 입력해주세요.") ){ return; }
					//------------------------------------------------------------------
					if( checkEmpty( "[name=content]", "내용을 입력해주세요.") ){ return; }
					//------------------------------------------------------------------
					if( checkEmpty( "[name=pwd]", "암호을 입력해주세요.") ){ return; }
					//------------------------------------------------------------------
					*/
					/*
					var writer = $("[name=writer]").val();
					if( writer.split(" ").join("")=="" ){
						alert("이름을 입력해주세요.");
						$("[name=writer]").focus();
						return;
					}	
					var subject = $("[name=subject]").val();
					if( subject.split(" ").join("")=="" ){
						alert("제목을 입력해주세요.");
						$("[name=subject]").focus();
						return;
					}
					var email = $("[name=email]").val();
					if( email.split(" ").join("")=="" ){
						alert("이메일을 입력해주세요.");
						$("[name=email]").focus();
						return;
					}
					var content = $("[name=content]").val();
					if( content.split(" ").join("")=="" ){
						alert("내용을 입력해주세요.");
						$("[name=content]").focus();
						return;
					}
					var pwd=$("[name=pwd]").val();
					if(pwd.split(" ").join("")==""){
						alert("암호를 입력해 주세요");
						$("[name=pwd]").focus();
						return;
					}
					*/
					if(confirm("정말 수정하시겠습니까?")==false) {return;}
			}

			$("[name=upDel]").val(upDel);


			//alert( $('[name=boardUpDelForm]').serialize() ); 
			//$("body").append(  $('[name=boardUpDelForm]').serialize()   ); return;
			//------------------------------------------------
			// 현재 화면에서 페이지 이동 없이 서버쪽 "${requestScope.croot}/boardUpDelProc.do" 을 호출하여
			// [게시판 수정 또는 삭제 적용 개수]가 있는 html 소스를 받는다.
			//------------------------------------------------
			$.ajax({
				//----------------------------
				// 호출할 서버쪽 URL 주소 설정
				//----------------------------
				url : "${requestScope.croot}/boardUpDelProc.do"
				//----------------------------
				// 전송 방법 설정
				//----------------------------
				, type : "post"
				//----------------------------
				// 서버로 보낼 파라미터명과 파라미터값을 설정
				//----------------------------
				, data : $('[name=boardUpDelForm]').serialize()
				//----------------------------
				// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
				// 익명함수의 매개변수 upDelCnt에는 수정 또는 삭제 행의 개수가 문자열로 들어옴
				//----------------------------
				/*
				,success:function(upDelCnt){
					if(upDel=="up"){
						if(upDelCnt==1){
							alert("수정 성공!");
						}
						else if(upDelCnt==-1){
							alert("게시물이 삭제되어 수정할 수 없습니다!");
							document.boardListForm.submit();
						}
						else if(upDelCnt==-2){
							alert("비밀번호가 잘못 입력 되었습니다!");
						}
						else{
							alert("서버쪽 DB 연동 실패!");
						}
					}
					else if(upDel=="del"){
						if(upDelCnt==1){
							alert("삭제 성공!");;
							document.boardListForm.submit();
						}
						else if(upDelCnt==-1){
							alert("게시물이 이미 삭제되어 삭제할 수 없습니다!");
							document.boardListForm.submit();
						}
						else if(upDelCnt==-2){
							alert("비밀번호가 잘못 입력 되었습니다!");
							document.boardListForm.submit();
						}
						else if(upDelCnt==-3){
							alert("댓글이 있어 삭제 불가능합니다!");
						}
						else{
							alert("서버쪽 DB 연동 실패!");
						}
					}
				}*/
				,success:function(json){
						//----------------------------------------------------
						// 서버가 보낸 Map 객체를 자스에서 JSON 객체로 받는다.
						//----------------------------------------------------

						//-----------------------------------------------
						// JSON 객체에서 boardUpDelCnt 라는 키값으로 저장된 데이터 꺼내기.
						// 즉 수정 삭제 적용행의 개수를 꺼내기
						//-----------------------------------------------
						var boardUpDelCnt = json.boardUpDelCnt;
						//-----------------------------------------------
						// JSON 객체에서 checkMsg 라는 키값으로 저장된 데이터 꺼내기.
						// 즉 유효성 체크 시 수집한 경고 문구 꺼내기
						//-----------------------------------------------
						var checkMsg = json.checkMsg;
						//-----------------------------------------------
						// 만약 수정 모드면
						//-----------------------------------------------
						if(upDel=="up"){
							//----------------------
							// 유효성 체크 시 수집한 경고 문구가 있다면 경고하고 return 으로 함수 중단
							//----------------------
							if( checkMsg!="" ){
								alert( checkMsg );
								return;
							}
							//----------------------
							// 수정 적용행의 개수가 1 이면 "수정 성공" 메시지 띄우기
							//----------------------
							if(boardUpDelCnt==1){
								alert("수정 성공!");
							}
							//----------------------
							// 수정 적용행의 개수가 -1 이면 경고하고 게시판 목록 화면으로 이동하기
							//----------------------
							else if(boardUpDelCnt==-1){
								alert("게시물이 삭제되어 수정할 수 없습니다!");
								document.boardListForm.submit();
							}
							//----------------------
							// 수정 적용행의 개수가 -2 이면 "비밀번호가 잘못 입력 되었습니다!" 경고하기
							//----------------------
							else if(boardUpDelCnt==-2){
								alert("비밀번호가 잘못 입력 되었습니다!");
							}
							//----------------------
							// 그 외에는  "서버쪽 DB 연동 실패!" 경고하기
							//----------------------
							else{
								alert("서버쪽 DB 연동 실패!");
							}
						}
						else if(upDel=="del"){
							if(boardUpDelCnt==1){
								alert("삭제 성공!");;
								document.boardListForm.submit();
							}
							else if(boardUpDelCnt==-1){
								alert("게시물이 이미 삭제되어 삭제할 수 없습니다!");
								document.boardListForm.submit();
							}
							else if(boardUpDelCnt==-2){
								alert("비밀번호가 잘못 입력 되었습니다!");
								document.boardListForm.submit();
							}
							else if(boardUpDelCnt==-3){
								alert("댓글이 있어 삭제 불가능합니다!");
							}
							else{
								alert("서버쪽 DB 연동 실패!");
							}
						}
				}
				//----------------------------
				// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
				//----------------------------
				, error : function(){
					alert("서버와 통신 실패!");
				}
			});
		}
	</script>
</head>
<body bgcolor="${requestScope.bodyBgcolor}"><center>

	<span style='cursor:pointer;'  onclick="location.replace('${requestScope.croot}/logout.do');">[로그아웃]</span><br>

	<!--**********************************************************-->
	<!-- [게시판 글쓰기] 화면을 출력하는 form 태그 선언 -->
	<!--**********************************************************-->
	<form name="boardUpDelForm" method="post">
		<b>[글 수정/삭제]</b>
		<table class="tbcss1"  border=1  bordercolor="${requestScope.thBgcolor}" cellpadding=5 align=center>
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">이 름
				<td>
				<!-------------------------------------------------------->
				<input type="text" size="10" name="writer" maxlength=10 value="${requestScope.board.writer}">
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">제 목 
				<td>
				<!-------------------------------------------------------->
				<input type="text" size="40" name="subject" maxlength=30 value="${requestScope.board.subject}">
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">이메일
				<td>
				<!-------------------------------------------------------->
				<input type="text" size="40" maxlength='30' name="email" value="${requestScope.board.email}">
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">내 용
				<td>
				<!-------------------------------------------------------->
				<textarea name="content" rows="13" cols="40"  maxlength=300>${requestScope.board.content}</textarea>
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">비밀번호
				<td>
				<!-------------------------------------------------------->
				<input type="password" size="8" name="pwd" maxlength=4  value="${requestScope.board.pwd}">
				<!-------------------------------------------------------->
		</table>
		<div style="height:6"></div>
		<!-------------------------------------------------------->
		<input type="hidden" name="b_no" value="${requestScope.board.b_no}">
		<input type="hidden" name="upDel" value="up">
		<!-------------------------------------------------------->
		<input type="button" value="수정" onClick="checkBoardUpDelForm('up')">
		<input type="button" value="삭제" onClick="checkBoardUpDelForm('del')">
		<input type="button" value="목록보기" onClick="document.boardListForm.submit();">
	</form>
	<!-- ********************************************************** -->
	<!-- [게시판 목록] 화면으로 이동하는 form 태그 선언 -->
	<!-- ********************************************************** -->
	<form name="boardListForm" method="post" action="${requestScope.croot}/boardList.do">	
			<!-------------------------------------------------------------------->
			<!--- /boardUpDelForm.do 로 접속하면서 가져왔던 파리미터명 "selectPageNo" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
			<!-------------------------------------------------------------------->
			<!--- /boardUpDelForm.do 로 접속하면서 가져왔던 파리미터명 "rowCntPerPage" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
			<!-------------------------------------------------------------------->
			<!--- /boardUpDelForm.do 로 접속하면서 가져왔던 파리미터명 "keyword1" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="keyword1" value="${param.keyword1}">

			<input type="checkbox" name="date" value="오늘">
			<input type="checkbox" name="date" value="어제">
	</form>

</body>
</html>
