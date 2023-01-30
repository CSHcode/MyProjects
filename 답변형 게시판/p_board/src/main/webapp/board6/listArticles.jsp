<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set  var="articlesList"  value="${articlesMap.articlesList}" />	<!-- ArticleVO 객체 리스트 -->
<c:set  var="totArticles"  value="${articlesMap.totArticles}" />	<!-- 게시판에 존재하는 총 게시글 수 -->
<c:set  var="section"  value="${articlesMap.section}" />	<!-- map에서 넘어온 섹션 번호 -->
<c:set  var="pageNum"  value="${articlesMap.pageNum}" />	<!-- map에서 넘어온 페이지 번호 -->

<%
  request.setCharacterEncoding("UTF-8");
%>  

<!DOCTYPE html>
<html>
<head>

<style>
   .no-uline {text-decoration:none;}
   .sel-page{text-decoration:none;color:red;}
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
</style>

<meta charset="utf-8">

<title>listArticles.jsp</title>
</head>

<body>
	<!-- 테이블 상단 -->
	<table align="center" border="1"  width="80%"  >
	  <tr height="10" align="center"  bgcolor="lightgreen">
	     <td >글번호</td>
	     <td >작성자</td>              
	     <td >제목</td>
	     <td >작성일</td>
	  </tr>
	  
	<c:choose>
	  <c:when test="${empty articlesList }" >	<!-- 게시글이 없는 경우 -->
	    <tr  height="10">
	      <td colspan="4">
	         <p align="center">
	            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
	        </p>
	      </td>  
	    </tr>
	  </c:when>
	  
	  <c:when test="${!empty  articlesList}" >	<!-- 게시글이 있는 경우 -->
	    <c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >		<!-- articleList에 들어있는 ArticleVO 개수만큼 forEach 돌림 -->
	     <tr align="center">
			<td width="5%">${article.articleNO}</td>	<!-- 글번호 -->	
			<td width="10%">${article.id }</td>			<!-- 작성자 -->
			<td align='left'  width="35%">				<!-- 제목 -->
			    <span style="padding-right:30px"></span>     
				   <c:choose>
		  		    <c:when test='${article.level > 1 }'>  	<!-- 답변글일 경우 -->
		       		  <c:forEach begin="1" end="${article.level }" step="1">	<!-- 계층 레벨에 비례해서 좌측 공백을 줌 -->
		              <span style="padding-left:10px"></span>    
		       		  </c:forEach>
		      	      <span style="font-size:12px;">[답변]</span>
	                   <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a> <!-- 클릭한 게시글의 글번호를 넘겨줌 -->
		            </c:when>
		            
		            <c:otherwise>	<!-- 최상위 부모글일 경우 -->
		            <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
		            </c:otherwise>
		         </c:choose>
		    </td>
		   <td  width="10%"><fmt:formatDate value="${article.writeDate}" /></td> <!-- 작성일 -->
		 </tr>
	    </c:forEach>
	   </c:when>
	  </c:choose>
	</table>
	
	<!-- 페이징 -->
	<div class="cls2">
 <c:if test="${totArticles != null }" >
      <c:choose>
        <c:when test="${totArticles >100 }">  <!-- 글 개수가 100 초과인경우 -->
	      <c:forEach   var="page" begin="1" end="10" step="1" >
	         <c:if test="${section >1 && page==1 }">
	          <a class="no-uline" href="${contextPath }/board/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
	         </c:if>
	          <a class="no-uline" href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
	         <c:if test="${page ==10 }">
	          <a class="no-uline" href="${contextPath }/board/listArticles.do?section=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
	         </c:if>
	      </c:forEach>
        </c:when>
        <c:when test="${totArticles ==100 }" >  <!--등록된 글 개수가 100개인경우  -->
	      <c:forEach   var="page" begin="1" end="10" step="1" >
	        <a class="no-uline"  href="#">${page } </a>
	      </c:forEach>
        </c:when>
        
        <c:when test="${totArticles< 100 }" >   <!--등록된 글 개수가 100개 미만인 경우  -->
	      <c:forEach   var="page" begin="1" end="${totArticles/10 +1}" step="1" >
	         <c:choose>
	           <c:when test="${page==pageNum }">
	            <a class="sel-page"  href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page } </a>
	          </c:when>
	          <c:otherwise>
	            <a class="no-uline"  href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page } </a>
	          </c:otherwise>
	        </c:choose>
	      </c:forEach>
        </c:when>
      </c:choose>
    </c:if>
</div>    
<br><br>
<a  class="cls1"  href="${contextPath}/board/articleForm.do"><p class="cls2">글쓰기</p></a>

</body>
</html>