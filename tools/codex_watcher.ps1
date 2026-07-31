# codex_watcher.ps1 — Codex(Verifier) 자동 실행 브리지
#
# 동작: 이 레포의 work\ 폴더 아래 요청 파일(VERIFY_REQUEST_*.md / TASK_REQUEST_*.md)을 감시.
#       새 요청이 생기면 codex exec 를 자동 실행하고, 처리한 요청은 .done 파일로 표시.
#
# 실행 (PowerShell 창을 열어둔 동안만 동작. 닫으면 중지):
#   powershell -ExecutionPolicy Bypass -File D:\workspace\github\ai-doctor\tools\codex_watcher.ps1
#
# 중지: Ctrl+C
#
# 주의: 이 방식은 개인 PC 의존이므로 팀 확장 시에는 CI 기반으로 전환한다 (협업 방식 결정안 D-1).

$ErrorActionPreference = "Continue"
$base    = "D:\workspace\github\ai-doctor"
$workDir = Join-Path $base "work"
$codex   = "C:\Users\1\AppData\Local\Programs\OpenAI\Codex\bin\codex.exe"
$logFile = Join-Path $workDir "codex_watcher.log"

if (!(Test-Path $workDir)) { New-Item -ItemType Directory -Path $workDir -Force | Out-Null }

function Log($msg) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $msg
    Write-Host $line
    Add-Content -Path $logFile -Value $line -Encoding UTF8
}

Log "watcher 시작. 감시 경로: $workDir  (Ctrl+C로 중지)"
Log "codex 경로: $codex"

while ($true) {
    $requests = Get-ChildItem -Path $workDir -Recurse -File -Include "VERIFY_REQUEST_*.md","TASK_REQUEST_*.md" -ErrorAction SilentlyContinue

    foreach ($req in $requests) {
        $doneMark = "$($req.FullName).done"
        if (Test-Path $doneMark) { continue }

        # 파일 쓰기 완료 확인 (2초 간격 크기 비교)
        $size1 = $req.Length
        Start-Sleep -Seconds 2
        $size2 = (Get-Item $req.FullName).Length
        if ($size1 -ne $size2) { Log "쓰기 중, 다음 주기에 처리: $($req.Name)"; continue }

        $rel = $req.FullName.Substring($base.Length).TrimStart('\')
        Log "==== 요청 감지: $rel -> codex 실행 ===="

        $prompt = "먼저 AGENTS.md 를 읽고 규칙을 따르라. 그다음 '$rel' 파일을 읽고 그 안의 지시대로 작업을 수행하라. 산출물은 요청 파일에 지정된 경로에 새 파일로 저장하라. 기존 파일은 수정하지 마라."

        try {
            & $codex exec --cd $base -s workspace-write -a never $prompt 2>&1 |
                Tee-Object -FilePath (Join-Path $req.DirectoryName "codex_stdout_$($req.BaseName).log")
            Log "codex 종료코드: $LASTEXITCODE"
        } catch {
            Log "codex 실행 오류: $_"
        }

        Set-Content -Path $doneMark -Value (Get-Date -Format "yyyy-MM-dd HH:mm:ss") -Encoding UTF8
        Log "==== 완료: $rel ===="
    }

    Start-Sleep -Seconds 10
}
