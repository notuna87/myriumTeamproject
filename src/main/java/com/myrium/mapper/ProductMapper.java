package com.myrium.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.myrium.domain.CartVO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductVO;

// 작성자 : 노기원
// 작성일 : 2025.07.23 14:44
// 내용 : 상품 목록 불러오기 및 product_id 일치하는 썸네일 불러오기
@Mapper
public interface ProductMapper {

	// 썸네일 불러오기
	public ImgpathVO getThumbnail(int productid);

	// 카테고리 목록 불러오기
	public List<ProductVO> getproductList(String category);

	// 타임세일 목록 불러오기
	public List<ProductVO> gettimesaleList();

	// 상품 상세페이지 정보 불러오기
	public ProductVO getproductInfo(int id);

	// 상품 상세페이지 썸네일
	public ImgpathVO productInfothumbnail(int id);

	// 상세페이지 슬라이더 이미지 목록 불러오기
	public List<ImgpathVO> productSliderImg(int id);

	// 상세페이지 상품상세정보 이미지 불러오기
	public ImgpathVO productDetailImg(int id);

	// 판매량순 상위 10개 상품 가져오기
	public List<ProductVO> getPopularProduct();

	// 장바구니 상품 추가
	public CartVO inCart(@Param("quantity") int quantity, @Param("productId") int productId,
			@Param("userId") Long userId, @Param("customerId") String customerId);
	
	// 장바구니 리스트 가져오기
	public List<ProductVO> CartList(Long userId);
	
	// 카트 수량 불러오기
	public CartVO getCartInfo(@Param("productId") int productId,  @Param("userId") Long userId);
	
	// 중복된 상품이 장바구니에 담겼는지 확인하기
	public CartVO findCartItem(@Param("productId") int productId, @Param("userId") Long userId);

	// 중복일시 update set
	public CartVO addQuantity(@Param("productId") int productId, @Param("userId") Long userId,@Param("newQuantity") Integer newQuantity);

	// 중복일시 update set
	int updateQuantity(@Param("productId") Long productId, @Param("userId") Long userId,@Param("newQuantity") Integer newQuantity);

	int deleteCart(@Param("productId") Long productId, @Param("userId") Long userId);

	public List<ProductVO> ProductList();

	public CategoryVO getCategory(int id);

}
