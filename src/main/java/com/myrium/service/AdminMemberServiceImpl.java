package com.myrium.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myrium.domain.AttachFileDTO;
import com.myrium.domain.CategoryVO;
import com.myrium.domain.Criteria;
import com.myrium.domain.ImgpathVO;
import com.myrium.domain.MemberVO;
import com.myrium.mapper.AdminMemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService{
	
	@Autowired
	private AdminMemberMapper mapper;


	@Override
	public MemberVO get(int id) {
	      log.info("Member get....." + id);
	      return mapper.read(id);
	}


	@Override
	public boolean modify(MemberVO vo) {
	     log.info("Member modify.... " + vo);
	     return mapper.update(vo)==1;
	}

	@Override
	public boolean harddel(int id) {
	     log.info("Member harddel...." + id);
	     return mapper.harddel(id)==1;
	}

	@Override
	public boolean softdel(int id) {
		log.info("Member softdel...." + id);
		return mapper.softdel(id)==1;
	}

	@Override
	public List<MemberVO> getList() {
		log.info("Member getList.....");
		return mapper.getList();
	}


	@Override
	public void register(MemberVO member) {
		log.info("Member register....." + member);
		mapper.insertSelectKey(member);
	}
	
	@Override
	public List<MemberVO> getList(Criteria cri, boolean isAdmin){
		log.info("Member getList...(Criteria cri)");
		//return mapper.getList();
		return mapper.getListWithPaging(cri, isAdmin);
	}
	
	@Override
	public int getTotal(Criteria cri, boolean isAdmin) {
		log.info(mapper.getTotalCount(cri, isAdmin));
		return mapper.getTotalCount(cri, isAdmin);	}
	
	@Override
	public boolean restore(int id) {
		log.info("Member restore...." + id);
		return mapper.restore(id)==1;
	}
	
	@Override
	public void insertAttach(AttachFileDTO dto) {
		log.info("Member Attach...." + dto);
		mapper.insertAttach(dto);
	}
	
    @Override
    public List<ImgpathVO> findByMemberId(int id) {
        return mapper.findByMemberId(id);
    }
    
    @Override
    public int deleteImgpathByUuid(String uuid) {
        return mapper.deleteImgpathByUuid(uuid);
    }
    
    @Override    
    public void incrementReadCnt(int id) {
        mapper.updateReadCnt(id);
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
