package com.myrium.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.myrium.domain.MemberVO;
import com.myrium.mapper.MemberMapper;
import com.myrium.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private MemberMapper memberMapper;  // 회원정보와 권한정보

//	@Override
//	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		log.warn("Load User By Username : " + username);
//		return null;
//	} 
	
	@Override
	public UserDetails loadUserByUsername(String customerId) throws UsernameNotFoundException {
		log.warn("Load User By Username : " + customerId);		
		MemberVO vo = memberMapper.read(customerId);		
		log.warn("queried by member mapper: " + vo);
		return vo == null ? null : new CustomUser(vo);
	} 
	
//	@Override
//	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//	    MemberVO vo = mapper.read(username);  // DB에서 사용자 조회
//	    if(vo == null) throw new UsernameNotFoundException("User not found");
//	    return new CustomUser(vo); // UserDetails 구현체 반환
//	}
}
