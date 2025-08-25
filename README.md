
![babysbreath_detail](https://github.com/user-attachments/assets/9f1b8e1e-73c1-4067-b591-d0db3fb503de)
![Screenshot 2025-08-24 at 17 30 21](https://github.com/user-attachments/assets/9806a0a3-8eec-46a1-be65-47bafa622215)


<h1 align="center">📚 마이리움 팀 프로젝트</h1>
<p align="center">Spring MVC 기반 3인 협작 클론 사이트 프로젝트입니다.</p>
<br/>

## 📌 목차

- [개요](https://github.com/notuna87/myriumTeamproject#-개요)
- [기술 스택](https://github.com/notuna87/myriumTeamproject#-기술-스택)
- [프로젝트 설계](https://github.com/notuna87/myriumTeamproject#-프로젝트-설계)
- [실행 화면](https://github.com/notuna87/myriumTeamproject#-실행-화면)
- [PPT](https://github.com/notuna87/myriumTeamproject#-PPT)
- [개선사항](https://github.com/notuna87/myriumTeamproject#-개선사항)

## 📖 개요
- 프로젝트 목표 : Spring MVC 기반으로 마이리움 클론 사이트를 제작하여, 실제 전자상거래 환경에서 상품 조회, 장바구니, 주문 등의 기능을 구현
- 개발 기간 : 2025.07.16 ~ 2025.08.14

## 🛠️ 기술 스택
- Language : `JAVA(11)`, `JavaScript(1.5)`
- Framework / Library: `JSP(JavaServer Pages)(2.3)`, `JSTL`, `JDBC`,`DBManager`,`EL`,`jQuery`,`Lombok`
- Database : `Oracle 11g XE (11.2.0.2.0)`
- Server : `Apache Tomcat(9.0.70)`
- Tool : `Spring Tool Suite 3`
- API : `Daum postCode API`
- ETC : `Git`, `google Sheets`, `draw.io`, `erdCloud`, `sourcetree`

## 🧩 프로젝트 설계

<details><summary><h3 align="center">Usecase Diagram</h3></summary>
<img width="1128" height="790" alt="481296084-728d4a85-0932-4a82-9524-97cdfa095230" src="https://github.com/user-attachments/assets/716f55e6-3f78-49a4-a3d9-e2c08a8ed390" />
</details>

<details><summary><h3 align="center">ERD</h3></summary>
<img width="2733" height="1886" alt="Myrium erd" src="https://github.com/user-attachments/assets/888cae06-4c6a-4435-bd6c-eeda52ab09a2" />
</details>
  
<details><summary><h3 align="center">Class Diagram</h3></summary>
<h4>UploadController</h4>
<img width="2200" height="1347" alt="Diagram_UploadController" src="https://github.com/user-attachments/assets/95f413e3-6508-44ee-bc83-0cdf7372487c" />
<h4>TotalReviewController<h4>
<img width="1271" height="724" alt="Diagram_TotalReviewController" src="https://github.com/user-attachments/assets/dbb13257-40bb-40d2-9867-9bc67c14041d" />
<h4>SubController</h4>
<img width="2234" height="1259" alt="Diagram_SubController" src="https://github.com/user-attachments/assets/63e078eb-4fbd-488d-b62b-bbbadb3b3a0e" />
<h4>SearchController</h4>
<img width="1602" height="1185" alt="Diagram_SearchController" src="https://github.com/user-attachments/assets/c6a32127-e257-4edb-be40-6096fcae2cc1" />
<h4>ReviewController</h4>
<img width="2082" height="2085" alt="Diagram_ReviewController" src="https://github.com/user-attachments/assets/72f3a7c4-f4ed-4ef5-9ad1-434e8f8edfd0" />
<h4>ReplyController</h4>
<img width="1509" height="916" alt="Diagram_ReplyController" src="https://github.com/user-attachments/assets/4785b72d-5ece-4531-8113-1b72af856008" />
<h4>PurchaseController</h4>
<img width="2314" height="2085" alt="Diagram_PurchaseController" src="https://github.com/user-attachments/assets/b667aba8-2544-4419-beee-f87191dc0e91" />
<h4>OrderdetailController</h4>
<img width="1209" height="1138" alt="Diagram_OrderdetailController" src="https://github.com/user-attachments/assets/23629644-65fd-427a-ba63-0d745d10b7f2" />
<h4>MypageController</h4>
<img width="1170" height="1208" alt="Diagram_MypageController" src="https://github.com/user-attachments/assets/b71c2c5b-5a30-4c6f-8943-7c2189cd4a99" />
<h4>MemberupdateController</h4>
<img width="1475" height="1119" alt="Diagram_MemberupdateController" src="https://github.com/user-attachments/assets/c41d3ba2-3da9-4512-ba2e-96fe92999f52" />
<h4>MemberRestController</h4>
<img width="1281" height="1069" alt="Diagram_MemberRestController" src="https://github.com/user-attachments/assets/6e85674c-c6fa-415b-b4f8-c66b8209d104" />
<h4>MemberController</h4>
<img width="1932" height="747" alt="Diagram_MemberController" src="https://github.com/user-attachments/assets/a7885bfd-8a0a-465d-850c-6c44a521e04e" />
<h4>JoinController</h4>
<img width="1410" height="851" alt="Diagram_JoinController" src="https://github.com/user-attachments/assets/354d0199-7771-4a95-b8bb-a7cfa15d1484" />
<h4>HomeController</h4>
<img width="1614" height="1330" alt="Diagram_HomeController" src="https://github.com/user-attachments/assets/537ff07b-6190-41de-a97a-6acec7f8c7c4" />
<h4>FindpwController</h4>
<img width="1380" height="927" alt="Diagram_FindpwController" src="https://github.com/user-attachments/assets/2c90fa72-2c4b-4850-a593-5b173c09bc97" />
<h4>FindidController</h4>
<img width="1463" height="1016" alt="Diagram_FindidController" src="https://github.com/user-attachments/assets/d10db07d-b6d8-445e-9751-ff04e4a69b23" />
<h4>EtcController</h4>
<img width="1156" height="576" alt="Diagram_EtcController" src="https://github.com/user-attachments/assets/0b5ba722-2752-456a-a183-6dac795fd5c6" />
<h4>CategoryPageController</h4>
<img width="1675" height="1191" alt="Diagram_CategoryPageController" src="https://github.com/user-attachments/assets/6e3c099b-3f25-4cdb-a017-7d8247bb85a2" />
<h4>CartController</h4>
<img width="1958" height="1352" alt="Diagram_CartController" src="https://github.com/user-attachments/assets/c6afbfb7-04d0-406c-a0e5-74f9bca70d57" />
<h4>AdminReviewController</h4>
<img width="1356" height="978" alt="Diagram_AdminReviewController" src="https://github.com/user-attachments/assets/e189804b-4f76-479c-8d75-3074f949c0c0" />
<h4>AdminProductController</h4>
<img width="1954" height="1348" alt="Diagram_AdminProductController" src="https://github.com/user-attachments/assets/c0eecd98-7b29-40da-9d70-9a2d2638dfb5" />
<h4>AdminOrderController</h4>
<img width="1367" height="951" alt="Diagram_AdminOrderController" src="https://github.com/user-attachments/assets/9d46a3aa-d5d5-47a7-b880-102180798df2" />
<h4>AdminNoticeController</h4>
<img width="1642" height="904" alt="Diagram_AdminNoticeController" src="https://github.com/user-attachments/assets/7f82b528-73ea-4612-afb5-d38c51c161df" />
<h4>AdminMemberController</h4>
<img width="1656" height="991" alt="Diagram_AdminMemberController" src="https://github.com/user-attachments/assets/ed83d685-bea2-42ce-b190-471321abd429" />
<h4>AdminFaqController</h4>
<img width="809" height="567" alt="Diagram_AdminFaqController" src="https://github.com/user-attachments/assets/c1c378c6-3086-4147-ab8e-f430d6b41a65" />
<h4>AdminBoardController</h4>
<img width="2361" height="1100" alt="Diagram_AdminBoardController" src="https://github.com/user-attachments/assets/7edb5e8d-b6d8-443f-9a1f-3b4263d580ee" />
</details>



## 🖥️ 실행 화면

<details>
  <summary><h3 align="center">메인</h3></summary>
  
  * **메인**    
    * **1. 메인**
      * 관리자가 정한 상품들을 메인화면에 선택하여 전시가 가능합니다.
      * 타임세일의 경우 슬라이더로 표시되며, 다른 전시화면에서 타임세일 여부를 표시해줍니다.
      * `상품더보기` 버튼을 클릭할시 상단 전시는 3개씩, 하단 전시는 4개씩 상품이 더 표시되며, 모두 표시되었을 경우 버튼이 사라집니다.
<p align="center"><img src="https://github.com/user-attachments/assets/4c16c37a-8589-4adb-9d23-31de15f801d2"></p>
</details>

<details>
  <summary><h3 align="center">상품 상세</h3></summary>
  
  * **상품 상세**
    * **2-1. 상품 이미지**
      * 작은 슬라이더를 통하여 원하는 이미지를 찾고 선택할 수 있습니다.
      * 선택된 이미지는 큰 슬라이더에 표시됩니다.
      * 큰 슬라이더의 화살표 버튼으로 1장씩 넘기며 볼 수 있습니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/c23e93c7-6356-4a02-bc3e-190ff8820d33"></p>
    * **2-2. 수량조절, 장바구니, 구매하기 버튼**
      * `-버튼` 과 `+버튼`을 클릭하여 수량을 조절할 수 있습니다.
      * 수량을 조절할때 자동으로 가격이 계산되어 총 금액에 반영됩니다.
      * 재고 이상의 상품을 구매하려 할 시 재고부족 알람창이 출력됩니다.
      * `장바구니`버튼을 클릭시 선택한 수량만큼 장바구니에 등록됩니다.
      * 재고를 초과하여 장바구니에 등록할 경우, 재고수로 초기화 시켜 재고수를 초과하지 않게 됩니다.
      * `구매하기`버튼을 클릭시 선택한 수량만 즉시 구매가 가능하며, 장바구니에 담긴 상품은 포함되지 않습니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/b00c1890-877c-4518-8a7e-8bf869e54324"></p>
    * **2-3. 인기가 많은 상품**
      * 판매량으로 정렬하여 상위 10개의 상품만 하단 슬라이더로 표시됩니다.
      * 마우스 드래그를 통하여 좌우 슬라이드가 가능합니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/41c3effd-1d79-4b62-911f-dcbcee4ddf51"></p>
    * **2-4. 결제,배송,교환/반품 안내**
      * 리뷰 리스트를 표시해줍니다.
      * 페이징 기능을 통하여 1페이지당 3개의 리뷰를 화면에 보여줍니다.
      * `전체보기`버튼을 클릭 시 모든 리뷰 페이지로 이동, `작성하기`클릭 시 마이페이지로 이동하게 됩니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/92b123f6-9ab7-4e6e-b4ff-5a9ff5eb962c"></p>
    * **2-5. 리뷰 리스트**
      * 리뷰 리스트를 표시해줍니다.
      * 페이징 기능을 통하여 1페이지당 3개의 리뷰를 화면에 보여줍니다.
      * `전체보기`버튼을 클릭 시 모든 리뷰 페이지로 이동, `작성하기`클릭 시 마이페이지로 이동하게 됩니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/22e96523-0385-46f0-9e6c-9fb8e928faeb"></p>
    * **2-6. 문의 리스트**
      * 문의하기 리스트를 표시해줍니다.
      * `답변여부`를 통하여 한눈에 `답변대기`, `답변완료` 상태를 확인할 수 있습니다.
      * 게시글 제목을 클릭하여 해당 문의글을 조회할 수 있습니다.
      * `전체보기`버튼을 클릭 시 사이트 전체의 문의글을 확인할 수 있습니다.
      * `문의작성하기`버튼을 클릭하여 해당 상품에 관한 문의글을 작성할 수 있습니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/c160f196-48c3-46f0-9af1-5d750ea2b53a"></p>
</details>

<details>
  <summary><h3 align="center">장바구니</h3></summary>

  * **장바구니**
    * **3. 장바구니**
      * 상품에서 `장바구니` 버튼을 통하여 장바구니에 상품을 담을 수 있습니다.
      * 원하는 상품만 선택하여 구매가 가능합니다.
      * 선택한 상품을 갯수에 따라 자동으로 계산하여 총 결제금액을 보여줍니다.
      * 상품의 총 금액이 `49,900원`을 초과하지 않는 경우 배송비 `3,000원`이 자동으로 추가됩니다.
      * `삭제하기`버튼을 클릭하여 장바구니에서 상품을 삭제할 수 있습니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/5c0537e3-869a-490b-8a46-e8379664a69a"></p>
</details>

<details>
  <summary><h3 align="center">결제하기</h3></summary>

  * **결제하기**
    * **4.1 주문서 작성**
      * `장바구니`페이지의 `주문하기`와 `상품`페이지의 `구매하기`버튼을 통하여 주문서 작성이 가능합니다.
      * 회원 정보를 불러와 주문자를 확인합니다.
      * `다음 주소 api`를 통하여 주소를 자동으로 입력할 수 있습니다.
      * 핸드폰번호및 배송요청사항을 선택할 수 있습니다. 배송요청사항의 `직접입력`을 선택할 경우, 요청사항을 직접 입력할 수 있습니다.
      * 주문하려는 상품의 리스트와 가격을 볼 수 있습니다. 상품의 총 가격이 `49,900원`을 넘기지 않을 경우 배송비가 표시됩니다.
      * 리스트의 `삭제하기`버튼을 클릭 시 삭제할 수 있습니다. 삭제될시 장바구니에서도 같이 삭제됩니다.
      * 배송비가 있다면 배송비를 포함한 최종 결제 금액이 표시됩니다.
      * 결제 수단을 선택할 수 있습니다.
      * 제공방침 및 청약철회방침의 자세히 버튼을 클릭 시 팝업버튼을 통하여 약관을 확인할 수 있습니다.
      * 버튼을 통하여 최종결제금액이 한번더 고객에게 안내됩니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/e8691b27-0894-4d36-8352-747e14e26a1e"></p>
      
    * **4.2 결제완료**
      * 날짜와 주문 카운트를 통하여 시퀀스를 통하여 주문번호를 자동으로 생성하여 부여합니다.
      * 최종 결제금액을 한번더 표시해줍니다.
      * 결제수단을 표시합니다.
      * 주문할때 입력한 주소 및 배송요청 사항을 표시해줍니다.
      * 주문한 상품 리스트를 표시해줍니다.
      * 주문한 상품들의 총 금액과 배송비가 있을 경우 배송비를 표시하여, 최종결제금액을 안내해줍니다.
      * `주문확인하기`버튼 클릭 시 마이페이지로 이동합니다.
      * `쇼핑계속하기`버튼 클릭 시 메인으로 이동합니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/3946a130-679a-4a50-8ed1-bb4d9bb1178c"></p>
</details>

<details>
  <summary><h3 align="center">검색</h3></summary>

  * **검색**
    * **5. 검색**
      * 헤더의 검색창을 통하여 원하는 상품을 검색할 수 있습니다.
      * 검색된 결과를 카운트하여 화면에 표시해줍니다.
      * 검색된 결과를 원하는 정렬 기준을 선택하여 정렬할 수 있습니다.
      * 오라클 페이징 기능을 이용하여, 한페이지에 8개의 상품을 볼 수 있습니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/c16ee1a6-12e6-456a-955c-051956049368"></p>
</details>

<details>
  <summary><h3 align="center">카테고리</h3></summary>

  * **카테고리**
    * **6. 카테고리**
      * 네비게이션의 `식물키우기`를 클릭하여 카테고리 페이지로 넘어올 수 있습니다.
      * 카테고리를 선택하여 원하는 카테고리 상품을 한눈에 볼 수 있습니다.
      * `상품더보기` 버트을 클릭하여 4개의 상품씩 더 볼 수 있습니다.
      * 카테고리를 선택 후 원하는 정렬기준을 적용하여 상품을 볼 수 있습니다.
      <p align="center"><img src="https://github.com/user-attachments/assets/918e0d74-c41b-43c8-9fe6-03b426cf0c0c"></p>
</details>

## 🗂️ PPT

<details><summary><h3 align="center">PPT 목차 및 개발일정</h3></summary>
<img src="https://github.com/user-attachments/assets/0c7566e0-98d8-444c-b752-87bdd9ff39fe">
<img src="https://github.com/user-attachments/assets/7859a4c9-68b3-499f-8891-12a691d6e666">
<img src="https://github.com/user-attachments/assets/7e75b973-a23a-4271-b7b7-27b3d5e11b3d">
</details>

<details><summary><h3 align="center">PPT 요구사항 분석</h3></summary>
<img src="https://github.com/user-attachments/assets/662b80c2-47f9-4246-82e3-4785ae248eca">
<img src="https://github.com/user-attachments/assets/d63f9016-80c4-4353-953c-869372439fab">
<img src="https://github.com/user-attachments/assets/10fe6205-4dea-43a6-8267-0773a6b78687">
<img src="https://github.com/user-attachments/assets/4b550a94-e6c8-42bd-89b8-a2aa0aec6865">
<img src="https://github.com/user-attachments/assets/26d592eb-c459-44ec-989e-9e3e853ee818">
<img src="https://github.com/user-attachments/assets/7b2a5041-284e-4413-af0c-e8160769cb9b">
<img src="https://github.com/user-attachments/assets/ee02d855-414f-4a90-95d4-3ebab1f0670d">
<img src="https://github.com/user-attachments/assets/e69b80f6-e56d-4c33-aa74-0971f372ba90">
<img src="https://github.com/user-attachments/assets/86f04487-3f84-4fe0-a643-b11081c78be0">
<img src="https://github.com/user-attachments/assets/386848c0-bd38-4cf3-b585-e3f972262e6d">
<img src="https://github.com/user-attachments/assets/b0f48cac-3515-49f6-8573-af06321d99c2">
<img src="https://github.com/user-attachments/assets/5665bc16-1651-4533-8e5d-786aa75bd3fb">
<img src="https://github.com/user-attachments/assets/b7d9f29b-f1d8-47c8-988b-b603eac2be13">
<img src="https://github.com/user-attachments/assets/075d654c-c7d7-4576-bfdf-168da1681f14">
<img src="https://github.com/user-attachments/assets/223e9762-6d91-4dd4-b3f4-b2a0aa1643dc">
<img src="https://github.com/user-attachments/assets/b36a7520-4b27-42e5-9127-ff3567eb5a45">
<img src="https://github.com/user-attachments/assets/0c4c3ea0-da8c-4762-ac04-3a686d0253fe">
<img src="https://github.com/user-attachments/assets/27a24dab-6803-47d7-b810-51e90f14bdee">
<img src="https://github.com/user-attachments/assets/5054a679-b042-418c-a2ab-063a4383dadb">
<img src="https://github.com/user-attachments/assets/e0f7e333-0629-463c-b097-87db244a576d">
<img src="https://github.com/user-attachments/assets/ec173492-d802-4488-8b60-39114c158317">
<img src="https://github.com/user-attachments/assets/c9a5368b-8a14-4bd9-bcc9-0543237dcb07">
<img src="https://github.com/user-attachments/assets/6fb18fcd-0989-418e-be42-5b94b02897d5">
<img src="https://github.com/user-attachments/assets/33aa5291-3db7-4cf8-9ee6-92352f864bb5">
<img src="https://github.com/user-attachments/assets/0c759390-41c3-47fc-8488-b8656e6b3270">
<img src="https://github.com/user-attachments/assets/d435e2b3-0c1d-4b60-8ef9-53d15b74c54a">
<img src="https://github.com/user-attachments/assets/0f235dde-6de9-4a0b-8efc-98138151e85c">
<img src="https://github.com/user-attachments/assets/8019b3cf-53f7-4628-aeef-16aa1bfb4b7f">
<img src="https://github.com/user-attachments/assets/33e58a6a-736c-424d-b8cd-8032f4cd2429">
<img src="https://github.com/user-attachments/assets/9a0d4348-0cf1-41da-a03a-29fdc56ac898">
<img src="https://github.com/user-attachments/assets/1851f43d-8f91-49d0-87ae-316105dcb464">
<img src="https://github.com/user-attachments/assets/242f2bcf-a4c8-4a1e-860c-36be2e02e01c">
<img src="https://github.com/user-attachments/assets/e6314844-866f-444a-ad56-ddf4a2f8232e">
<img src="https://github.com/user-attachments/assets/48d3b608-e56f-4b74-825d-d8f6f776106a">
<img src="https://github.com/user-attachments/assets/c93cb956-73bc-45cf-8668-ca352dd6474a">
<img src="https://github.com/user-attachments/assets/40e72a5f-b334-48fc-b273-624ced3f9f23">
<img src="https://github.com/user-attachments/assets/3d3db4f2-e89a-427d-9d31-3a6fd711dfe1">
<img src="https://github.com/user-attachments/assets/df4727ba-a4f9-4387-80c7-bd6a146428bb">
<img src="https://github.com/user-attachments/assets/97cd308e-3210-4687-849c-9d4b7b0e7a6f">
</details>


<details><summary><h3 align="center">시연 PPT</h3></summary>
<img src="https://github.com/user-attachments/assets/a8791688-42c5-4d8c-9188-751dddfc5b99">
<img src="https://github.com/user-attachments/assets/2942bd7e-acfb-461e-b35d-87e741c42b2f">
<img src="https://github.com/user-attachments/assets/4271ad11-53c4-43ed-b53e-71ef8bade458">
<img src="https://github.com/user-attachments/assets/0d0a0782-e281-4e16-8c11-21898f83051c">
<img src="https://github.com/user-attachments/assets/6bbbcb54-6717-443a-a1f6-26455b70e183">
<img src="https://github.com/user-attachments/assets/ac79e2ce-46c1-44e2-b738-38b6985a3ff9">
<img src="https://github.com/user-attachments/assets/3ec7ed7d-75ad-4c87-a7a1-c708728e3097">
<img src="https://github.com/user-attachments/assets/2dd58000-0091-4b42-ad8a-1720d6ebb798">
<img src="https://github.com/user-attachments/assets/28842885-8775-443d-a9b2-765a36def45a">
<img src="https://github.com/user-attachments/assets/24dbbe3d-a9aa-47c7-aa54-1f1fa581be94">
<img src="https://github.com/user-attachments/assets/22905df1-a5cf-4eb9-a279-8d83b76f53f6">
<img src="https://github.com/user-attachments/assets/9b60f928-04a0-4b94-b2d3-e7ad75e79222">
<img src="https://github.com/user-attachments/assets/d3660a00-eb41-4565-9655-a6394c422ae6">
<img src="https://github.com/user-attachments/assets/e98537eb-de24-4abe-ab68-99abbe16fc52">
</details>

## 🚀 개선사항 및 개선점
</br>

  * **1. 타임세일 기능 미구현**
    * 아쉬운점 : 특정 시간에 상품이 자동 종료되는 기능을 구현하지 못함
    * 개선점 : 스케쥴러를 활용하여 자동화 기능을 추가할 예정
  * **2. VO와 DTO 정리 미흡**
    * 아쉬운점 : VO와 DTO의 역할이 명확하지 않아 코드 구조가 혼란스러움
    * 개선점 : DTO는 데이터 전달, VO는 값 표현 객체로 일관성 있도록 조정
  * **3. 예외처리 부족**
    * 아쉬운점 : 오류 발생 시 사용자 친화적인 안내 부족
    * 개선점 : 공통 에러 페이지 및 예외 처리 로직 강화
  * **4. 테스트 코드 부족**
    * 아쉬운점 : 기능별 단위 테스트 및 통합 테스트가 충분하지 않음
    * 개선점 : JUnit, Mockito 등을 활용하여 테스트 코드 보강
  * **5. 공통 모듈화 부족**
    * 아쉬운점 : 일부 코드가 중복되어 유지 보수성이 떨어짐
    * 개선점 : 공통 모듈 및 유틸 클래스로 중복 제거
  * **6. 쿠폰 시스템 미구현**
    * 아쉬운점 : 할인 및 프로모션 기능이 제공되지 않음
    * 개선점 : 쿠폰 발급 및 적용 로직 추가 예정
  * **7. 결제 API 미적용**
    * 아쉬운점 : 시간 부족으로 인하여 외부 결제 서비스와의 연동이 이루어지지 않음
    * 개선점 : 결제 API 연동 예정
