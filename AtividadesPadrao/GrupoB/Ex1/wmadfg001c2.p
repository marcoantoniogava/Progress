//>>>>boas praticas
/* 

-descricoes alinhadas a esquerda
-decimais alinhados a direita
-int a direita
-campos de codigo normalmente sao centralizados
-datas centralizado
-logical é centralizado ou esquerda 

*/


{webpro.i}
{wpadfunc.i}

//precisa colocar isso aq pra usar a funçao no codigo inteiro, tipo um def var de funçao
function festado returns char() forwards.

procedure output-header:
    flista("add","vpad-btpesq.x","true").
end procedure.

//tabela principal da tela, QUE ESTA NA ABRE QUERY
&scoped-define vpad-tabela cidade

//tabela principal + tabelas auxiliares QUE TAMBEM ESTAO NA ABRE QUERY
def query q1 for cidade, estado scrolling.
//tabelas que nao estao na abre query, nao é necessario colocar aqui nesse def query

{wpadco04.i}

procedure p_setvalue:
end procedure.

//parametros
procedure p_setparams:
    assign vpad-titulo  = "Cidades" //titulo
           vpad-ordena  = "" //Contém a lista de itens do combo de pesquisa
           vpad-pesq    = false //Contém o valor informado na caixa de edição de pesquisa.
           vpad-btnaveg = true //se vai ou n vai ter os botoes de navegaçao
           vpad-numlin  = 30 //numero de linhas
           vpad-numcol  = 10 //numero de colunas
           vpad-btret   = ""
           vpad-btinc   = ""
           vpad-btsal   = ""
           vpad-btexc   = "true".
end procedure.

//abrequery, query é tipo um for each mas antigo
procedure p_abrequery:
    open query q1 for each cidade no-lock,
                     first estado where
                           estado.est-estado = cidade.est-estado and //relacionando "FK"
                           estado.est-estado matches "*" + get-value("vest-estadof") + "*" indexed-reposition. // se no get-value for vest-estadof,
end procedure.                                                       //usa a input box pro filtro, se tiver vmeuEstado, usa a select box pro filtro.

procedure p_filtro:
    //document.forms[0].submit();
    //esse parametro pode ser usado em qualquer tipo de input, normalmente nos ultimos parametros char que eles tem
    //colocando ele, a tela vai recarregar depois que tu clicar nele ou selecionar outro registro

    {&out}
        flabel("Estado","right",0,no,no,0,no,no)
        fpad-text("vest-estadof",6,10,get-value("vest-estadof"),"C",no,"left",0,no,no,0,no,no,"document.forms[0].submit();","")
        /* fpad-text("vest-nomef",15,100,(if avail estado 
                                       then estado.est-nome 
                                       else ""),"C",yes,"left",0,no,no,0,no,no,"","")
        fzoom("wawk001i008","vest-estadof,vest-nomef",no,no) */
        fselect("vmeuEstado",festado(),get-value("vmeuEstado"),0,no,no,"left",0,no,no,0,no,no,"document.forms[0].submit();")    
    .

end procedure.

procedure p_valida:
end procedure.

//browse é onde vai o que fica a tela
procedure p_browse:
    finicio(vpad-cor,"").
    fcaixa("C",string(cidade.cid-cidade),"C","Código","",10,0).
    fcaixa("C",cidade.cid-nome,"C","Cidade","",30,0).
    fcaixa("C",if available estado then string(estado.est-nome) else "","C","Estado","",30,0). //se estado estiver disponivel, pega o estado, se nao deixa em branco
    final(no,100,"").
end procedure.

//funcao do select
function festado returns char(): 
    // Função que monta e retorna uma string
    // usada para preencher um campo SELECT (combo box) de estados na tela

    def var vselect as char.
    // Variável que armazenará todas as opções do SELECT
    // no formato: ,valor1,descricao1,valor2,descricao2,...

    assign vselect = ",<-- SELECIONE -->".
    // Inicializa o SELECT com uma opção padrão

    for each estado no-lock              // Percorre todos os registros da tabela ESTADO
          by estado.est-nome:             // Ordena os estados pelo nome

        assign vselect = vselect + "," + estado.est-estado + "," + estado.est-nome.
        // pega o que já tem em vselect e ACRESCENTA mais uma opção de estado no final.
        // --> A cada iteração, adiciona uma nova opção ao SELECT
    end.

    return vselect. // Retorna a string completa, pronta para ser usada diretamente em um campo SELECT da tela

end function.

procedure p_finalizar:
end procedure.

procedure p_excluir:
end procedure.