// usuario informa dia e horario de sua agenda,
// e mostra todos os registros que estao sobrepostos

def temp-table ttAgenda
field data as date
field hora as char.

def buffer agd for ttAgenda.

def var qtd as int.

repeat:

create ttAgenda.
update ttAgenda.data
ttAgenda.hora.

for each ttAgenda:
qtd = 0.

for each agd:
if agd.data = ttAgenda.data
and agd.hora = ttAgenda.hora then
qtd = qtd + 1.

end. //end do for each

if qtd > 1 then do:
disp ttAgenda.data
ttAgenda.hora.
end. //end do if

end. //end do for each

end. //end do repeat