package com.myrium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.AuthVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;

public interface AdminOrderMapper {
	
	public List<OrderDTO> getList();	
	public void insert(OrderDTO order);
	public void insertSelectKey(OrderDTO order);
	public OrderDTO read(int id);
	public int harddel(int id); //하드(영구) 삭제
	public int softdel(int id); //소프트 삭제
	public int restore(int id); //복구
	public int update(OrderDTO order);	
	public List<OrderDTO> getListWithPaging(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);	
	public int getTotalCount(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);	
	
	public List<OrderDTO> getOrderList(@Param("cri") Criteria cri, @Param("isAdmin") boolean isAdmin);
	
	public List<AuthVO> getAuthList(Long id);
	
	public Integer countAdminRole(Long id);
	
	public void insertAdminRole(Long id);
	
	public void deleteAdminRole(Long id);



}