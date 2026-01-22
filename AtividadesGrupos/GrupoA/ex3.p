// le um numero inteiro e mostra a tabuada desse numero, de 1 a 10.
def var n as int label "Numero".
def var multiplicador as int label "NumTabuada" initial 1.
def var resultado as int label "Resultado".
def var i as int.

update n.

do i = 1 to 10:

assign resultado = n * multiplicador.
disp multiplicador.
disp resultado.

multiplicador = multiplicador + 1.

pause.
end.