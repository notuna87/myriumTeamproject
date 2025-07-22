package com.myrium.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myrium.domain.Criteria;
import com.myrium.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class ReplyMapperTests {

   @Autowired
   private ReplyMapper mapper;
   
   private Long[] bnoArr = {156L, 157L, 158L, 159L, 160L};
   
   @Test
   public void testInsert() {
      IntStream.rangeClosed(1,10).forEach(i -> {
         ReplyVO vo = new ReplyVO();
         vo.setBno(bnoArr[i % 5]);
         vo.setReply("reply content");
         vo.setReplyer("replyer");
         mapper.insert(vo);
         
      });
   }
   
   @Test
   public void testRead() {
      
      ReplyVO vo = mapper.read(3L);         
      log.info(vo);
   }
   
   @Test
   public void testDelete() {
      
      int result = mapper.delete(3L);       
      log.info(result);
   }
   
   @Test
   public void testUpdate() {      
      ReplyVO vo = new ReplyVO();      
      vo.setRno(1L);
      vo.setReply("1        ");      
      mapper.update(vo);
   }
   
   @Test
   public void testList() {
      Criteria cri = new Criteria(2,5);
      List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
      
      replies.forEach(reply->log.info(reply));
   }

   @Test
   public void testInsert2() {
      IntStream.rangeClosed(1, 20).forEach(i->{
         ReplyVO vo = new ReplyVO();
         vo.setBno(bnoArr[0]); 
         vo.setReply("reply"+i);
         vo.setReplyer("replyer");
         mapper.insert(vo);
         
      });
   }
   
   @Test
   public void testList2() {
      Criteria cri = new Criteria(1, 10);
         
      List<ReplyVO> replies = mapper.getListWithPaging(cri, 160L);
      replies.forEach(reply -> log.info(reply));
   }
   
   @Test
   public void testCount() {
      int count = mapper.getCountByBno(3323L);
      log.info("count : " + count);
   }
}
