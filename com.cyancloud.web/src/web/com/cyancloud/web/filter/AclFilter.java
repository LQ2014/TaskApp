package com.cyancloud.web.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.cyancloud.commons.web.SessionAttributeNames;
import com.cyancloud.service.SystemService;
public class AclFilter extends OncePerRequestFilter
{
	private static Map<String, List<String>> protectedUrlMap;
	private static boolean permit;

	public static final String ERROR_INFO = "error";
	private static String contextPath;
	private static final String ROOT_CONTEXT = "/";
	private static final String PERMIT = "permit";

	private static final Map<String, String> uriMaps;
	static
	{
		uriMaps = new HashMap<String, String>();
		uriMaps.put("login.do", "Y");
		uriMaps.put("logout.do", "Y");
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
			FilterChain filterChain) throws ServletException, IOException
	{
//		 String uri = getUri(request);
		//
		//
		// // 判断session中是否包含ucode
		// String ucode = SessionAttributeNames.getUcode(request);
		// if (ucode == null || ucode.length() == 0)
		// {
		// ucode = request.getRemoteUser();
		// if (ucode == null || ucode.length() == 0)
		// {
		// response.sendRedirect(this.getNorightUri());
		// return;
		// }
		// }
		String uri = getUri(request);
		if(uri.indexOf("login")<0 ){
			String ucode = SessionAttributeNames.getUcode(request);
			if(ucode==null || ucode.length()==0){
				 response.sendRedirect(request.getContextPath());
				 return;
			}
		}
		
		filterChain.doFilter(request, response);
		return;
	}


	private String getUri(HttpServletRequest request)
	{

		if (contextPath == null) contextPath = "" + request.getContextPath();
		String uri = request.getRequestURI();
		if (!(contextPath.equals(ROOT_CONTEXT))) uri = uri.replaceFirst(contextPath + "/", "");
		return uri;
	}

	

	protected void loginLog(HttpServletRequest request, String ucode, Long result)
	{

		WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(request
				.getSession().getServletContext());
		SystemService logService = (SystemService) ac.getBean("systemLogService");
		
	}

	
}
