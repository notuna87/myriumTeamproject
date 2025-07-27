package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno;
	private Long bno;
	private Long user_id;
	private String customer_id;
	private String reply;
	private String replyer;
	private int is_deleted;
	private Date reply_date;
	private Date created_at;
	private Date updated_date;
	private String updated_by;
	private int writer_is_admin;


}
