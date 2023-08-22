package com.crud;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CrudFilter implements Filter {
	public void init(FilterConfig arg0) throws ServletException {
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {

		PrintWriter out = resp.getWriter();

		String password = req.getParameter("password");

		if (password.equals("admin")) {
			System.out.println("hiii");
			RequestDispatcher rd = req.getRequestDispatcher("/crud.jsp");
			rd.include(req, resp);
		} else {
			out.println("<div>wrong password</div>");
			RequestDispatcher rd = req.getRequestDispatcher("NewFile.html");
			rd.include(req, resp);

		}

	}

	public void destroy() {
	}
}
