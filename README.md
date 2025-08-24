
![babysbreath_detail](https://github.com/user-attachments/assets/9f1b8e1e-73c1-4067-b591-d0db3fb503de)
![Screenshot 2025-08-24 at 17 30 21](https://github.com/user-attachments/assets/9806a0a3-8eec-46a1-be65-47bafa622215)

<h1 align="center">📚 마이리움 팀 프로젝트</h1>
<p align="center">Spring MVC 기반 3인 협작 클론 사이트 프로젝트입니다.</p>
<br/>

<details><summary>아코디언 예시입니다.</summary>
  예시 입니까?

  진짜 예시입니다.
</details>

## 📌 목차

- [개요](https://github.com/notuna87/noh_aladinJSP#-개요)
- [기술 스택](https://github.com/notuna87/noh_aladinJSP#-기술-스택)
- [프로젝트 설계](https://github.com/notuna87/noh_aladinJSP#-프로젝트-설계)
- [실행 화면](https://github.com/notuna87/noh_aladinJSP#-실행-화면)
- [PPT](https://github.com/notuna87/noh_aladinJSP#-PPT)
- [개선사항](https://github.com/notuna87/noh_aladinJSP#-개선사항)

## 📖 개요
- 프로젝트 목표 : 
- 개발 기간 :

## 🛠️ 기술 스택
- Language : `JAVA(11)`, `JavaScript(1.5)`
- Framework / Library: `JSP(JavaServer Pages)(2.3)`, `Servlet(4.0)`, `JSTL`, `JDBC`,`DBManager`,`EL`,`jQuery`
- Database : `Mysql(8.0)`
- Server : `Apache Tomcat(9.0.70)`
- Tool : `Eclipse IDE (4.29.0)`
- API : `Kakao Book Search API`
- ETC : `Git`

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
![Adobe Express - Adobe Express - main_display (1)](https://github.com/user-attachments/assets/fed60335-48fb-4ce0-b04f-a676db6afeec)

<h3>상품 상세</h3>
![Adobe Express - Adobe Express - main_sub](https://github.com/user-attachments/assets/cf4e3c02-8117-4f06-808b-221e25a58f56)

## 🗂️ PPT ---- ppt 사진 넣을곳

</br>

## 🚀 개선사항
</br>

