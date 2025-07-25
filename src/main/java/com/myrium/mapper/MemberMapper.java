package com.myrium.mapper;

import java.util.List;

import com.myrium.domain.AuthVO;
import com.myrium.domain.MemberVO;

public interface MemberMapper {
	
    public void insertMember(MemberVO member);
    
	public void insertAuth(AuthVO auth);

    public MemberVO getMemberById(int id);

    public List<MemberVO> getAllMembers();

    public int updateMember(MemberVO member);

    public int deleteMember(int id);
    
    public MemberVO read(String customer_id);
    
    int checkIdDuplicate(String customer_id);  // 아이디 중복 체크

    public MemberVO selectByCustomerId(String customerId);

}





