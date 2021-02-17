<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ****************************************************** -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="common.jsp" %>
<html>
<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!--								common.jsp 파일 내의 소스를 삽입하기 -->
<!-- ****************************************************** -->
<head><title>게시판 상세보기</title>
	<script>
		//**********************************************************
		// body 태그 안의 모든 태그를 읽어들인 후 실행할 자스 코딩 설정
		//**********************************************************
		$(document).ready(function( ){
			$('[name=boardForm]').hide();

			<c:forEach items="${paramValues.date}" var="date">
				$("[name=boardForm] [name=date]").filter("[value=${date}]").prop("checked",true);
			</c:forEach>

		});
		//--------------------------------------
		// 게시판 수정 화면으로 이동하는 함수 선언
		//--------------------------------------
		function goBoardUpDelForm(){
			document.boardForm.action="${requestScope.croot}/boardUpDelForm.do";
			// name=boardForm 을 가진 form 태그의 action 값을 URL로 서버에 접속하라
			document.boardForm.submit();
		}
		//--------------------------------------
		// 게시판 댓글 화면으로 이동하는 함수 선언
		//--------------------------------------
		function goBoardRegForm(){
			// name=boardForm 을 가진 form 태그의 action 값을 "${requestScope.croot}/boardRegForm.do" 로 설정하기
			document.boardForm.action="${requestScope.croot}/boardRegForm.do";
			// name=boardForm 을 가진 form 태그의 action 값을 URL로 서버에 접속하라
			document.boardForm.submit();
		}
		//--------------------------------------
		// 게시판 목록보기 화면으로 이동하는 함수 선언
		//--------------------------------------
		function goBoardListForm(){
			document.boardForm.action="${requestScope.croot}/boardList.do";
			// name=boardForm 을 가진 form 태그의 action 값을 URL로 서버에 접속하라
			document.boardForm.submit();
		}
	</script>
</head>
<body bgcolor="${requestScope.bodyBgcolor}"><center>

		<div style='cursor:pointer;'  onclick="location.replace('${requestScope.croot}/logout.do');">[로그아웃]</div>

		<b>[글 상세 보기]</b>
		<!----------------------------------------------------------->
		<table class="tbcss1" width="500" border=1 bordercolor="#DDDDDD" cellpadding="5" align="center">
			<tr align=center>
				<th width=60 bgcolor="${requestScope.thBgcolor}">글번호
				<td width=150>${requestScope.board.b_no}
				<th width=60 bgcolor="${requestScope.thBgcolor}">조회수
				<td width=150>${requestScope.board.readcount}
			<tr align=center>
				<th width=60 bgcolor="${requestScope.thBgcolor}">작성자
				<td width=150>${requestScope.board.writer}
				<th width=60 bgcolor="${requestScope.thBgcolor}">작성일
				<td width=150>${requestScope.board.reg_date}
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">글제목
				<td width=150 colspan=3>${requestScope.board.subject}
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">글내용
				<td width=150 colspan=3>
					<textarea name="content" rows="13" cols="45" style="border:0" readonly>${requestScope.board.content}</textarea>
		</table><br>
		<input type="button" value="댓글쓰기" onClick="goBoardRegForm();">&nbsp;
		<input type="button" value="수정/삭제" onClick="goBoardUpDelForm();">&nbsp;
		<input type="button" value="글 목록 보기" onClick="goBoardListForm();">


		<!--**********************************************************-->
		<!-- [게시판 목록] 화면으로 이동하는 form 태그 선언 -->
		<!--**********************************************************-->
		<form name="boardForm" method="post">
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "b_no" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="b_no" value="${param.b_no}">
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "selectPageNo" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "rowCntPerPage" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "keyword1" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
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

