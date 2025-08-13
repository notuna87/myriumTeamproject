package com.myrium.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.AuthVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.OrderDTO;
import com.myrium.mapper.AdminOrderMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminOrderServiceImpl implements AdminOrderService{
	
	@Autowired
	private AdminOrderMapper mapper;




	@Override
	public List<OrderDTO> getList() {
		log.info("Order getList.....");
		return mapper.getList();
	}


	@Override
	public void register(OrderDTO order) {
		log.info("order register....." + order);
		mapper.insertSelectKey(order);
	}
	
//	@Override
//	public List<OrderDTO> getList(Criteria cri, boolean isAdmin){
//		log.info("order getList...(Criteria cri)");
//		return mapper.getList(cri, isAdmin);
//		//return mapper.getListWithPaging(cri, isAdmin);
//	}
	
	@Override
	public int getTotal(Criteria cri, boolean isAdmin) {
		log.info(mapper.getTotalCount(cri, isAdmin));
		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(int id) {
		log.info("order restore...." + id);
		return mapper.restore(id)==1;
	}
	
	
	// 회줜정보 & 권한 리스트
//	@Override
//	public List<OrderDTO> getOrderList(Criteria cri, boolean isAdmin) {
//		//List<OrderDTO> orderList = mapper.getOrderList(cri, isAdmin);
//		//List<OrderDTO> orderDTOList = new ArrayList<>();		
//		//for (OrderDTO order : orderList) {
//		//	List<AuthVO> auth = mapper.getAuthList(order.getId());
//		//	log.info("getAuthList:" + auth);
//			//order.setAuthList(auth);
//			//orderDTOList.add(order);
//		
//		return mapper.getOrderList(cri, isAdmin);
//	}
	
	public List<OrderDTO> getOrderList(Criteria cri, boolean isAdmin) {
	    // 1) 주문 ID 리스트 페이징 쿼리 호출
	    List<Integer> orderIds = mapper.getPagedOrderIds(cri);

	    if (orderIds == null || orderIds.isEmpty()) {
	        return Collections.emptyList();
	    }

	    // 2) 주문 ID 리스트로 주문 + 상품 상세 조회
	    List<OrderDTO> orders = mapper.getOrdersWithProducts(orderIds);

	    return orders;
	}
	
	
	@Override
	public OrderDTO get(int id) {
	      log.info("order get....." + id);
	      OrderDTO order = mapper.read(id);
	      List<AuthVO> auth = mapper.getAuthList(order.getId());
	      //order.setAuthList(auth);
	      return order;
	}
	
	@Override
	public boolean modify(OrderDTO vo) {
	     log.info("Member modify.... " + vo);
	     return mapper.update(vo)==1;
	}

	@Override
	public boolean harddel(int id) {
	     log.info("order harddel...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(int id) {
		log.info("Member softdel...." + id);
		return mapper.softdel(id)==1;
	}


	@Override
	public void updateOrderStatus(String ordersId, int ordersProductId, int orderStatus) {
		mapper.updateOrderProductStatus(ordersProductId, orderStatus);		
		mapper.updateOrderStatus(ordersId, orderStatus);		
	}



	
}
