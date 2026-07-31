# AI주치의 (RWD기반 AI 건강 주치의)

스케일업 TIPS 과제(RS-2024-00410739) 3차년도 시스템 구축 레포. agent(Claude·Codex·Gemini)와 사람이 공유하는 작업 공간.

## 시작하기 (신규 참여자)

1. 이 레포를 clone 한다.
2. `CLAUDE.md`와 `AGENTS.md`를 읽는다. 작업 규율이 전부 여기 있다.
3. 자기 태스크는 PMS에서 확인한다: https://huniverse.meldops.com/projects/58/wbs
4. 배경 파악은 `docs\` 의 OT 자료 → 요구사항 문서 순서로.

개인 PC에 별도 설정을 만들지 않는다. 지침·규약·핸드오프는 모두 이 레포에 있다.

## 구조

```
CLAUDE.md    Planner/controller(Claude) 지침 — 프로젝트 총괄 규율
AGENTS.md    공통·Verifier(Codex) 지침
GEMINI.md    Engineer(Gemini) 지침 (예정)
docs/        요구사항·설계·결정 문서 (노션이 정본, 여기는 참조용 사본)
work/        태스크별 요청·결과 핸드오프 (VERIFY_REQUEST_*.md → VERIFY_RESULT_*.md)
tools/       스크립트 (워처, 노션 감시 등)
src/         시스템 코드 (구현 시작 시)
```

## 하지 말아야 할 것

- 토큰·키 커밋
- 대외비 원문(계획서·연차보고서 PDF), hCDM 데이터 반입
- agent의 git 머지 (머지는 사람만)
- 기존 파일 수정·삭제 (복사본 + 버전업)

## 현재 상태 (2026-07-30)

- 원격: 사내 설치 GitHub(GHES) 개설 예정. 그전까지는 로컬 저장소로 운영.
- 진행 중: 요구사항 정의 이터레이션(v0.3 검증 대기), 다음은 시스템 상세 설계서.
- 개발 방식: PEV-E (Planner–Engineer–Verifier + Executor). 상세는 `docs\협업 방식 검증 및 결정안`.
