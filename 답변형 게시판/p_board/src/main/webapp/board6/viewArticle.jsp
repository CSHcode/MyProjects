<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<head>
<meta charset="UTF-8">
<title>글보기</title>

<style>
#tr_btn_modify {
	display: none;
}
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
     function backToList(obj){		//돌아가기 클릭시 호출
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
     }
 
	 function fn_enable(obj){				//수정하기 클릭시 disabled/block 해제/적용 호출
		 document.getElementById("i_title").disabled=false;
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
	 }
	 
	 function fn_modify_article(url, articleNO){		//수정 반영하기 클릭시 호출, 매개변수로는 컨트롤러로 날릴 다음 url과 현재 수정하고 있던 글번호를 받음
		 var form = document.createElement("form");		//form 태그 생성하고 그 안에 append 로 자식 태그를 계속 생성
		 form.setAttribute("method", "post");			//post 방식으로
		 form.setAttribute("action", url);				//컨트롤러로 보낼 url
		 
	     var articleNOInput = document.createElement("input");	//input 태그 생성
	     articleNOInput.setAttribute("type","hidden");			//type 은 hidden
	     articleNOInput.setAttribute("name","articleNO");		//name
	     articleNOInput.setAttribute("value", articleNO);		//value
	     form.appendChild(articleNOInput);
	     
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","title");
	     articleNOInput.setAttribute("value", document.forms["frmArticle"].elements[3].value);
	     form.appendChild(articleNOInput);
	     
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","content");
	     articleNOInput.setAttribute("value", document.forms["frmArticle"].elements[4].value);
	     form.appendChild(articleNOInput);
	     
	     document.body.appendChild(form);				//죄종적으로 처음 생성했던 form 태그를 닫음
		 form.submit();
	 }
	 
	 function fn_remove_article(url,articleNO){					//removeArticle.do
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden");
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
		 
	     form.appendChild(articleNOInput);
	     document.body.appendChild(form);
		 form.submit();
	 }
	 
	 function fn_reply_form(url, parentNO){						//replyForm.do
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var parentNOInput = document.createElement("input");
	     parentNOInput.setAttribute("type","hidden");
	     parentNOInput.setAttribute("name","parentNO");
	     parentNOInput.setAttribute("value", parentNO);
		 
	     form.appendChild(parentNOInput);
	     document.body.appendChild(form);
		 form.submit();
	 }
	 
	 function readURL(input) {
	     if (input.files && input.files[0]) {
	         var reader = new FileReader();
	         reader.onload = function (e) {
	             $('#preview').attr('src', e.target.result);
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
 </script>

</head>

<body>  <!-- article key에 articleVO 객체를 담아서 넘어옴 -->
	<form name="frmArticle" method="post" action="${contextPath}">
		<table border="0" align="center">
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">글번호</td>
				<td><input type="text" value="${article.articleNO }" disabled />
					<input type="hidden" name="articleNO" value="${article.articleNO }" />
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">작성자 아이디</td>
				<td><input type=text value="${article.id }" name="writer" disabled />
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">제목</td>
				<td><input type=text value="${article.title }" name="title"	id="i_title" disabled />
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">내용</td>
				<td><textarea rows="20" cols="60" name="content" id="i_content"	disabled />${article.content }</textarea>
				</td>
			</tr>

			<tr>
				<td width=20% align=center bgcolor=#FF9933>등록일자</td>
				<td><input type=text value="<fmt:formatDate value="${article.writeDate}" />" disabled />
				</td>
			</tr>
			
			<tr id="tr_btn_modify">
				<td colspan="2" align="center">
					<input type=button value="수정반영하기" onClick="fn_modify_article('${contextPath}/board/modArticle.do', ${article.articleNO})">  <!-- 변경완료후 클릭하면 -->
					<input type=button value="취소" onClick="backToList(frmArticle)">
				</td>
			</tr>

			<tr id="tr_btn">
				<td colspan=2 align=center>
					<input type=button value="수정하기" onClick="fn_enable(this.form)">	<!-- 수정하기를 클릭하면 disabled, false 등등 설정이 변경됨 -->
					<input type=button value="삭제하기" onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})">
					<input type=button value="리스트로 돌아가기"	onClick="backToList(this.form)">
					<input type=button value="답글쓰기" onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})">  <!-- 보고있던 글의 글번호가 부모번호가 됨 -->
				</td>
			</tr>
		</table>
	</form>
</body>
</html>