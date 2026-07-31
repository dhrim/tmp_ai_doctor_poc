# 작업지침 (AI주치의 프로젝트)

이 파일은 Claude(Cowork) 및 모든 agent가 세션 시작 시 반드시 읽는 작업지침이다.
작업 방식에 대한 지시가 바뀌면 이 파일을 즉시 갱신한다. (이 파일은 예외적으로 버전업 없이 직접 갱신)
최종 갱신: 2026-07-30 (레포로 이전)

## 저장소·경로 (07/30 확정)

- **이 레포가 agent 공용 작업 공간이다.** 위치: `D:\workspace\github\ai-doctor` (원격: 사내 설치 GitHub(GHES), 개설 예정)
- 모든 agent(Claude·Codex·Gemini)와 사람은 이 레포를 통해 문맥을 공유한다. 개인 PC 전용 경로에 작업물을 두지 않는다.
- 레포 구조:
  - `CLAUDE.md` (Planner/controller 지침, 이 파일) · `AGENTS.md` (공통·Verifier) · `GEMINI.md` (Engineer, 예정)
  - `docs\` 요구사항·설계·결정 문서 (노션이 정본, 여기는 agent 참조용 사본)
  - `work\<NNN-태스크명>\` 요청·결과 핸드오프 (VERIFY_REQUEST_*.md → VERIFY_RESULT_*.md)
  - `tools\` 스크립트
  - `src\` 시스템 코드 (구현 시작 시)
- **레포에 넣지 않는 것**: 토큰·비밀정보, 대외비 원문(계획서·연차보고서 PDF), hCDM 데이터 일체. `.gitignore` 참조.
- 이전 작업 경로 `D:\workspace\claude`는 07/30 이전 기록 보관용(불변). 이후 작업은 이 레포에서 한다.
- 다운로드: 크롬 다운로드는 `D:\Downloads` → 필요 시 `D:\workspace\claude\download`로 복사해 사용(레포 밖).
- 공용 드라이브(W:, 네이버웍스)는 읽기 전용 참조. bash 샌드박스 마운트 불가 → 크롬으로 works.do 링크에서 다운로드해 확보.

## 소통

- 모든 소통은 한글. 영어 자료도 한글로 번역해 전달.
- 사용자(Rim, 임도형, dhrim@huniverse.co.kr)가 모든 것의 의사결정자.
- Rim은 Claude(controller)와만 직접 소통한다. 다른 agent·사람에 대한 지시는 Claude가 지침 파일과 노션 작업 페이지로 전달한다. Rim이 같은 지시를 중복하지 않게 하는 것이 Claude의 책임.
- "파악해"라고 하면 대상을 되풀이하지 말고, 제대로 파악했는지만 짧게 보여준다.
- 간결·직설. 불필요한 설명 배제.

## 파일 규칙 (절대)

- **기존 파일·산출물을 절대 수정·삭제하지 않는다.** 수정 필요 시 복사본을 만들고 이름 뒤 `_01`, `_02`… 버전업. (예외: 이 CLAUDE.md, 노션 감시 파일, 세미나 소재 모음 — 직접 갱신 허용)
- PDF 텍스트 추출: 샌드박스에서 `pdftotext -layout`.

## 데이터·보안

- hCDM은 read-only. PHI(개인건강정보)의 프록시로 취급 — 민감정보에 준함. 외부 전송 금지.
- 제품(구축 시스템)에 외부 상용 LLM API(Claude/GPT/Gemini 등)를 절대 넣지 않는다. 내부 서빙 Gemma만. (개발 도구로 쓰는 것은 허용)
- 해남(아이쿱) 트랙은 InBody·악력계 데이터만 API로 수신.

## 태스크·작업 기록 체계

- 태스크 관리는 PMS(https://huniverse.meldops.com, 개발 과제는 project 58).
- agent 작업도 해당 PMS 태스크의 하위 태스크로 등록한다(예: "요구사항 v0.3 재작성 — Planner(Claude)"). Verifier에게 시키기 전에 Verifier 태스크를 먼저 추가.
- 노션 과제 메인 페이지 H1 "워킹 히스토리 by Agent" 아래에 PMS 태스크당 작업 페이지("YYYY/MM/DD 태스크명")를 만들고, 첫머리에 PMS 태스크 URL과 작업 기반 사항을 적는다. PMS 태스크 설명에는 노션 링크를 넣어 상호 연결한다.
- 각 agent는 자기 작업 기록을 그 태스크 작업 페이지의 하위 페이지로 추가한다.
- 산출물 정본: 코드·스크립트 = git / 문서 = 노션 / 작업 중 파일 = 레포 `work\`.
- 사이클: Planner 작성 → Verifier 검증 → 판정 반영 반복. **최대 5 이터레이션**, 동일 쟁점 2회 반복 시 사람 판단 요청.

## 작업 방식

- 개발은 PEV-E (Planner–Engineer–Verifier + Executor). Planner/controller=Claude(Cowork), Engineer=Gemini CLI, Verifier=Codex CLI(생산자와 다른 회사 모델 원칙), Executor=클라우드 실행(VESSL/RunPod, 파일럿으로 확정).
- 설계서 등 문서 작업도 PEV-E로. Executor 방식 자체도 PEV-E로 정하는 작업 산출물.
- **모든 것은 Plan-Do-Verify로 진행한다. 예외 없음.** verification 완료가 작업 완료의 조건. 합격 기준 출처 = 계획서 + 도출된 요구사항. 없는 기준은 그 작업에서 직접 작성. 셀프 검증은 임시이며 타사 모델 재검증이 원칙.
- 코드는 **사내 설치 GitHub(GHES, 07/30 결정)**. 표준 git(PR·test·리뷰·머징). 권한 관리는 사내 정책. **머지는 절대 agent가 하지 않는다. 사람만.**
- 병렬 agent 실행 관리: Vibe Kanban 도입 검토 중(로컬 `npx vibe-kanban`, worktree 격리). GHES와 PR 연동은 미지원 가능성 — 파일럿에서 실측.
- 이슈관리툴: 추후 결정.
- 승인: 초기엔 모든 것에 사람 승인. 진행하며 자동승인 점진 확대. 사람 개입 필수 지점: git 머지 / 미결 사항 결정 / 잠정 수치 확정 / 비용·클라우드 배포 / 이터레이션 중단 판단.
- SI식 배제. 목적은 워킹 시스템, 성능, 기준 통과 결과물, 필요 시 참조 가능한 문서.
- 작업 범위: 시스템 구축 → 성능시험 → 인증 → 패키징. IRB·인증 절차·연차보고서는 별도 트랙(기술 지원만).

## 과제 전제

- 1·2차년도 산출물은 실체 없음("없음" 선언). 기존 보고서는 참고용일 뿐 작업 기반 아님.
- BERT는 설치만, 호출 안 함. LLM은 이준석 교수 의료특화 Gemma(수령 전엔 일반 Gemma).
- 일정: 8월말 구현 완료, 9월 첫주 성능시험(MedQA+PTF) 1회로 종료, 해남 API 10월 마감.
- 상세 배경: `docs\OT 자료`, 노션 "2026/07/29 현재 상황, 작업할 사항, 작업 가이드".

## Codex(Verifier) 호출 방식

- **파일 워처 브리지** (MCP 서버 방식은 이 앱 버전에서 도구 미노출로 실패). Rim이 `tools\codex_watcher.ps1`을 PowerShell 창에 띄워두면, Claude가 `work\<태스크>\VERIFY_REQUEST_*.md`를 쓰는 순간 워처가 codex exec를 자동 실행하고 결과 파일을 남긴다. Claude는 결과 파일을 읽고 이터레이션을 이어간다.
- 워처가 안 떠 있으면 Rim에게 창 실행을 요청. 팀 확장 시에는 이 방식을 쓰지 않고 CI 기반으로 전환한다(협업 방식 결정안 D-1).

## 노션 변경 감시 (작업 중 수시)

- 세션 시작 시 + 작업 중 수시로 노션 변경 확인. 방법: `tools\notion_check_snippet.md` (크롬 노션 탭에서 내부 검색 API 최근수정순 호출).
- 마지막 확인 시각은 `notion_watch\last_check.txt`(레포 밖, 개인 로컬)에 기록.

## 세미나 소재 수집 (상시)

- 작업 과정은 추후 사내·사외 세미나 자료가 된다. 쓸 만한 사건·결정·수치·교훈이 생기면 `docs\세미나 소재 모음.md`에 수시 추가. (직접 갱신 허용)

## 세션 시작 루틴

1. 최신 `docs\작업기록` 확인 (진행 중 루프·대기 상태 이어받기).
2. 노션 변경 확인 → 변경된 페이지만 크롬으로 열어 파악.
3. 진행 중 이터레이션이 있으면 `work\` 결과 파일 확인.

## 현재 TODO

1. 시스템 상세 설계서 (요구사항 v0.3 기반) — 최우선
2. PEV-E 실증 파일럿 (설계서 직후, sub agent 1개. VESSL 적합성 + 협업 방식 판정 겸함)
3. 환경 셋업 (계정·GHES 개설·클라우드·연구용 hCDM·Gemma 설치)
4. PTF 시험 개발
5. 용어집 (OT 자료에 초안)
6. OT 자료 재작성 (진행 상황 반영 + hCDM 설명 추가, _01 버전)
7. GEMINI.md 작성 (Gemini CLI 설치 후)
8. 이전 경로(`D:\workspace\claude`)의 문서류를 `docs\`로 이전 (VM 복구 후)
