// like copia as informacoes de uma tabela ja existente

def temp-table tt like usuario.

create tt.
assign tt.usu-nome = "Pedro Antonio"
tt.usu-usuario = "pedroAnt".

for each tt no-lock:
disp tt.usu-usuario
tt.usu-nome.

end.