package com.myrium.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.ProductDTO;
import com.myrium.domain.ProductVO;
import com.myrium.mapper.AdminProductMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class AdminProductServiceImpl implements AdminProductService{
	

	private final AdminProductMapper mapper;


	@Override
	public ProductVO get(int id) {
	      return mapper.get(id);
	}

	@Override
	public boolean modify(ProductVO vo) {
	     return mapper.update(vo)==1;
	}

	@Override
	public boolean harddel(int id) {
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(int id) {
		return mapper.softdel(id)==1;
	}

	@Override
	public List<ProductVO> getList() {
		return mapper.getList();
	}

	@Override
	public void register(ProductVO product) {
		mapper.insertSelectKey(product);
	}
	
	@Override
	public List<ProductVO> getList(Criteria cri){
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public boolean restore(int id) {
		return mapper.restore(id)==1;
	}
	
	@Override
	public void insertAttach(AttachFileDTO dto) {
		mapper.insertAttach(dto);
	}
	
    @Override
    public List<ImgpathVO> findByProductId(int id) {
        return mapper.findByProductId(id);
    }
    
    @Override
    public int deleteImgpathByUuid(String uuid) {
        return mapper.deleteImgpathByUuid(uuid);
    }
    
    @Override    
    public void incrementReadCnt(int id) {
        mapper.updateReadCnt(id);
    }

	// 카테고리 및 상품 리스트
	@Override
	public List<ProductDTO> getProductListWithCategory(Criteria cri) {
		List<ProductVO> productList = mapper.getProductList(cri);
		List<ProductDTO> productDTO = new ArrayList<>();		
		for (ProductVO product : productList) {
			CategoryVO category = mapper.getCategoryList(product.getId());
			ImgpathVO imgpath = mapper.getImgPathList(product.getId());
			ProductDTO dto = new ProductDTO();
			dto.setProduct(product);
			dto.setThumbnail(imgpath);
			dto.setCategory(category);
			productDTO.add(dto);
		}
		return productDTO;
	}

	@Override
	public void insertCategory(CategoryVO cat) {
		mapper.insertCategory(cat);		
	}
	
	@Override
	public void updateCategory(CategoryVO cat) {
		mapper.updateCategory(cat);		
	}	
	
	@Override
	public void insertImgpath(ImgpathVO imgVO) {
		mapper.insertImgpath(imgVO);		
	}

	@Override
	public List<ImgpathVO> findImgpathByUuid(String uuid) {
		return mapper.findImgpathByUuid(uuid);
	}

	@Override
	public void updateImgpath(int id) {
		mapper.updateImgpath(id);	
		
	}

	
}
