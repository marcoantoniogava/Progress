// lêum núnmerointeiro e retorna se ele � positivo, negativo ou 0
def var num1 as int label "Numero".
def var tipo as char label "Resultado".

update num1.

if num1 > 0 then do:
assign tipo = "Positivo".
end.

else if num1 = 0 then do:
assign tipo = "Zero".
end.

else do:
assign tipo = "Negativo".
end.

disp tipo.