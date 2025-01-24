rem		0. Fecha aplicativos e encerra o compartilhamento de pastas locais (precisa executar .bat como administrador)
taskkill /im Gerencial.exe /f
taskkill /im admin.exe /f
taskkill /im caixa.exe /f
taskkill /im conect.exe /f
taskkill /im copy.exe /f
for /f "tokens=1" %%a in ('net share ^| findstr /i /c:"$"') do (
    echo Removendo compartilhamento: %%a
    net share %%a /delete
)

rem 		1. Extrai o RAR da versão e coloca ele numa pasta versao_atual dentro da pasta Outros
setlocal
set "PastaNome=versao_atual"
set "ArquivoRAR=%~dp0\versao_atual.rar"
set "PastaCriada=%cd%\outros\%folderName%"
if not exist "%extractPath%" (
    mkdir "%extractPath%"
)
"C:\Program Files\WinRAR\WinRAR.exe" x -y "%ArquivoRAR%" "%ePastaCriada%"

rem 		2. Puxa os arquivos da atualização na pasta local
set origem=".\outros\versao_atual\*"
set destino=%CD%
xcopy /e /i /y %origem% "%destino%"

set origem=".\dll\*"
set destino=%CD%
xcopy /e /i /y %origem% "%destino%"

set origem=".\relatorios\*"
set destino=%CD%
xcopy /e /i /y %origem% "%destino%"

rem 		3. Executa o Gerencial e espera 10 segundos para os scripts rodarem
start /d ".\gerencial\" Gerencial.exe
timeout /t 10

rem		4. Move os conteúdo da pasta backup à pasta bkp_versao_anterior
set origem=".\backup"
set destino=".\bkp_versao_anterior"
move /y "%origem%\*.*" "%destino%"

rem		5. Executa o Admin, Caixa, abre o relatorio.sql para atualizar manualmente, e espera 10 segundos para os scripts rodarem
start admin.exe
start caixa.exe
start relatorio.sql
timeout /t 10

rem		6. Inicia o Backup
start copy.exe

rem		7. Por fim, finaliza a tarefa do Admin e Caixa e remove arquivos desnecessários
taskkill /im admin.exe /f
taskkill /im caixa.exe /f

mkdir "temp"
set "origem=.\dll"
set "destino=.\temp"
move "%origem%" "%destino%"
set "origem=.\relatorios"
set "destino=.\temp"
move "%origem%" "%destino%"
set "origem=.\# ajustes.txt"
set "destino=.\temp"
move "%origem%" "%destino%"
set "origem=.\# instrucoes_atualizacao.txt"
set "destino=.\temp"
move "%origem%" "%destino%"
set "origem=.\versao_atual.rar"
set "destino=.\temp"
move "%origem%" "%destino%"
rmdir /s /q ".\temp"