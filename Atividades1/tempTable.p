//temp table armazena as informacoes temporariamente no disco, possui as
//propriedades de uma tabela comum do banco de dados.

def temp-table tt
field nome as char
field idade as int
index index01 nome idade. //ordena por nome, se nome for igual ordena por idade

create tt.
assign tt.nome = "Pedro"
tt.idade = 20.

for each tt no-lock:
disp tt.
end.