// fazer uma visualizacao das cidades ordenadas por estado, filtrar por:
// nome da cidade e sigla do estado. Usar break by.

def var nomeCidade as char.
def var siglaEstado as char.

def temp-table tt-cidade like cidade.
def temp-table tt-estado like estado.

for each cidade no-lock:
    create tt-cidade.
    buffer-copy cidade to tt-cidade.
end.
for each estado no-lock:
    create tt-estado.
    buffer-copy estado to tt-estado.
end.

repeat:
    update nomeCidade
    siglaEstado.

    for each tt-estado no-lock,
        each tt-cidade where
             tt-cidade.est-estado = tt-estado.est-estado and //linkando
             tt-cidade.cid-nome matches "*" + nomeCidade + "*" and
             tt-estado.est-estado matches "*" + siglaEstado + "*"
             break by tt-estado.est-estado
             by tt-cidade.cid-nome:
        disp tt-cidade.cid-nome tt-estado.est-estado.
    end.
end.
