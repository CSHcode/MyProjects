package brd;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/*")
public class BoardController extends HttpServlet {
	BoardService boardService;
	ArticleVO articleVO;

	public void init(ServletConfig config) throws ServletException {
		boardService = new BoardService();
		articleVO = new ArticleVO();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = "";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session;
		String action = request.getPathInfo();
		System.out.println("action: " + action);
		try {
			List<ArticleVO> articlesList = new ArrayList<ArticleVO>();
			if (action == null) {														//최초 진입시
				String _section = request.getParameter("section");						//섹션 번호
				String _pageNum = request.getParameter("pageNum");						//페이지 번호
				int section = Integer.parseInt(((_section == null) ? "1" : _section));	
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				Map<String, Integer> pagingMap = new HashMap<String, Integer>();		//섹션번호와 페이지번호를 담을 map
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				Map articlesMap = boardService.listArticles(pagingMap);					//articleList, totArticles 저장되어있음
				articlesMap.put("section", section);
				articlesMap.put("pageNum", pageNum);
				request.setAttribute("articlesMap", articlesMap);
				nextPage = "/board06/listArticles.jsp";
				
			} else if (action.equals("/listArticles.do")) {
				String _section = request.getParameter("section");
				String _pageNum = request.getParameter("pageNum");
				int section = Integer.parseInt(((_section == null) ? "1" : _section));
				int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
				Map pagingMap = new HashMap();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				Map articlesMap = boardService.listArticles(pagingMap);
				articlesMap.put("section", section);
				articlesMap.put("pageNum", pageNum);
				request.setAttribute("articlesMap", articlesMap);
				nextPage = "/board6/listArticles.jsp";
				
			} else if (action.equals("/articleForm.do")) {							//글쓰기 클릭시 
				nextPage = "/board6/articleForm.jsp";
				
			} else if (action.equals("/addArticle.do")) {							//글쓰기 양식에서 작성 완료 후 글쓰기 클릭시
				String title = request.getParameter("title");
				String id = request.getParameter("ID");
				String content = request.getParameter("content");

				articleVO.setParentNO(0);			//새로 쓴 글이므로 부모글 번호는 0
				articleVO.setId(id);
				articleVO.setTitle(title);
				articleVO.setContent(content);
				int articleNO = boardService.addArticle(articleVO);
				nextPage = "/board/listArticles.do";
				
			} else if (action.equals("/viewArticle.do")) {			//글 제목 클릭시
				String articleNO = request.getParameter("articleNO"); // 클릭한 글의 articleNO
				articleVO = boardService.viewArticle(Integer.parseInt(articleNO));
				request.setAttribute("article", articleVO);
				nextPage = "/board6/viewArticle.jsp";
				
			} else if (action.equals("/modArticle.do")) {			//수정 반영하기 클릭시
				String articleNO = request.getParameter("articleNO");  //원래 글번호
				String title = request.getParameter("title");			//변경된 제목
				String content = request.getParameter("content");		//변경된 글내용

				articleVO.setArticleNO(Integer.parseInt(articleNO));
				articleVO.setTitle(title);
				articleVO.setContent(content);
				boardService.modArticle(articleVO);

				PrintWriter pw = response.getWriter();
				pw.print("<script> alert('글을 수정했습니다.'); location.href='" + request.getContextPath()
						+ "/board/viewArticle.do?articleNO=" + articleNO + "'; </script>");
				return;
				
			} else if (action.equals("/removeArticle.do")) {
				int articleNO = Integer.parseInt(request.getParameter("articleNO"));
				boardService.removeArticle(articleNO);

				PrintWriter pw = response.getWriter();
				pw.print("<script> alert('글을 삭제했습니다.'); location.href='" + request.getContextPath()
						+ "/board/listArticles.do'; </script>");
				return;
				
			} else if (action.equals("/replyForm.do")) {
				int parentNO = Integer.parseInt(request.getParameter("parentNO"));	//보고있던 글의 글번호를 parentNO로 넘겨받음
				session = request.getSession();
				session.setAttribute("parentNO", parentNO);
				nextPage = "/board6/replyForm1.jsp";
				
			} else if (action.equals("/addReply.do")) {
				session = request.getSession();
				int parentNO = (Integer) session.getAttribute("parentNO");
				session.removeAttribute("parentNO");
				String id = request.getParameter("id");
				String title = request.getParameter("title");
				String content = request.getParameter("content");

				articleVO.setParentNO(parentNO);
				articleVO.setId(id);
				articleVO.setTitle(title);
				articleVO.setContent(content);
				int articleNO = boardService.addReply(articleVO);
				PrintWriter pw = response.getWriter();
				pw.print("<script> alert('답글을 추가했습니다.'); location.href='" + request.getContextPath()
						+ "/board/viewArticle.do?articleNO=" + articleNO + "'; </script>");
				return;
				
			} else {
				nextPage = "/listArticles.jsp";
			}
			
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
