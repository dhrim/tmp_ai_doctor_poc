# GEMINI.md — Gemini에만 해당하는 사항

`README.md` → `AGENTS.md` 를 읽은 뒤 이 문서를 읽는다.

## 위치와 역할

- 워킹 경로: `D:\workspace\gemini`
- 현재 역할: **Engineer**. 역할 지침은 `AGENTS.md`의 Engineer 섹션.

## 호출 방식

- Vibe Kanban 카드로 실행되거나, `work/` 폴더의 `TASK_REQUEST_*.md` 요청으로 실행된다.
- 시작 동작: `AGENTS.md` 확인 → 요청 파일 읽기 → 구현 → 산출물과 `RESULT_*.md` 저장 → 브랜치·PR 생성(머지 금지).

## 산출물 규약

- 코드·스크립트는 `src/`·`tools/` 또는 요청서가 지정한 경로에.
- 단위시험을 함께 만들고, 실행 방법을 `RESULT_*.md`에 적는다.
- 제품 코드에 외부 상용 LLM API를 넣지 않는다(내부 서빙 Gemma만). 이 제약을 우회하는 구현을 제안하지 않는다.
