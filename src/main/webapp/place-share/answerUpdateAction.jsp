<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@page import="answer.placeShare.PlaceShareAnswerDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
request.setCharacterEncoding("utf-8");

String content = request.getParameter("content");
String idx = request.getParameter("idx");
String boardnum = request.getParameter("boardnum");
String currentPage = request.getParameter("currentPage");

System.out.println(content);
System.out.println(idx);

PlaceShareAnswerDao dao = new PlaceShareAnswerDao();

PlaceShareAnswerDto dto = dao.getData(idx);
dto.setContent(content);

dao.updateAnswer(dto);

%>