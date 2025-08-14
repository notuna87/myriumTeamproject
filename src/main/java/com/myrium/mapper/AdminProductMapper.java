package com.myrium.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductVO;

public interface AdminProductMapper {
	
	public List<ProductVO> getList();
	
	public void insert(ProductVO product);
	
	public void insertSelectKey(ProductVO product);
	
	public ProductVO get(int id);
	
	public int harddel(int id); //하드(영구) 삭제
	
	public int softdel(int id); //소프트 삭제
	
	public int restore(int id); //복구
	
	public int update(ProductVO product);	
	
	public List<ProductVO> getListWithPaging(@Param("cri") Criteria cri);	
	
	public int getTotalCount(@Param("cri") Criteria cri);
	
	public List<ProductVO> searchTest(Map<String, Map<String, String>> map);	
	
	public void updateReadCnt(@Param("id") int id, @Param("amount") int amount);
	
	public void insertAttach(AttachFileDTO dto);

	public List<ImgpathVO> findByProductId(int id);	

	public int deleteImgpathByUuid(@Param("uuid") String uuid);	
	
	public void updateReadCnt(int id);	
	
	public List<ProductVO> getProductList(@Param("cri") Criteria cri);
	
	public CategoryVO getCategoryList(int id);
	
	public ImgpathVO getImgPathList(int id);
	
	public void insertCategory(CategoryVO cat);
	
	public void updateCategory(CategoryVO cat);
	
	public void insertImgpath(ImgpathVO imgVO);
	
	//public void updateThumbnailMain(@Param("product_id") int product_id, @Param("uuid") String uuid);
	public void updateThumbnailMain(@Param("id") int id, @Param("is_thumbnail_main") int is_thumbnail_main);
	
	public List<ImgpathVO> findImgpathByUuid(String uuid);
	
	public void updateImgpath(int id);



}