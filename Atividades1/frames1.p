// form que pede informacoes
def var v1 as int format ">>9" label "Código".
def var v2 as dec format "->>>,>>9.99" label "Valor".
def var v3 as char format "x(20)" label "Nome".
def var v4 as log format "Fem/Masc" label "Sexo".
def var v5 as date format "99/99/9999" label "Data".

def frame f-1
v1 colon 15
v2 colon 15
v3 colon 15
v4 colon 15
v5 colon 15
with centered row 3 side-labels.

update v1
v2
v3
v4
v5
with frame f-1 title "Teste".