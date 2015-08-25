orsp_who2
exec sp_lock
--:connect MARIANO-PC
use demopronto
go

select * from formularios

select idobrarelacionada,* from detallerequerimientos
select * from obras


exec Empresa_Tx_Datos

sp_helptext 'Pedidos_TT'

Autorizaciones_TX_CantidadAutorizaciones 4,0

exec CtasCtesA_TXPorTrs 976,-1 ,'20001111'
select * from  CuentasCorrientesAcreedores
select * from Proveedores where idproveedor=976

select * from presupuestos
select * from detallepresupuestos

select * from pedidos

sp_helptext pedidos_tt
go

sp_helptext CtasCtesA_TXPorTrs
go
sp_helptext OrdenesPago_TX_EnCaja
go
exec OrdenesPago_TX_EnCaja FI
exec OrdenesPago_TX_EnCaja 'FI' 
exec OrdenesPago_TX_EnCaja 'CA' 
select * from OrdenesPago
update OrdenesPago  set  estado='CA' 

update prontoini set Valor='SI' where IdProntoIniClave=6 

select * from empleados where Nombre='esucoreq' or UsuarioNT='esucoreq'

select * from prontoini where IdProntoIniClave=6 and idusuario=508
select * from ProntoIniClaves



select * from EmpleadosAccesos where nodo like '%mnu%'

select * from Proveedores

select * from comparativas

select * from _tempautorizaciones
AutorizacionesPorComprobante_Generar 'SI' --'NO'

select * from empleados
delete Empleados where IdEmpleado=516
update Empleados set Password='AD' where nombre='Alberto Diel'
update Empleados set Password='AP' where nombre='Alejandro Poli'

sp_helptext 'AutorizacionesPorComprobante_A'
sp_helptext 'AutorizacionesPorComprobante_Generar'
sp_helptext 'AutorizacionesPorComprobante_TX_DocumentosPorAutoriza'
sp_helptext 'AutorizacionesPorComprobante_TX_DocumentosPorAutorizaSuplentes'

select * from comparativas


exec AutorizacionesPorComprobante_TX_DocumentosPorAutoriza  411
exec AutorizacionesPorComprobante_TX_DocumentosPorAutoriza  312

select * from Autorizaciones
select * from detalleautorizaciones

select * from autorizacionesporcomprobante



select * from detalleautorizacionesfirmantes 
select * from AutorizacionesCompra
select * from AutorizacionesPorComprobanteADesignar

sp_helptext 'comparativas_tt'
sp_helptext 'Autorizaciones_TX_PorFormulario'

select * from bdlmaster.dbo.aspnet_Users
go


select * from detallecomparativas
select * from requerimientos
select * from det



[aspnet_Roles_CreateRole] '/','SuperAdmin'  --ejecutar en la bdlmaster
go
[aspnet_Roles_CreateRole] '/','Administrador'  --ejecutar en la bdlmaster
go
[aspnet_Roles_CreateRole] '/','Comercial'  --ejecutar en la bdlmaster
go
[aspnet_Roles_CreateRole] '/','FacturaElectronica'  --ejecutar en la bdlmaster
go

select * from bdlmaster.dbo.vw_aspnet_MembershipUsers
select * from bdlmaster.dbo.aspnet_Roles
select * from bdlmaster.dbo.aspnet_UsersInRoles
select * from bdlmaster.dbo.DetalleUserBD where userid ='573BED21-B412-43D6-806A-A7A1B37CCE8F'
select * from bdlmaster.dbo.aspnet_Users

select * from empleados

--sp_helptext 'aspnet_UsersInRoles'

exec obras_tx_datosdelaobra 10

-- sp_help 'empleados' 
go

sp_helptext obras_tx_datosdelaobra

select * from empleados

update empleados set usuariont='Administrator',nombre='Administrator' where idempleado=362

update Empleados set Password='pirulo!'

SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='empleados'
go

Tree_TX_Arbol 'Horizontal' 
go


update tree
set Link='<a href="/Pronto2/Acceso/Edit/-1">Definicion de accesos</a>'
--select * 
from tree where Descripcion like '%accesos%'





--:connect MyServer
use AdministradorProyecto

select R.IdReclamo, R.TituloReclamo,C.Comentario,c.FechaComentario  
from comentariosreclamo  C --para ver qué hiciste, revisá tus visitas a stackoverflow
left join Reclamos R on C.idreclamo=R.IdReclamo
where idusuario=125 and 
        FechaComentario between '28/2/2013' and '5/4/2013'
order by idcomentario asc 




use autotrol

select  * from empleados where Nombre like '%supervisor%' or  UsuarioNT like '%supervisor%'
select * from empleadosaccesos where idempleado=129



select * from empleadosaccesos where nodo like '%acceso%'



delete empleadosaccesos where idempleado=129 and IdEmpleadoAcceso>8000

delete empleadosaccesos where idempleado=467 


update empleados set usuariont='Mariano',Administrador='SI' where idempleado=383
update empleados set usuariont='supervisor',Administrador='SI' where idempleado=129
update empleados set Administrador='SI' where Nombre like 'supervisor'
update empleados set Administrador='SI' where Nombre like 'Mariano'


select 
distinct idcliente
-- select facturas.IdUsuarioIngreso,cae,* 
from facturas 
where fechafactura>='2012-12-10 14:35:23.000'
order by idfactura desc



select * from articulos
go
sp_helptext 'Articulos_tt'
go

--sp_helptext 'Articulos_tx_datosconcuenta'
exec Articulos_tx_datosconcuenta 4936

update Clientes set PorcentajePercepcionIVA=5.25  where idcliente=454

select IBcondicion,* from clientes where not IBcondicion is  null  order by PorcentajePercepcionIVA desc 

select Esagenteretencioniva,clientes.PorcentajePercepcionIVA ,* from clientes where Esagenteretencioniva='SI' order by PorcentajePercepcionIVA desc 

select * from DetalleFacturasRemitos


exec wlocalidades_TT
--sp_helptext 'wlocalidades_TT'
select * from localidades where nombre like '*esme*'
select * from facturas
select * from detallefacturas

exec dbo.OrdenesCompra_TX_ItemsPendientesDeFacturar

exec dbo.Remitos_TX_ItemsPendientesDeFacturar

exec sp_helptext Remitos_TX_ItemsPendientesDeFacturar

select codigo,CodigoCliente,TipoCliente,* from clientes
select * from puntosventa

select * from provincias 

select * from Localidades where Nombre like 'AIMOGASTA'

select igcondicion, IBCondicion,* from clientes 



select * from ibcondiciones
select * from igcondiciones

select * from subrubros



use autotrol

exec sp_helptext 'ibcondiciones_tt'


exec sp_helptext 'clientes_tt'

exec sp_help 'provincias'

exec sp_help 'clientes'

exec sp_helptext 'cuentas_tl'

alter table provincias add
		CodigoESRI	varchar(2) null
go

alter table provincias add
		CodigoESRI	varchar(2) null
go

alter table paises add
		CodigoESRI	varchar(2) null
go

alter table localidades add
		CodigoESRI	varchar(2) null
go

exec sp_helptext 'facturas_TT'

exec sp_help 'paises'

exec sp_help 'subrubros'

exec sp_helptext 'Cotizaciones_TX_PorFechaMoneda'




go
sp_help 'clientes'

SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='clientes'





select * from cartasdeporte where netoproc=30820
and (fechaingreso < '20111223' )
and (vendedor=1098 or cuentaorden1=1098 or cuentaorden2=1098 or entregador=1098)
and destino=44

select observaciones,IdArticulo,* from DetalleFacturas where Idfactura=29189 order by  cast(observaciones as varchar(500)) 






select * from DetalleComprobantesProveedores







	ALTER TABLE Proveedores ALTER COLUMN EnviarEmail tinyint NULL
go


