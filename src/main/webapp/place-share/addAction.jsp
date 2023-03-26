<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.placeShare.PlaceShareBoardDto"%>
<%@page import="member.MemberDao"%>
<%@page import="com.mysql.cj.Session"%>
<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%

	request.setCharacterEncoding("utf-8");
	
	MultipartRequest multi = null;
	
	//이미지 저장 실제경로(저장 디렉토리, 절대 경로)
	String realPath = getServletContext().getRealPath("place-share/place-photo");
	System.out.print(realPath);
	
	try {
		
		int uploadSize=1024*1024*10;
		
		multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());

		MemberDao memberDao = new MemberDao();
		PlaceShareBoardDao dao = new PlaceShareBoardDao();
		String myid = (String)session.getAttribute("myid");
		
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content").replace("\r\n","<br>");
		String photoName = multi.getFilesystemName("photo1");	
		//위도
		String placeLa = multi.getParameter("la");
		//경도
		String placeMa = multi.getParameter("ma");
		//맵 주소
		String mapAddr = multi.getParameter("mapAddr");
		
		PlaceShareBoardDto dto = new PlaceShareBoardDto();
		dto.setId(myid);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPhotoName(photoName);
		dto.setPlaceLa(placeLa);
		dto.setPlaceMa(placeMa);
		dto.setMapAddr(mapAddr);
		
		dao.insertBoard(dto);
		
		response.sendRedirect("../index.jsp?main=place-share/boardList.jsp");

	} catch(Exception e) {
       response.sendRedirect("UploadFail.jsp");
	}
%>