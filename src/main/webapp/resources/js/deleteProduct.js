function deleteProduct(action, button) {
	  	const productContainer = button.closest('.cartContentsWrap');
	    const container = button.closest('.cartDelete');
	    const productId = button.getAttribute('data-product-id');
		const meta = document.querySelector('meta[name="_csrf"]');
		const csrfToken = meta ? meta.getAttribute('content') : '';
		
	    // AJAX 요청 보내기 (서버에 수량 업데이트)
	    fetch('/cart/delete', {
	      method: 'POST',
	      headers: {
  			'Content-Type': 'application/json',
  			'X-CSRF-TOKEN': csrfToken
	      },
	      body: JSON.stringify({
	        productId: productId
	      })
	    })
	    .then(response => {
	      if (!response.ok) {
	        throw new Error('서버 오류 발생');
	      }
	      return response.json();
	    })
	    .then(data => {
	      console.log('삭제완료', data);
	      productContainer.remove();
	      updateTotalPrice();
	    })
	    .catch(error => {
	      console.error('삭제 실패:', error);
	      alert('삭제에 실패했습니다.');
	    });
	  }