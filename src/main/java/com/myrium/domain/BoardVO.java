package com.myrium.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
    private Long id;             // 게시글 ID (PK)
    private Long userId;         // 작성자 회원번호 (FK) to member.id
    private String title;        // 제목
    private String content;      // 내용
    private String customerId;   // 작성자 로그인 ID (표시용)
    
    private Date writeDate;      // 작성일
    private Integer isAnswered;  // 답변 여부 (0/1)
    private Integer isDeleted;   // 삭제 여부 (0/1)
    
    private Date createdAt;      // 생성일
    private String createdBy;    // 생성자 ID
    private Date updatedAt;      // 수정일
    private String updatedBy;    // 수정자 ID
    
    private Integer replyCnt;    // 답변 수
}
