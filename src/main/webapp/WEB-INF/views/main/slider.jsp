<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <title>Slider</title>
  <!-- Swiper CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
  <style>
    .swiperWrap {
      width: 100%;
      height: 100%;
      margin-bottom : -200px;
    }
    .swiper-slide {
      width: 100%;
      height: 100%;
      position: relative;
    }
    .sliderText {
      position: absolute;
      left: 10%;
      top: 50%;
      transform: translateY(-50%);
      width: 50%;
      padding-left: 40px;
    }
    .fontWhite {
      color: white;
    }
  </style>
</head>
<body>

  <div class="swiperWrap">
    <div class="swiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <a href="#">
            <div style="height:100%; width:50%; position:absolute; align-items:center;">
              <div class="sliderText">
                <p>모두 들어있는 간단한 식물키트로 시작!</p>
                <h2>우리 아이와 일상속, <br>즐거운 추억 만들기!</h2>
              </div>
            </div>
            <img src="resources/img/slider/slider_01.png" alt="slider_01">
          </a>
        </div>
        <div class="swiper-slide">
          <a href="#">
            <div style="height:100%; width:50%; position:absolute; align-items:center;">
              <div class="sliderText fontWhite">
                <p>나만의 반려식물 키우기</p>
                <h2>한 알의 씨앗으로<br>내 삶의 작은 변화를,</h2>
              </div>
            </div>
            <img src="resources/img/slider/slider_02.jpg" alt="slider_02">
          </a>
        </div>
        <div class="swiper-slide">
          <a href="#">
            <div style="height:100%; width:50%; position:absolute; align-items:center;">
              <div class="sliderText">
                <p>식물똥손도 식물을 살리는 법</p>
                <h2>분갈이 준비 하셔야죠?<br>마이리움 특별한 슬릿팟</h2>
              </div>
            </div>
            <img src="resources/img/slider/slider_03.png" alt="slider_03">
          </a>
        </div>
        <div class="swiper-slide">
          <a href="#">
            <div style="height:100%; width:50%; position:absolute; align-items:center;">
              <div class="sliderText">
                <p>상추, 고수, 바질, 루꼴라 채소키트</p>
                <h2>재미가득🌱씨앗부터<br>직접 키운 채소로 건강하게!</h2>
              </div>
            </div>
            <img src="resources/img/slider/slider_04.png" alt="slider_04">
          </a>
        </div>
        <div class="swiper-slide">
          <a href="#">
            <div style="height:100%; width:50%; position:absolute; align-items:center;">
              <div class="sliderText">
                <p>원예도 장비빨이니까</p>
                <h2>즐거운 물주기 시간<br>귀여운 물조리개 하나로 특별하게!</h2>
              </div>
            </div>
            <img src="resources/img/slider/slider_05.png" alt="slider_05">
          </a>
        </div>
        <div class="swiper-slide">
          <a href="#">
            <div style="height:100%; width:50%; position:absolute; align-items:center;">
              <div class="sliderText">
                <p>3,000원 쿠폰과 이벤트가 와르르!</p>
                <h2>마이리움과 친구하고<br>다양한 혜택✨받아보기!</h2>
              </div>
            </div>
            <img src="resources/img/slider/slider_06.png" alt="slider_06">
          </a>
        </div>
      </div>

      <!-- Navigation buttons -->
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
    </div>
  </div>

  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
  <script>
    const swiper = new Swiper('.swiper', {
      spaceBetween: 30,
      slidesPerView: 1,
      loop: true,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      autoplay: {
        delay: 4000,
      },
    });
  </script>

</body>
</html>
