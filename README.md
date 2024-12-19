# 🚀 우주로 가는 5조
- 프로젝트 명 : 동네챗
- 프로젝트 목적 : 우리동네 소모임 채팅 어플 
<br/>

## 📅 프로젝트 기간
- 2024.12.11 ~ 2024.12.18
<br/>

## ❓ About Team
- 차부곤(팀장) : 로그인, 홈페이지
- 신혜원(에이스) : 채팅
- 김고은(팀원) : 채팅 리스트
- 김서후(팀원) : 마이페이지, 회원가입
<br/>

## 🛠️ 기술 스택 및 툴
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=black)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)
![Figma](https://img.shields.io/badge/Figma-F24E1E?style=flat&logo=figma&logoColor=white)
![Slack](https://img.shields.io/badge/Slack-4A154B?style=flat&logo=slack&logoColor=white)
<br/>
<br/>

## 🔧 사용 라이브러리 
- flutter_dotenv
- firebase_core
- firebase_storage
- cloud_firestore
- flutter_riverpod
- image_picker
- shared_preferences
- geolocator
- intl
- dio
<br/>

## 💡 주요 기능
- 로그인
    - Firebase의 users 컬렉션에 등록된 정보로 로그인
- 회원가입
    - ID, 비밀번호, 닉네임 Validation 후 모든 항목 입력 시 회원가입
- 홈 페이지
    - 나의 이미지 및 아이디 표시
    - 내가 참여중인 채팅방 리스트 출력
- 채팅 리스트
    - GPS로 내가 속한 동네의 채팅 리스트 출력
    - Category로 채팅 리스트를 필터링
    - FloatingActionButton으로 채팅 생성
    - 채팅 입장 전 BottomModalSheet으로 채팅방 정보 확인
- 채팅 생성
    - GPS로 내가 속한 동네 표시
    - 카테고리 선택하여 생성 가능 
    - 채팅방 이름 및 설명 Validation
- 채팅방
    - firebase의 스냅샷으로 실시간 채팅 구현
    - n명 실시간 채팅 가능
    - 참여자의 프로필 이미지와 아이디 표시
    - 시간은 'HH:mm' 형식으로 포맷팅 하여 출력
- 마이 페이지
    - 사용자 정보 변경 페이지, 기존에 존재하는 정보를 Validatoin 후 변경
    - 프로필 이미지 / 비밀번호 / 닉네임 변경 가능
<br/>

## 🗄️ Firebase Firestore 구조
<pre>
Firestore
|
|-- chatRooms (Collection)
|    |-- documentId
|         |-- address: String
|         |-- category: String
|         |-- createdAt: TimeStamp
|         |-- info: String
|         |-- title: String
|         |-- users: Array<String>
|         |-- messages (Subcollection)
|              |-- documentId
|                   |-- content: String
|                   |-- createdAt: TimeStamp
|                   |-- senderId: String
|
|-- users (Collection)
     |-- documentId
          |-- id: String
          |-- nickname: String
          |-- password: String
</pre>
<br/>

## 📋 커밋 컨벤션
- `add` : 새로운 파일 및 폴더 추가
- `feat` : 새로운 기능 추가
- `fix` : 버그 수정
- `refactor` : 코드 수정
- `docs` : 문서 수정
- `test` : 테스트 코드
<br/>

