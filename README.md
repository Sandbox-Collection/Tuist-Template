# Tuist-Template
Tuist Version: 4.55.6


## 주요 특징
- Clean Architecture 예시 타겟 구성 (App / Presentation / Data / Domain)
- 환경별 구성 (DEV / STAGING / PROD) + xcconfig 자동 적용
- 테스트 타겟 / Assets, Fonts 코드 자동 생성
- 공통 설정 플러그인화 (Plugin + Extension)


## 구조 간단 요약

📁 Projects/  
- 각 모듈이 들어있는 폴더

📁 Plugins/  
- Tuist 확장 Source가 들어있는 폴더

📁 SupportFiles/  
- xcconfig, Info.plist, 리소스

Workspace.swift – 전체 워크스페이스 구성

---

## 사용 방법

```bash
# 1. 저장소 클론
git clone https://github.com/Sandbox-Collection/Tuist-Format.git
cd Tuist-Format/Sample

# 2. Tuist 설치
tuist install

# 3. 프로젝트 생성
tuist generate
```
