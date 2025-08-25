package app.labs.ex06.mvc02;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PageViewLogInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    System.out.println("컨트롤러가 실행되기 전입니다.");
	    request.setCharacterEncoding("utf-8");

	    System.out.println("URI: " + request.getRequestURI());
	    System.out.println("현재 시간: " + new java.util.Date());

	    // 로그인 처리 (세션 값 안전하게 확인)
	    HttpSession session = request.getSession(false); // 세션 없으면 null
	    String id = null;

	    if (session != null && session.getAttribute("userid") != null) {
	        id = session.getAttribute("userid").toString();
	    }

	    if (id == null || id.isEmpty()) {
	        System.out.println("로그인 정보 없음 → 로그인 페이지로 리다이렉트");
	        // response.sendRedirect(request.getContextPath() + "/login");
	        // return false;   // 로그인 필수라면 차단
	    } else {
	        System.out.println("로그인 사용자: " + id);
	    }

	    return true; // 계속 진행
	}

	
	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
		System.out.println("컨트롤러가 실행된 후입니다.(뷰가 실행되기 전)");
		System.out.println("뷰 이름: " + modelAndView.getViewName());
		
		
		
	}
	
	@Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		System.out.println("뷰가 실행된 후입니다.");
	}
}
