package com.myrium.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.myrium.domain.Criteria;
import com.myrium.domain.ReplyPageDTO;
import com.myrium.domain.ReplyVO;
import com.myrium.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/replies/*")
//@RequiredArgsConstructor
@NoArgsConstructor
public class ReplyController {

	@Autowired
	private ReplyService service;
	
	@GetMapping("/test")	
	public String testReply() {
		return "test";
	}
	
	
	@PostMapping(value = "/new" , consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO: " + vo);
		int insertCount = service.register(vo);
		return insertCount == 1 ?
				new ResponseEntity<String>("success", HttpStatus.OK) :
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			
	}
	

    @GetMapping(value = "/pages/{bno}/{page}" , produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
								@PathVariable("bno") Long bno,
								@PathVariable("page") int page){
		
		log.info("getList..........");
		Criteria cri =  new Criteria(page, 10);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
		
	}
    

    @GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		log.info("get: " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}  
    

	@DeleteMapping(value = "/{rno}/hard", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> harddel(@PathVariable("rno") Long rno) {
		log.info("reply - harddelete: " + rno);
		return service.harddelete(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}    
	
	@PatchMapping(value = "/{rno}/soft", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> softdel(@PathVariable("rno") Long rno) {
		log.info("reply - softdelete: " + rno);
		return service.softdelete(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}    
	

    @RequestMapping(method = RequestMethod.PUT, value = "/{rno}", consumes = "application/json", produces = {
		MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
	
		vo.setRno(rno);
	
		log.info(vo);
	
		log.info("rno: " + rno);
		log.info("modify: " + vo);
	
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	
	}
}
