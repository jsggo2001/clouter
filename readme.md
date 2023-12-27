# CLOUT
<img src="/readme/Clout_Logo.png" width="500px"/>



## 📖목차
- [README](#readme)
	- [🗓프로젝트 진행 기간](#-프로젝트-진행-기간)
	- [📑주제](#-주제)
	- [🎉프로젝트 기획](#-프로젝트-기획)
	- [🔑 주요 기능](#-주요-기능)
	- [🖥 서비스 화면](#-서비스-화면)
	- [🏗️ 아키텍쳐](#-아키텍쳐)
	- [🛠 기술 스택](#-기술-스택)
	- [📝 설계 문서](#-설계-문서)
	    - [ERD](#erd)
	    - [API](#api)
        - [FIGMA](#FIGMA)
	- [💻 구동 방법](#-구동-방법)
	- [💾 결과물](#-결과물)
	    - [UCC](#UCC)
	- [❤ 팀원 소개](#-팀원-소개)
		- [프론트](#프론트)
		- [백](#백)
<!-- <small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small> -->


---
## 🗓 프로젝트 진행 기간
`2023.10.09 ~ 2023.11.17 (약 6주)`

---
## 📑 주제
#### CLOUT; 영향력, 힘
광고주와 인플루언서를 이어주는 마케팅 매칭 서비스 앱

---
## 🎉 프로젝트 기획
* 최근 들어 SNS 사용의 급격한 증가에 따라 SNS 인플루언서들을 통한 광고의 효과가 부각되고 있음
* 메가 인플루언서들의 경우 손쉽게 광고주와 접할 수 있는 기회가 많은 반면, 광고 효과를 적잖게 제공할 수 있지만 광고주들에게 많이 알려져있지 않는 인플루언서들의 경우 광고를 하고 싶어도 광고주와 접촉이 이루어지지 않아 수익 창출에 어려움을 겪고 있음
* 광고주들 입장에서도 메가 인플루언서들에게 광고를 의뢰하기엔 광고비가 부담스러워 적절한 광고비를 제공하는 인플루언서와 접촉하고 싶지만, 현재 그런 서비스가 시장에 많이 부족함
* 따라서, 인플루언서와 광고주들을 서로 이어주는 서비스를 개발하면 어떨까 하는 생각에서 기획

---
## 🔑 주요 기능
1. 광고주와 인플루언서가 보는 화면이 다르게 표시
2. 인플루언서는 개인의 프로필을 올리고 태그를 설정해 광고주들에게 스스로를 노출 가능
3. 광고주는 적절한 가격과 태그를 설정해 적절한 인플루언서를 원하는 예산 내에서 선정 가능
4. 중간 계약서를 제공해 마케터와 광고주 사이의 불협화음 최소화
5. 채팅 기능을 이용해 추가적인 사항에 대해 상의 가능
6. 중개 수수료를 정도 저렴하게 설정해 광고주와 마케터 부담 절감
7. 인플루언서 sns 인증을 통해 광고주의 신뢰성 확보
8. 약관을 제공하여 편리한 광고 환경 제공


---
## 🖥 서비스 화면

<details>
<summary>메인 페이지</summary>
<div markdown="1">       
    <img src="/readme/1.png" alt="랜딩"/>
    <img src="/readme/2.png" alt="랜딩"/>
</div>
</details>

<details>
<summary>목록</summary>
<div markdown="1">       
    <img src="/readme/3.png" alt="목록"/>
    <img src="/readme/4.png" alt="목록"/>
</div>
</details>

<details>
<summary>캠페인</summary>
<div markdown="1">       
    <img src="/readme/5-1.png" alt="캠페인"/>
</div>
</details>


<details>
<summary>마이페이지</summary>
<div markdown="1">       
    <img src="/readme/6.png" alt="마이페이지"/>
    <img src="/readme/7-1.png" alt="마이페이지"/>
    <img src="/readme/7-2.png" alt="마이페이지"/>
    <img src="/readme/11.png" alt="마이페이지"/>
</div>
</details>

<details>
<summary>계약</summary>
<div markdown="1">       
    <img src="/readme/8.png" alt="계약"/>
    <img src="/readme/9.png" alt="계약"/>
    <img src="/readme/10.png" alt="계약"/>
</div>
</details>


---
## 🏗️ 아키텍쳐

<img src="/readme/arch.png" alt="아키텍쳐"/>

---
## 🛠 기술 스택
### 백엔드

**Language |** java 11, java 17

**Framework |** Spring Boot 2.7, Spring Boot 3.1

**Build Tool |** gradle 8.2.1

**Database |** mariaDB 10.11.0, mongoDB7.0.2, redis 7.2.3 


<br></br>
### 프론트엔드

**Language |** Dart  3.1.3

**Framework |** flutter 3.13.7 
    
<details>
<summary>Library </summary>
<div markdown="1">       
  numberpicker: ^2.1.2
  cupertino_icons: ^1.0.2
  google_fonts: ^6.1.0
  percent_indicator: ^4.0.1
  intl: ^0.18.1
  syncfusion_flutter_sliders: ^23.1.42
  syncfusion_flutter_core: ^23.1.42
  flutter_launcher_icons: ^0.13.1
  syncfusion_flutter_datepicker: ^23.1.43
  dropdown_button2: ^2.3.9
  multi_select_flutter: ^4.1.3
  animated_toggle_switch: ^0.8.0
  image_picker: ^1.0.4
  multiple_images_picker: ^1.0.1
  permission_handler: ^11.0.1
  multi_image_picker: ^4.8.01
  flutter_riverpod: ^2.4.4
  fluttertoast: ^8.2.2
  signature: ^5.4.0
  syncfusion_flutter_signaturepad: ^23.1.42
  image_gallery_saver: ^2.0.3
  change_app_package_name: ^1.1.0
  url_launcher: ^6.2.1
  carousel_slider: ^4.2.1
  flutter_inset_box_shadow: ^1.0.8
  flutter_animate: ^4.2.0+1
  stomp_dart_client: ^1.0.0
  web_socket_channel: ^2.4.0
  daum_postcode_search: ^0.0.2
  flutter_inappwebview: ^5.7.2+3
  infinite_scroll_pagination: ^4.0.0
  currency_text_input_formatter: ^2.1.10
  brasil_fields: ^1.14.0
  firebase_core: ^2.21.0
  firebase_messaging: ^14.7.3
  flutter_local_notifications: ^16.1.0
  syncfusion_flutter_pdf: ^23.1.43
  open_file: ^3.3.2
  flutter_staggered_grid_view: ^0.7.0
  loading_indicator: ^3.1.1
  flutter_dotenv: ^5.1.0
  http: ^1.1.0
  pinput: ^3.0.1
  format: ^1.4.0
  flutter_animated_icons: ^1.0.1
  http_status_code: ^0.0.2
  shared_preferences: ^2.2.2
  dio: ^5.3.3
  http_parser: ^4.0.2
  flutter_cache_manager: ^3.3.1
  path_provider: ^2.1.1
  device_info: ^2.0.0
</div>
</details>

<br></br>
### 인프라

**Infra |** docker 24.0.7, docker-compose 2.21.0, nginx 1.18.0 (Ubuntu), Apache kafka 3.5.1

**CI/CD |** jenkins 2.414.1

**SSL certification |** certbot 0.40.0

</details>

---
## 📝 설계 문서

### ERD
<details>
<summary>ERD</summary>
<div markdown="1">       
    <img src="/readme/erd.png" alt="ERD 페이지"/>
</div>
</details>


### API
<details>
<summary>API 문서</summary>
<div markdown="1">       
    <img src="/readme/api.png" alt="전체 문서 페이지"/>
</div>
</details>


### FIGMA
<details>
<summary>FIGMA</summary>

https://www.figma.com/file/WjO2jnGE6aETJN6TuhmHYj/CLOUT?type=design&node-id=0%3A1&mode=design&t=W1Kq05ieH90WM4hs-1

</details> 

## 💻 구동 방법

1. Clone Project

```
git clone https://lab.ssafy.com/s09-bigdata-recom-sub2/S09P22A305.git
```

2. change path to /front_temp/frontend

```
flutter pub get
```
3. create .env file

```
# .env
CLOUT_APP_BASE_URL='https://clouter.kr'
```
4.frontend start

```
flutter run
```

---
## 💾 결과물
    
### UCC
https://youtu.be/uBcELRAjBkY?si=qOI_ezoIwEhihsSa
