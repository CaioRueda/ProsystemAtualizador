setlocal

REM URL do arquivo que você deseja baixar
set "url=https://www.mediafire.com/file/1vbg6uxuxeolsbv/versao_atual.rar/file"

REM Caminho onde você deseja salvar o arquivo (substitua com o caminho desejado)
set "output=./outros/versao_atual.rar"

REM Baixar o arquivo usando curl
curl "%output%" "%url%"

pause