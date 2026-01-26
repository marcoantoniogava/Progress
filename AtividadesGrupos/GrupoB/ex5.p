// le nome, salario e departamento dos funcionarios, armazena em uma temp table
// e exibe: todos os funcionarios ordenados por salario (maior pro menor)
// e o total de salarios por departamento

def temp-table ttFunc
    field nome      as char
    field salario   as dec
    field dep       as char.

def var opcao as int.

repeat:

disp "1- cadastrar, 2- listar funcionarios, 3- total salario, 4- sair: ".
update opcao.

if opcao = 1 then do:

create ttFunc.

update ttFunc.nome
ttFunc.salario
ttFunc.dep.

end. //end do if

else if opcao = 2 then do:

for each ttFunc no-lock //percorre todos os registros da tabela ttFunc
by ttFunc.salario descending: //ordena os registros por salario, do > pro <

disp ttFunc.nome
ttFunc.salario
ttFunc.dep.

end. //end do for each

end. //end do else if

else if opcao = 3 then do:

def var totalDep as dec label "TotalDepartamento".

for each ttFunc no-lock //percorre todos os registros da ttFunc
break by ttFunc.dep: //agrupa os registros por dep 

if first-of(ttFunc.dep) then //TRUE quando eh o primeiro registro daquele dep
assign totalDep = 0. // zera o total para comecar a soma do dep

assign totalDep = totalDep + ttFunc.salario. //soma o salario ao total do departamento

if last-of(ttFunc.dep)
then //TRUE quando eh o ultimo registro daquele dep
disp ttFunc.dep totalDep. //exibe o departamento e o total calculado

end. //end do for each
end. //end do else if

else if opcao = 4 then do:
leave.
end. //end do else if
             
end. //end do repeat
