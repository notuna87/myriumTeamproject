<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp" %> 

<body>

<div class="row">
    <div class="col-lg-12">
	<h1 class="page-header">문의사항 보기</h1>
    </div>
</div>

<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">문의사항 보기</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<div class="form-group">
				 <label>No.</label> 
                 <input class="form-control" name='id' value=${board.id} readonly="readonly">
			</div>

			<div class="form-group">
				<label>제목</label>
                <input class="form-control" name='title' value=${board.title} readonly="readonly">
			</div>

			<div class="form-group">
				<label>내용</label>
				<textarea class="form-control" rows="3" name='content' readonly="readonly">${board.content}</textarea>
			</div>

			<div class="form-group">
				<label>작성자</label> 
                <input class="form-control" name='customerId' value=${board.customerId } readonly="readonly">
			</div>
			
			<sec:authentication property="principal" var="pinfo"/>
				        <sec:authorize access="isAuthenticated()">
				        <c:if test="${pinfo.username eq board.customerId}">
				       	 <button data-oper='modify' class="btn btn-default">수정</button>			
				        </c:if>
			</sec:authorize>
			
			<%-- <button data-oper='modify' class="btn btn-default btn-success"
					onclick="location.href='/board/modify?id=${board.id}'">Modify</button> --%>
			            
			<button data-oper='list' class="btn btn-default btn-info"
					onclick="location.href='/board/list'">목록</button>
					
			<form id='operForm' action="/board/modify" method='get'>
				<input type='hidden' id="id" name='id' value='${board.id}'>
				<input type='hidden' name='pageNum' value='${cri.pageNum}'>
				<input type='hidden' name='amount' value='${cri.amount}'>
				<input type='hidden' name='type' value='${cri.type}'>
				<input type='hidden' name='keyword' value='${cri.keyword}'>
			</form>
			
		</div>
		<!-- /.panel-body -->
	</div>
	<!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>

<!-- /.row -->
<!-- 답변추가 -->
<div class='row'>
  <div class="col-lg-12">
    <!-- /.panel -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> 답변
          <sec:authorize access="isAuthenticated()">
        	<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>답변하기</button>
	      </sec:authorize>
      </div>      
      <!-- /.panel-heading -->
      <div class="panel-body">        
        <ul class="chat">
        	<li class="left clearfix" data-rno="12">
        		<div>
        			<div class="header">
        				<strong class="primary-font" >user00</strong>
        				<small class="pull-right text-muted" >2024-02-05</small>
        			</div>
        		</div>
        	</li>
        </ul>
        <!-- ./ end ul -->
      </div>
      <!-- /.panel .chat-panel -->
	<div class="panel-footer">
		</div>
		</div>
  </div>
  <!-- ./ end row -->
  
</div>

<!-- 답변추가 end-->


<!-- 새 답변 Modal -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">답변 작성</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>답변</label> 
                <input class="form-control" name='reply' value='새 답변!!!!'>
              </div>      
              <div class="form-group">
                <label>작성자</label> 
                <input class="form-control" name='replyer' value='작성자'>
              </div>
              <div class="form-group">
                <label>작성일시</label> 
                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              </div>
      
            </div>
<div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
        <button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
      </div>          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
 <!-- /새 답변 .modal -->

</div>
<!-- /#page-wrapper -->


</body>

<%@include file="../includes_admin/footer.jsp" %> 
<%@include file="../main/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">

$(document).ready(function() {
  
	var idValue = '${board.id}';
	var replyUL = $(".chat");
	
	console.log(idValue);
	console.log(replyUL);
	
    //답변목록의 페이지번호 1
	showList(1);
	    
	 function showList(page){
	  
          replyService.getList({id:idValue, page: page|| 1 }, function(replyCnt, list) {

	   	    console.log("replyCnt: "+ replyCnt );
	   	    console.log("list: " + list);
	   	    console.log(list);
	   	    
	   	    if(page == -1){
	   	      pageNum = Math.ceil(replyCnt/10.0);
	   	      showList(pageNum);
	   	      return;
	   	    }  
  
	      var str="";
	      
	      if(list == null || list.length == 0){
	          replyUL.html("");
	    	  return;
	      }
	      
	      
	      for (var i = 0, len = list.length || 0; i < len; i++) {
	          str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
	          str +="  <div><div class='header'><strong class='primary-font'>["
	       	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
	          str +="    <small class='pull-right text-muted'>"
	        	  +replyService.displayTime(list[i].replyDate)+"</small></div>";
	          str +="    <p>"+list[i].reply+"</p></div></li>";
	        }
	        
	        
	        replyUL.html(str);
	        
	        showReplyPage(replyCnt);
	
		 }); //end function
	}  //end showList
	
	
	
	
	//페이징 처리 시작
	    var pageNum = 1;
	    var replyPageFooter = $(".panel-footer");
	   
	     function showReplyPage(replyCnt){
	     
		      var endNum = Math.ceil(pageNum / 10.0) * 10;  
		      var startNum = endNum - 9; 
		      
		      var prev = startNum != 1;
		      var next = false;
		      
		      if(endNum * 10 >= replyCnt){
		        endNum = Math.ceil(replyCnt/10.0);
		      }
		      
		      if(endNum * 10 < replyCnt){
		        next = true;
		      }
		      
		      var str = "<ul class='pagination pull-right'>";
		      
		      if(prev){
		        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
		      }
		      
		      for(var i = startNum ; i <= endNum; i++){
		        
		        var active = pageNum == i? "active":"";
		        
		        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		      }
		      
		      if(next){
		        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
		      }
		      
		      str += "</ul></div>";
		      
		      console.log(str);
		      
		      replyPageFooter.html(str);
	    }
		//페이징 처리 끝
	
	
		// 답변 목록 하단의 페이지 번호를 클릭했을 때의 이벤트 처리
		replyPageFooter.on("click","li a", function(e){
		       e.preventDefault();
		       console.log("page click");
		       
		       var targetPageNum = $(this).attr("href");  // 클릭한 페이지 번호
		       console.log("targetPageNum: " + targetPageNum);
		       
		       pageNum = targetPageNum;   // pageNum 변수에 클릭한 페이지 번호를 저장
		       
		       showList(pageNum);  // 클릭한 페이지의 답변 목록을 보여주는 함수를 호출
		   }); 
		
		
	//답변 작성 버튼을 클릭했을 때 모달 창이 나타나는 코드
    var modal = $(".modal");   // 모달 창 선택
    var modalInputReply = modal.find("input[name='reply']"); // 답변 입력 필드 선택
    var modalInputReplyer = modal.find("input[name='replyer']"); // 작성자 입력 필드 선택
    var modalInputReplyDate = modal.find("input[name='replyDate']");  // 작성일 입력 필드 선택
    
    var modalModBtn = $("#modalModBtn");   // 수정 버튼 선택
    var modalRemoveBtn = $("#modalRemoveBtn");   // 삭제 버튼 선택
    var modalRegisterBtn = $("#modalRegisterBtn");   // 등록 버튼 선택
    
    /* $("#modalCloseBtn").on("click", function(e){
    	
    	modal.modal('hide');
    }); */
    
   // 답변 작성 버튼 클릭 시 실행될 코드
    $("#addReplyBtn").on("click", function(e){
      
      modal.find("input").val("");  // 모달 내의 입력 필드 초기화
      modalInputReplyDate.closest("div").hide();   // 답변 작성일 숨김
      modal.find("button[id !='modalCloseBtn']").hide();  // 모달 내의 버튼 숨김
      
      modalRegisterBtn.show();  // 등록 버튼 표시
      
      $(".modal").modal("show");  // 모달 창 표시
      
    }); // end addReplyBtn
    
    //답변등록
    modalRegisterBtn.on("click",function(e){
        
        var reply = {
              reply: modalInputReply.val(),//답변내용
              replyer:modalInputReplyer.val(),//작성자
              id:idValue //게시글번호
            };
        replyService.add(reply, function(result){
          
          alert(result);
          
          modal.find("input").val("");
          modal.modal("hide");
         
          //showList(1);         
          showList(-1);         
          
        });
        
    }); //modalRegisterBtn 
    
    // 답변 조회 클릭 이벤트 처리, chat 클래스에 속한 li 요소가 클릭되었을 때 실행되는 함수
    $(".chat").on("click", "li", function(e){
   	      
     var rno = $(this).data("rno");   // 답변의 번호(rno)를 추출
   	      
    // 답변 조회 요청, replyService.get() 함수를 호출하여 해당 답변의 정보를 서버로 가져옴
    replyService.get(rno, function(reply){
   	         // 답변 정보 표시
   	        modalInputReply.val(reply.reply);  // 답변내용
   	        modalInputReplyer.val(reply.replyer); // 작성자
   	        modalInputReplyDate.val(replyService.displayTime( reply.replyDate))  // 작성일
   	        .attr("readonly","readonly");
   	        modal.data("rno", reply.rno); // 모달에 현재 조회된 답변의 번호(rno)를 저장
   	        
   	        modal.find("button[id !='modalCloseBtn']").hide();  // 다른 버튼들은 숨김
   	        modalModBtn.show();  // 조회된 답변은 수정과 삭제가 가능하므로 
   	        modalRemoveBtn.show();  // 수정과 삭제 버튼을 표시
   	        
   	        $(".modal").modal("show");
   	            
   	      });
    });
    
  //답변 내용 수정
    modalModBtn.on("click", function(e){
        
        var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
        
        replyService.update(reply, function(result){
              
          alert(result);
          modal.modal("hide");
          showList(pageNum); //현재 페이지의 답변 목록 다시 로드
          
        });
        
  }); //end modalModBtn
  
  
  //삭제	
  modalRemoveBtn.on("click", function (e){
	  
  	  var rno = modal.data("rno");
  	  
  	  replyService.remove(rno, function(result){
  	        
  	      alert(result);
  	      modal.modal("hide");
  	      showList(pageNum); //현재 페이지의 답변 목록 다시 로드
  	      
  	  });
  	  
  }); //end modalRemoveBtn
  
//Close 버튼을 클릭했을 때 이벤트 처리
  $('#modalCloseBtn').on('click', function() {      
      $('#myModal').modal('hide');
   });
	
	    
});
</script>

<script>
	/* var idValue = ${board.id};
	console.log("idValue");
	console.log("id: "+ idValue); */
	
	/* replyService.add(
			{reply:"js test", replyer:"tester", id:idValue},
			function(result){
				alert("Result : " + result);
			}
	); */
	
	/* replyService.getList({id:idValue, page:1}, function(list){
	    for(var i=0; i<list.length; i++){
	        console.log(list[i]);
	    }
	}); */
	
	 //답변번호 확인하고 지우기
	/* replyService.remove(62, function(result){
	    console.log("Result : " + result);
	    if(result === "success") {
	        alert("REMOVED");
	    }
	}); */
	
	//답변 수정할 번호 확인하고 수정하기
	/* replyService.update({rno:64, id:idValue, reply:"수정하고있음8282"}, function(result){
	   alert("수정완료");
	}); */
	
	// 답변 가져올 번호 확인
	/* replyService.get(64, function(data){
		console.log(data);
	}); */
	
</script>

<script type="text/javascript">
  $(document).ready(function() {
    var operForm = $("#operForm");

    $("button[data-oper='modify']").on("click", function(e) {
      operForm.attr("action", "/board/modify").submit();
    });

    $("button[data-oper='list']").on("click", function(e) {
      operForm.find("#id").remove();
      operForm.attr("action", "/board/list");
      operForm.submit();
    });
  });
</script>