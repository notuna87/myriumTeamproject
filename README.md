
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
<h4>TotalReviewControllerh4>
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
<h3>메인</h3>
<p align="center"><img src="https://github.com/user-attachments/assets/ef5dc2a7-da83-43db-af32-845f733411e0"></p>

<h3>상품 상세</h3>
<p align="center"><img src="https://github.com/user-attachments/assets/ac1a4d1e-e2a7-431b-a43b-da66421e2359"></p>

<h3>장바구니<h3>
<p align="center"><img src="https://github.com/user-attachments/assets/94105129-9a49-4673-b761-221f3155469a"></p>

<h3>결제</h3>
<p align="center"><img src="https://github.com/user-attachments/assets/84571e25-3010-4564-bf73-496e1f1d667c"></p>

<h3>검색</h3>
<p align="center"><img src="https://github.com/user-attachments/assets/3155a1c4-f48b-4515-b347-88c7d252b367"></p>

<h3>카테고리</h3>
<p align="center"><img src="https://github.com/user-attachments/assets/6d30afd5-77c7-4123-a599-f86b09ec75de"></p>

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

<h4>1. 타임세일 기능 미구현</h4>
<p>- 아쉬운점 : 특정 시간에 상품이 자동 종료되는 기능을 구현하지 못함</p>
<p>- 개선점 : 스케쥴러를 활용하여 자동화 기능을 추가할 예정</p>

<h4>2. VO와 DTO를 깔끔하게 정리하지 못하였음</h4>
<p>- 아쉬운점 : VO와 DTO의 역할이 명확하지 않아 코드 구조가 혼란 스러움</p>
<p>- 개선점 : DTO는 데이터 전달, VO는 값 표현 객체로 일관성 있도록 조정</p>

<h4>3. 예외처리 미흡</h4>
<p>- 아쉬운점 : 오류 발생 시 사용자 친화적인 안내 부족</p>
<p>- 개선점 : 공통 에러 페이지 및 예외 처리 로직 강화</p>

<h4>4. 테스트 코드 부족</h4>
<p>- 아쉬운점 : 기능별 단위 테스트 및 통합 테스트가 충분하지 않음</p>
<p>- 개선점 : JUnit, Mockito 등을 활용하여 테스트 코드 보강</p>

<h4>5. 공통 모듈화 부족</h4>
<p>- 아쉬운점 : 일부 코드가 중복되어 유지 보수성이 떨어짐</p>
<p>- 개선점 : 공통 모듈 및 유틸 클래스로 중복 제거</p>

<h4>6. 쿠폰 시스템 미구현</h4>
<p>- 아쉬운점 : 할인 및 프로모션 기능이 제공되지 않음 </p>
<p>- 개선점 : 쿠폰 발급 및 적용 로직 추가 예정</p>

<h4>7. 결제 API 미적용</h4>
<p>- 아쉬운점 : 시간 부족으로 인하여 외부 결제 서비스와의 연동이 이루어지지 않음 </p>
<p>- 개선점 : 결제 API 연동 예정</p>
