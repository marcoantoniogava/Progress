{wparams.i}
{wcabweb.i vurl """ """}
assign vurl = "*" + furl(""" """).

def var vpais  as int.
def var vtotal-cidades as int.
def var vtotal-cidades-geral as int.

assign vpais  = batweb.batpari[1].

find pais where pais.pai-pais = vpais no-lock no-error.

for each estado where
         estado.pai-pais  = (if vpais = ?
                               then estado.pai-pais
                               else vpais) no-lock:
    
    assign vtotal-cidades = 0.

    for each cidade where 
             cidade.est-estado = estado.est-estado no-lock:
             assign vtotal-cidades = vtotal-cidades + 1.
    end.
    assign vtotal-cidades-geral = vtotal-cidades-geral + vtotal-cidades.

    finicio(vcor).
    fcaixa("C",pais.pai-nome,"C","País","",12,0).
    fcaixa("E",estado.est-estado,"E","UF","",0,0).
    fcaixa("C",estado.est-nome,"C","Estado","",12,0).
    fcaixa("C",string(vtotal-cidades),"C","Número de Cidades - Estado","",12,0).
    final(no,100,"").
end.

finicio(vcor).
fcaixa("D","Total - Geral","C","N° de cidades - Geral","",0,3).
fcaixa("C",string(vtotal-cidades-geral),"C","Número de Cidades - Geral","",10,0).
final(no,100,"").

{wrodweb.i}
{warqfim.i}