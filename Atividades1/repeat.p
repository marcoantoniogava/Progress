// repeat, comando de repeticao que usa leave para sair do loop
def var sair as log format "Sim/Nao".
def var nome as char.

repeat: //repete
update sair. //pergunta se quer sair

if sair //se sair for true
then leave. //entao sai

update nome.
disp nome.
end.