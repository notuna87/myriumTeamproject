package com.myrium.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myrium.domain.MemberVO;
import com.myrium.domain.OrderDTO;
import com.myrium.domain.ProductDTO;
import com.myrium.security.domain.CustomUser;
import com.myrium.service.MemberService;
import com.myrium.service.OrderService;
import com.myrium.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/*")
@RequiredArgsConstructor
public class PurchaseController {

	private final MemberService memberservice;
	private final ProductService productservice;
	private final OrderService orderservice;

	@GetMapping("/purchasepage")
	public String goCart(Model model) {

		// 로그인한 사용자 id 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		Long userId = userDetails.getMember().getId();

		// 사용자 정보 불러오기
		MemberVO memberInfo = memberservice.readById(userId);

		// 카트 정보 불러오기
		List<ProductDTO> cartList = productservice.CartListChecked(userId);

		log.info(cartList);

		// 프론트로 정보 보내주기
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("cartList", cartList);

		return "purchase/purchasePage";
	}
	
	// sub페이지에서 바로구매
	@PostMapping("/purchasedirect")
	public String purchaseDirect(Model model, HttpServletRequest request) {
		// 로그인한 사용자 id 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		Long userId = userDetails.getMember().getId();

		// 사용자 정보 불러오기
		MemberVO memberInfo = memberservice.readById(userId);
		
		// 상품 id 값 받아오기
		String productIdStr = request.getParameter("productId");
		int productId = Integer.parseInt(productIdStr);
		
		// 구매하기 페이지 상품 갯수 받아오기
		String quantityStr = request.getParameter("quantityPurchaseHidden");
		int quantity = Integer.parseInt(quantityStr);
		
		log.info("상품 아이디" + productId);
		// 상품 정보 가져오기
		ProductDTO productDirectPurchase = productservice.productDirectPurchase(productId);
		log.info("상품 정보" + productDirectPurchase);
		
		// 프론트로 정보 보내주기
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("productDirectPurchase",productDirectPurchase);
		model.addAttribute("directPurchaseStatus",1);
		model.addAttribute("quantity",quantity);
		
		return "purchase/purchasePage";
	}

	@PostMapping("/purchasecomplete")
	public String purchaseComplete(HttpServletRequest request, Model model) {

		// 로그인한 사용자 id 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUser userDetails = (CustomUser) authentication.getPrincipal();
		Long userId = userDetails.getMember().getId();

		// jsp로부터 정보들 받아오기
		String customerName = request.getParameter("customerName");
		String zipcode = request.getParameter("zipcode");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr = addr1 + " " + addr2;
		String messageSelect = request.getParameter("messageSelect");
		String customMessage = request.getParameter("customMessage");

		// option 선택 직접입력 및 미선택시 값 입력
		if ("msgSelect-0".equals(messageSelect)) {
			messageSelect = "";
		} else if ("msgSelect-6".equals(messageSelect)) {
			messageSelect = customMessage;
		}

		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		String paymentStr = request.getParameter("payment");
		int payment = Integer.parseInt(paymentStr);

		// dto에 정보 집어 넣기
		OrderDTO orders = new OrderDTO();
		orders.setUserId(userId);
		orders.setCustomerId(customerName);
		orders.setZipcode(zipcode);
		orders.setAddress(addr);
		orders.setDeliveryMsg(messageSelect);
		orders.setPhoneNumber(phone);
		orders.setPaymentMethod(payment);

		String paymentStatusText = orders.getPayment(); // getPayment() 호출해서 문자 받아오기

		log.info(paymentStatusText);
		// 오늘 날짜 가져오기
		String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		// 날짜별 주문 카운트
		int count = orderservice.countOrdersToday(today);

		String sequence = String.format("%08d", count + 1);
		String ordersId = today + "-" + sequence;

		orders.setOrdersId(ordersId);

		orderservice.insertOrders(orders);
		Long OrderId = orders.getId(); // select키로 반환받은 orderid 값 가져오기

		// 상품 ID 여러 개 받기
		String[] productIdArray = request.getParameterValues("productId");
		String[] quantityArray = request.getParameterValues("quantity");

		// 상품 리스트를 받은 후 상품들 업데이트
		if (productIdArray != null && quantityArray != null) {
			for (int i = 0; i < productIdArray.length; i++) {
				int productid = Integer.parseInt(productIdArray[i]);
				int quantity = Integer.parseInt(quantityArray[i]);

				orderservice.insertOrdersProduct(productid, OrderId, userId, quantity, customerName, payment);
				orderservice.deletePurchaseCart(userId, productid);
				int getStock = productservice.getStock(productid);
				int getSalesCount = productservice.getSalesCount(productid);

				int decreaseStock = getStock - quantity;
				int increaseSalesCount = getSalesCount + quantity;

				productservice.decreaseStock(decreaseStock, productid);
				productservice.increaseSalesCount(increaseSalesCount, productid);
			}
		} else {
			log.warn("상품 없음");
		}

		// hidden으로부터 가격을 받아와 저장
		String totalPrice = request.getParameter("totalprice");
		String formattedTotal = request.getParameter("formattedTotal");

		// 프론트로 정보 보내주기
		model.addAttribute("orders", orders);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("formattedTotal", formattedTotal);

		List<OrderDTO> productList = orderservice.productList(OrderId);

		model.addAttribute("productList", productList);
		model.addAttribute("paymentStatusText", paymentStatusText);

		return "purchase/purchaseComplete";
	}

}
