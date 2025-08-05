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
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminProductServiceImpl implements AdminProductService{
	
	@Autowired
	private AdminProductMapper mapper;


	@Override
	public ProductVO get(int id) {
	      log.info("product get....." + id);
	      return mapper.read(id);
	}


	@Override
	public boolean modify(ProductVO product) {
	     log.info("product modify.... " + product);
	     return mapper.update(product)==1;
	}

	@Override
	public boolean harddel(int id) {
	     log.info("product harddel...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(int id) {
		log.info("product softdel...." + id);
		return mapper.softdel(id)==1;
	}

	@Override
	public List<ProductVO> getList() {
		log.info("product getList.....");
		return mapper.getList();
	}


	@Override
	public void register(ProductVO product) {
		log.info("product register....." + product);
		mapper.insertSelectKey(product);
	}
	
	@Override
	public List<ProductVO> getList(Criteria cri, boolean isAdmin){
		log.info("product getList...(Criteria cri)");
		//return mapper.getList();
		return mapper.getListWithPaging(cri, isAdmin);
	}
	
	@Override
	public int getTotal(Criteria cri, boolean isAdmin) {
		log.info(mapper.getTotalCount(cri, isAdmin));
		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(int id) {
		log.info("product restore...." + id);
		return mapper.restore(id)==1;
	}
	
	@Override
	public void insertAttach(AttachFileDTO dto) {
		log.info("product Attach...." + dto);
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
	public List<ProductDTO> getProductListWithCategory(Criteria cri, boolean isAdmin) {
		List<ProductVO> productList = mapper.getProductList(cri, isAdmin);
		List<ProductDTO> productDTO = new ArrayList<>();		
		for (ProductVO product : productList) {
			CategoryVO category = mapper.getCategoryList(product.getId());
			ImgpathVO imgpath = mapper.getImgPathList(product.getId());
			log.info("getImgPathList:" + imgpath);
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
	
}
