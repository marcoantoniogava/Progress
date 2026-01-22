// concatena duas strings
def var v1 as char label "Valor 1" format "x(1)".
def var v2 as char label "Valor 2" format "x(1)".
def var v3 as char label "Total" format "x(2)".

update v1
v2.

assign v3 = v1 + v2.

disp v3.