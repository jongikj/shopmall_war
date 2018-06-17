package com.shopmall.web.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LogInterceptor extends HandlerInterceptorAdapter {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("========== 로그인 인터셉터 ==========");
		logger.info("Request URI : " + request.getRequestURI());
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/member/goLogin");
			return false;
		} else {
			return true;
			//return super.preHandle(request, response, handler);
		}
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("========== LOGGING OUT ==========");
	}
}
