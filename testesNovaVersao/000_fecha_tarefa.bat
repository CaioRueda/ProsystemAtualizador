taskkill /im Gerencial.exe /f
taskkill /im admin.exe /f
taskkill /im caixa.exe /f
taskkill /im conect.exe /f
taskkill /im copy.exe /f
for /f "tokens=1" %%a in ('net share ^| findstr /i /c:"$"') do (
    echo Removendo compartilhamento: %%a
    net share %%a /delete
)