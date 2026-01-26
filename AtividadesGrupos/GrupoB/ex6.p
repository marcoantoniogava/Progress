// le um valor inicial e um valor final e exibe:
// todos os numeros primos dentro desse intervalo

def var inicio  as int label "Inicial".
def var fim     as int label "Fim".
def var n       as int.
def var i       as int.
def var ehPrimo as log.

update inicio
       fim.

n = inicio. // inicializa o contador com o valor inicial

repeat while n <= fim: // percorre todos os numeros do inicio ao fim

    if n > 1 then do: // numeros primos precisam ser maiores que 1

        ehPrimo = true. // assume que vai ser primo

        i = 2. // primeiro divisor a ser testado

        repeat while i < n: // testa divisores
            if n mod i = 0 then do: // mod retorna o resto da divisao
                ehPrimo = false. // se resto = 0, eh divisivel (nao eh primo)
                leave. // achou divisor, sai do loop
            end.
            i = i + 1. // proximo divisor
        end.

        if ehPrimo then
            disp n.

    end.

    n = n + 1. // vai para o proximo numero do intervalo

end.
