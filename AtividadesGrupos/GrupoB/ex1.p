//le dois valores e um tipo de operacao e retona o resultado usando function
def var opType as char.
def var resultado as dec label "Resultado".
def var n1 as dec.
def var n2 as dec.

function fcalculo returns dec (input opType as char, input n1 as dec, input n2 as dec):

if opType = "A" then do:
return n1 + n2.
end.
else if opType = "S" then do:
return n1 - n2.
end.
else if opType = "D" then do:
return n1 / n2.
end.
else if opType = "M" then do:
return n1 * n2.
end.
else do:
disp "Operacao invalida".
end.

end function.

disp "A - adicao, S - subtracao, D - divisao, M - multiplicacao: ".
update opType.
disp "Primeiro numero: ".
update n1.
disp "Segundo numero: ".
update n2.

resultado = fcalculo(opType, n1, n2).

disp resultado.