
# 개요 
2021년도 2학기 '바텐더'팀의 캡스톤 디자인 입니다.

# 팀
- 팀명 : 바텐더
- 팀원 및 역할
   - 임상은 : DB 테이블 구성 및 데이터 총괄
   - 송정현 : 프론트엔드, 백엔드 작업 및 추후 유지보수
   - 이무환 : DB수집 및 자료조사
   - 유재혁 : DB수집 및 자료조사
# 주제
- 프로젝트명 : 칵테일 추천 시스템 (For Hometender) ==> 칵테일 웹 사이트 

# 사용한 프로그램 / 오픈소스
- spring boot, Eclipse
- MySql, mybatis
- AWS EC2, Filezilla, AWS ELB
- putty, tomcat8
![KakaoTalk_20211202_214340291](https://user-images.githubusercontent.com/63418624/144466664-20c4bb6a-2c31-4fbe-82f6-a29d6d4e5bb0.png)

# 주요 기능
- 회원 가입 및 로그인
- 메인홈 탭
- 마이페이지 탭
- 게시판 탭
- 칵테일 탭

# 회의록
- [2021.09.09](회의록/회의록_20210909.hwp)
- [2021.09.13](회의록/회의록_20210913.hwp)
- [2021.09.29](회의록/회의록_20210929.hwp)
- [2021.10.01](회의록/회의록_20211001.hwp)
- [2021.10.07](회의록/회의록_20211007.hwp)
- [2021.10.26](회의록/회의록_20211026.hwp)
- [2021.11.04](회의록/회의록_20211104.hwp)
- [2021.11.17](회의록/회의록_20211117.hwp)
- [2021.11.24](회의록/회의록_20211124.hwp)
- [2021.11.27](회의록/회의록_20211127.hwp)

# 추후 사용할 AWS 관련 특강 참여
- 2021.09.28-09.29 AWS EC2 관리 특강 19:00~21:00 
- 팀원 임상은, 송정현 참여

# 수행 결과
- 웹 사이트1(http://54.180.30.151:8080/index)
- 웹 사이트2(http://bartender-991835918.ap-northeast-2.elb.amazonaws.com/index) 
- AWS EC2를 이용해서 서버를 운용
- AWS ELB를 이용하여 로드밸런싱

# 구체적인 수행 내용
- 테이블 구성 및 ERD (https://www.erdcloud.com/d/H8ZPgzzvSk6SM5uD2)
![ERD1](https://user-images.githubusercontent.com/63418624/144480342-4dd0da76-09e1-465c-8513-ff952c065763.PNG)
![ERD2](https://user-images.githubusercontent.com/63418624/144480379-b4f936e0-eae2-446c-b4dc-af31953a09b5.PNG)
![ERD3](https://user-images.githubusercontent.com/63418624/144480388-d4eeba62-2fef-4767-9732-5528032b5ca2.PNG)

- 로그인 및 회원가입
![로그인](https://user-images.githubusercontent.com/63418624/144480439-a6d689ca-eaee-401c-9b15-3a90ba244a8e.PNG)
![회원가입](https://user-images.githubusercontent.com/63418624/144480449-d45f4a5c-fd28-4361-8ea3-337d210e2228.PNG)

- 회원정보 수정
![로그인 후](https://user-images.githubusercontent.com/63418624/144480478-194c4b5c-bed0-4821-8621-5dfc9cd7beca.PNG)
![회원 정보 수정](https://user-images.githubusercontent.com/63418624/144480459-0c989d97-19d9-48a8-ab38-7536ae58d93f.PNG)

- 홈페이지 메인창 및 데일리 추천
![메인창](https://user-images.githubusercontent.com/63418624/144480583-d93be55d-0cae-4be2-8b26-f7f3ff0b08af.PNG)

- 게시판 메인
- 게시판 검색 기능
- 게시글 첨부파일 추가 기능
- 게시글 댓글 기능
- 칵테일 검색 기능
- 냉장고 재료 추가 및 삭제 기능
- 가지고 있는 재료로 만들 수 있는 칵테일 표시
- 칵테일 즐겨찾기(홈,칵테일탭, 마이페이지 등 칵테일 그림이 있는 모든 페이지에서 추가가능)
- 마이페이지에서 내가 쓴 글 목록 보기 
- 레시피 클릭 시 제조법 및 없는 재료 표시
- 칵테일 추천 알고리즘 단면도
- 전체 칵테일 레시피 목록 및 기주 별 목록
- 초성 검색 기능
# 개선점
- 비밀번호 찾기 기능
- 결제 시스템(멤버십 기능 활성화를 위해)
