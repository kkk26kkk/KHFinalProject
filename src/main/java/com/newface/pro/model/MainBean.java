package com.newface.pro.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class MainBean {
	private String	id;
	private int	board_no;
	private String	name;
	private String	content;
	
	private MultipartFile[] uploadfile ;	//파일
	
	private String	board_file;		//변경 파일
	private String 	board_original;	//원래 파일
	private String	reg_date;
	private Date	like_date;
	private int	like_count;
	
	private String like_id;			//좋아요사람
	private int like_status;		//좋아요 여부

	
	public int getLike_status() {
		return like_status;
	}
	public void setLike_status(int like_status) {
		this.like_status = like_status;
	}
	public String getLike_id() {
		return like_id;
	}
	public void setLike_id(String like_id) {
		this.like_id = like_id;
	}
	public MultipartFile[] getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile[] uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getBoard_original() {
		return board_original;
	}
	public void setBoard_original(String board_original) {
		this.board_original = board_original;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}

	public Date getLike_date() {
		return like_date;
	}
	public void setLike_date(Date like_date) {
		this.like_date = like_date;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	


}
