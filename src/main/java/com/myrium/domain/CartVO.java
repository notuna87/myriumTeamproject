package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {

	 private Long id;             
	    private Long productId;     
	    private Long userId;          
	    private int quantity;        
	    private int isSelected;      
	    private String createdBy;     
	    private Date createdAt;       
	    private String updatedBy;     
	    private Date updatedAt;        
	    private int isDeleted;
	    
}
