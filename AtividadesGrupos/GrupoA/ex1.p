// lêas 3 medidas de um triânguloe retorna o tipo dele
def var medida1 as int label "Medida 1".
def var medida2 as int label "Medida 2".
def var medida3 as int label "Medida 3".
def var tipo as char label "Tipo".

update medida1
medida2
medida3.

if medida1 = medida2 and medida2 = medida3 then do:
assign tipo = "equilatero".
end.

else if medida1 = medida2 or medida2 = medida3 or medida1 = medida3 then do:
assign tipo = "isosceles".
end.

else do:
assign tipo = "escaleno".
end.

disp tipo.