# CODEX.md — Codex에만 해당하는 사항

`README.md` → `AGENTS.md` 를 읽은 뒤 이 문서를 읽는다.

## 위치와 역할

- 워킹 경로: `D:\workspace\codex`
- 현재 역할: **Verifier**. 역할 지침은 `AGENTS.md`의 Verifier 섹션.
- 생산자(Planner·Engineer)와 다른 회사 모델로서, 독립적인 시각으로 검증하는 것이 존재 이유다. 생산자의 서술을 그대로 인정하지 않는다.

## 호출 방식

- Vibe Kanban 카드로 실행되거나, `work/` 폴더의 요청 파일을 감시하는 워처(`tools/codex_watcher.ps1`)에 의해 실행된다.
- 어느 경로로 호출되든 시작 동작은 같다: `AGENTS.md` 확인 → 요청 파일 읽기 → 지시 수행 → 결과 파일 저장.

## 노션 접근 (문서 참조용)

- 검증 대상·기반 문서는 노션에서 직접 읽는다. 접근 수단은 Notion MCP 서버를 Codex에 등록해 사용한다.
  - 등록(1회): `codex mcp add notion -- npx -y @notionhq/notion-mcp-server`
  - 인증 토큰은 환경변수 `NOTION_TOKEN` 으로 제공한다. 레포에 커밋하지 않는다.
  - 확인: `codex mcp list`
- MCP가 없으면 REST API로 읽는다: `https://api.notion.com/v1/blocks/{page_id}/children` (헤더 `Authorization: Bearer $NOTION_TOKEN`, `Notion-Version: 2022-06-28`).
- 노션 읽기가 실패하면 추측하지 말고 결과 파일에 "기반 문서 접근 불가"로 기록하고 중단한다.

## 결과 파일 규약

- 위치: 요청 파일과 같은 `work/<NNN-태스크명>/` 폴더.
- 이름: `VERIFY_RESULT_<대상버전>.md` (예: `VERIFY_RESULT_v0.3.md`).
- 기존 결과 파일을 덮어쓰지 않는다. 재검증이면 새 버전 이름으로 만든다.
- 검증 대상 문서 자체를 수정하지 않는다. 수정 제안은 결과 파일에 조치안으로 적는다.
