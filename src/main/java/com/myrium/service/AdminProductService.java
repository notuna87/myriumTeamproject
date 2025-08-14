package com.myrium.service;

import java.util.List;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;

public interface AdminProductService {
	
	   public void register(ProductVO vo);	   
	   
	   public boolean modify(ProductVO vo);
	   
	   public boolean harddel(int id);
	
	   public boolean softdel(int id);
	   
	   public List<ProductVO> getList();
	   
	   public List<ProductVO> getList(Criteria cri);
	   
	   public int getTotal(Criteria cri);

	   public boolean restore(int id);

	   public void insertAttach(AttachFileDTO dto);
	   
	   public List<ImgpathVO> findByProductId(int id);

	   public int deleteImgpathByUuid(String uuid);

	   public void incrementReadCnt(int id);

	   public List<ProductDTO> getProductListWithCategory(Criteria cri);
	   
	   public ProductVO get(int id);

	   public void insertCategory(CategoryVO cat);
	
	   public void updateCategory(CategoryVO cat);
	   
	   public void insertImgpath(ImgpathVO imgVO);

	   public List<ImgpathVO> findImgpathByUuid(String uuid);

	   public void updateImgpath(int id);


}
