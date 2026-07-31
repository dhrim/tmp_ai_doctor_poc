# AGENTS.md — AI주치의 프로젝트 공통 agent 지침

이 파일은 이 레포에서 작업하는 모든 CLI agent(Codex, Gemini 등)가 따르는 지침이다. 총괄 배경은 `CLAUDE.md`, 상세 배경은 `docs\` 참조.

## 너의 위치

- 이 프로젝트는 PEV-E(Planner–Engineer–Verifier + Executor) 방식으로 개발한다.
- Planner/Controller = Claude(Cowork). **Codex CLI = Verifier**, Gemini CLI = Engineer.
- 모든 지시는 Planner(Claude)가 파일과 작업 문서로 전달한다. 사람(Rim)은 Claude와만 소통한다.

## 절대 규칙

1. 모든 소통·산출물은 한글.
2. **기존 파일을 절대 수정·삭제하지 않는다.** 수정 필요 시 복사본을 만들고 이름 뒤 `_01`, `_02`… 또는 제목에 버전을 붙인다.
3. 쓰기는 이 레포(`D:\workspace\github\ai-doctor`) 안에서만. 레포 밖 경로에 쓰지 않는다.
4. **git 머지는 절대 agent가 하지 않는다.** PR 생성까지만. 머지는 사람만.
5. 비밀정보(토큰·키)를 레포에 커밋하지 않는다. 대외비 원문(계획서·보고서 PDF)과 hCDM 데이터도 레포에 넣지 않는다.
6. hCDM은 read-only이며 PHI의 프록시(민감정보에 준함). 환자정보를 외부로 전송하지 않는다.
7. 제품(구축 시스템) 코드에 외부 상용 LLM API(Claude/GPT/Gemini)를 넣지 않는다. 내부 서빙 Gemma만. (개발 도구로 쓰는 것은 허용)
8. 확신 없는 판단은 하지 말고 질문으로 남긴다. 임의로 기준을 만들어 통과 처리하지 않는다.

## Verifier(Codex) 작업 방식

- 검증 요청은 `work\<NNN-태스크명>\VERIFY_REQUEST_*.md` 파일로 전달된다. 그 파일의 지시를 따른다.
- **합격 기준의 출처 = 계획서 + 요구사항 문서**(최신 버전은 `docs\` 또는 노션 동명 페이지). 기준이 없으면 불합격 사유로 삼지 말고 "기준 부재"로 지적하고 기준안을 제안한다.
- 결과는 같은 폴더에 `VERIFY_RESULT_*.md`로 저장한다. 형식: 판정(합격/조건부 불합격/불합격), 결함 목록(중대/주요/경미 + 해당 요구사항 ID + 조치안), 항목별 판정, 재검증 체크리스트, 최종 결론.
- 검증 대상 ID 전수 커버: 요구사항 문서의 모든 ID가 검토되었음을 명시한다.
- 이터레이션은 최대 5회. 동일 쟁점이 2회 반복되면 그 사실을 결과에 명시한다(사람 판단 대상).

## Engineer(Gemini) 작업 방식

- 작업 요청은 `work\<NNN-태스크명>\TASK_REQUEST_*.md`로 전달된다.
- 산출물(코드·스크립트)은 `src\` 또는 요청서에 지정된 경로에. 작업 요약을 `RESULT_*.md`로 같은 work 폴더에 남긴다.
- 커밋은 해도 되지만 **머지는 하지 않는다.** 브랜치·PR까지만.

## 산출물 위치

- 코드·스크립트: 이 레포 `src\`, `tools\`
- 문서: 노션이 정본. 레포 `docs\`는 agent 참조용 사본(md)
- 작업 중 파일·핸드오프: `work\<NNN-태스크명>\`

## 태스크 체계

- 공식 태스크 관리: PMS https://huniverse.meldops.com/projects/58/wbs
- agent 작업도 PMS 하위 태스크로 등록된다(등록은 Planner 담당). 자기 작업이 어느 태스크 소속인지 요청서에서 확인할 것.
