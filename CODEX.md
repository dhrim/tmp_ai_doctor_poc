# CODEX.md — Codex에만 해당하는 사항

| | |
|---|---|
| 규칙 버전 | v1.0 |
| 시행일 | 2026-07-31 |

`README.md` → `AGENTS.md` 를 읽은 뒤 이 문서를 읽는다. Codex 고유의 경로·도구·절차만 적는다.

## 위치와 역할

- 워킹 경로: `D:\workspace\codex` (레포 clone은 `D:\workspace\codex\ai-doctor`)
- 역할: **Verifier**. 역할 지침은 `AGENTS.md`의 Verifier 섹션.
- 생산자(Planner·Engineer)와 다른 회사 모델로서 독립적으로 검증하는 것이 존재 이유다. 생산자의 서술을 그대로 인정하지 않는다.

## 호출 방식

- **기본: Vibe Kanban 카드.** 카드가 만든 worktree가 작업 경로다.
- 보조: 사람이 `codex exec` 로 직접 실행. 이때도 **`D:\workspace\codex\ai-doctor` 의 전용 브랜치/worktree에서만** 실행한다. 요청서의 상대 경로는 그 작업 사본을 기준으로 해석한다. 작업 사본을 만들 수 없으면 읽기 전용 진단만 하고 결과 작성은 중단한다. 정본 레포에는 쓰지 않는다.
- `tools/codex_watcher.ps1` 은 폐기되었다. 사용하지 않는다 (README §8).

### 사람이 직접 실행할 때의 표준 명령

**대화형 TUI(`codex`)를 쓰지 않는다.** TUI는 파일 접근·쓰기마다 승인을 물어 자동 실행이 멈춘다. 반드시 비대화형 `codex exec` 를 쓴다.

```
codex exec --cd <작업 루트> -m <모델> -s workspace-write "<지시>"
```

- `--cd` 는 **읽을 곳과 쓸 곳을 모두 포함하는 상위 경로**로 잡는다. 샌드박스의 쓰기 허용 범위가 cwd 기준이라, 밖에 쓰려 하면 승인 요청이 뜬다.
- 별도 경로에 써야 하면: `-c sandbox_workspace_write.writable_roots=["<경로>"]`
- 그래도 승인이 뜨면 그 호출에 한해: `-c approval_policy="never"` 또는 `--full-auto`
- **`--dangerously-bypass-approvals-and-sandbox` 는 쓰지 않는다.** 샌드박스 자체를 끄며, hCDM과 자격증명이 있는 장비에서는 금지한다 (README §5).

## 노션 접근

- 검증의 기반 문서는 노션에서 직접 읽는다. 수단은 Notion MCP 서버.
  - 등록(1회, **버전 고정**): `codex mcp add notion -- npx @notionhq/notion-mcp-server@<승인된 버전>`
  - **2026-07-31 현재 이 MCP는 미승인이다.** 무버전 `-y` 로 등록된 상태이며, 셋업 완료 전에 고정 버전으로 재등록하고 README §5.4 표에 승인 ID를 기입해야 한다.
  - 토큰은 환경변수 `NOTION_TOKEN`. 레포에 커밋하지 않는다.
  - 확인: `codex mcp list`
- MCP가 없으면 공식 REST API로 읽는다: `https://api.notion.com/v1/blocks/{page_id}/children` (헤더 `Authorization: Bearer $NOTION_TOKEN`, `Notion-Version: 2022-06-28`).
- 읽기가 실패하면 추측하지 말고 "기반 문서 접근 불가"로 기록하고 중단한다.

## 결과 파일 규약

- 위치: 요청 파일과 같은 `work/<NNN-태스크명>/` 폴더.
- 이름: `VERIFY_RESULT_<대상버전>.md` (예: `VERIFY_RESULT_v0.3.md`).
- 기존 결과 파일을 덮어쓰지 않는다. 재검증이면 새 버전 이름으로 만든다.
- **검증 대상 문서 자체를 수정하지 않는다.** 수정 제안은 결과 파일에 조치안으로 적는다.
- 결과 머리에 `iteration: n/5`, 생산자·검증자의 회사·모델명과 실행 식별자, 기반 문서의 page_id와 버전, **검증 대상 commit SHA**를 적는다.
