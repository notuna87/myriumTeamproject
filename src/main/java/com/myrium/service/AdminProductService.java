package com.myrium.service;

import java.util.List;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

public interface AdminProductService {
	
	   public void register(ProductVO notice);
	   
	   
	   
	   public boolean modify(ProductVO notice);
	   
	   public boolean harddel(Long id);
	
	   public boolean softdel(Long id);
	   
	   public List<ProductVO> getList();
	   
	   public List<ProductVO> getList(Criteria cri, boolean isAdmin);
	   
	   public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(Long id);

	   public void insertAttach(AttachFileDTO dto);
	   
	   public List<ImgpathVO> findByProductId(Long productId);

	   public int deleteImgpathByUuid(String uuid);

	   public void incrementReadCnt(Long id);

	   public List<ProductDTO> getProductListWithCategory(Criteria cri, boolean isAdmin);
	   
	   public ProductVO get(Long id);

	   public void insertCategory(CategoryVO cat);
	   
	   public void insertImgpath(ImgpathVO imgVO);

}
