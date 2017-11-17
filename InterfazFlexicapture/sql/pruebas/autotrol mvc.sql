exec CtasCtesA_TXPorTrs      

select * from puntosventa

select * from ibcondiciones

select * from subrubros

use autotrol

exec sp_helptext 'ibcondiciones_tt'


exec sp_helptext 'clientes_tt'

exec sp_help 'provincias'


exec sp_helptext 'cuentas_tl'

alter table provincias add
		CodigoESRI	varchar(2) null
go
