ren backup bkp_versao_anterior
rmdir /s /q "rels"
robocopy /s "./Etapa" .
start relatorio.sql