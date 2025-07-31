<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- Bootstrap JavaScript -->
    <script src="/resources/bsAdmin2/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/bsAdmin2/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/bsAdmin2/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/bsAdmin2/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/bsAdmin2/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/bsAdmin2/resources/dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->

    
    <script>
	  $(document).ready(function() {
	    $('#dataTables-example').DataTable({
	      responsive: true,
	      paging: false,
	      searching: false,
	      order: [[0, 'desc']],
	      info: false
          //language: {
          //    search: "검색:",
          //    lengthMenu: "_MENU_개씩 보기",
          //    info: "_START_ - _END_ / 전체 _TOTAL_건",
          //    emptyTable: "데이터가 없습니다.",
          //    paginate: {
          //        next: "다음",
          //        previous: "이전"
          //    }
          //}
	    });
	    $(".sidebar-nav")
	      .attr("class","sidebar-nav navbar-collapse collapse")
	      .attr("aria-expanded",'false')
	      .attr("style","height:1px");
	  });
	</script>

</body>

</html>