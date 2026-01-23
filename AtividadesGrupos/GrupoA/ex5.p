// le uma sequencia de caracteres e retorna ela resumida

def var texto as char.
def var contador as int.
def var charAtual as char.
def var charAnterior as char.
def var i as int.

update texto.

contador = 0.
charAnterior = "".

// percorre a string por todos os caracteres
do i = 1 to length(texto):

charAtual = substring(texto, i, 1). //pega o caracter atual

if charAtual = charAnterior then do:
contador = contador + 1.
end. //end do if

else do:
//se nao e o primeiro caracter, imprime o anterior
if charAnterior <> "" then
disp charAnterior + string(contador) no-label.

charAnterior = charAtual.
contador = 1.
end. //end do else
end. //end do do

disp charAnterior + string(contador) no-label.