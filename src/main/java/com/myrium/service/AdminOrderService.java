package com.myrium.service;

import java.util.List;

import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;

public interface AdminOrderService {
	
	   public void register(OrderDTO dto);	   
	   
	   public boolean modify(OrderDTO dto);
	   
	   public boolean harddel(int id);
	
	   public boolean softdel(int id);
	   
	   public List<OrderDTO> getList();
	   
	   //public List<OrderDTO> getOrderListWithProduct(Criteria cri, boolean isAdmin);
	   public List<OrderDTO> getOrderList(Criteria cri, boolean isAdmin);
	   
	   public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(int id);
  
	   public OrderDTO get(int id);
	   
}
