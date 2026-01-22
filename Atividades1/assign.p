// exibe 3 variavel antes e depois de serem alteradas

def var variavel1 as char.
def var variavel2 as int.
def var variavel3 as log format "1/2".

assign variavel1 = "A"
variavel2 = 1
variavel3 = yes.

disp variavel1
variavel2
variavel3.

// alterando

assign variavel1 = "B"
variavel2 = 2
variavel3 = no.

disp variavel1
variavel2
variavel3.

//exibe apenas o resultado final pois o progress printa um frame por cima do outro, mas em producao teria funcionado (utilizar uma variavel pra algo, e depois alterar e usar pra outra coisa)