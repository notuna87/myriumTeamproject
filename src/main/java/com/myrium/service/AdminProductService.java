package com.myrium.service;

import java.util.List;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

public interface AdminProductService {
	
	   public void register(ProductVO notice);
	   
	   public ProductVO get(Long id);
	   
	   public boolean modify(ProductVO notice);
	   
	   public boolean harddel(Long id);
	
	   public boolean softdel(Long id);
	   
	   public List<ProductVO> getList();
	   
	   public List<ProductVO> getList(Criteria cri, boolean isAdmin);
	   
	   public int getTotal(Criteria cri, boolean isAdmin);

	   public boolean restore(Long id);

	   public void insertAttach(AttachFileDTO dto);
	   
	   public List<AttachFileDTO> findByProductId(Long noticeId);

	   public int deleteAttachByUuid(String uuid);

	   public void incrementReadCnt(Long id);

	   public List<ProductDTO> getCategoryList(Criteria cri, boolean isAdmin);
}
