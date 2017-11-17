

--use autotrol
--use DemoPronto


ALTER TABLE PuntosVenta  WITH NOCHECK 
ADD  CONSTRAINT FK_PuntosVenta_TiposComprobante FOREIGN KEY(IdTipoComprobante)
REFERENCES TiposComprobante (IdTipoComprobante)
GO



alter table  IBCondiciones
		ADD   CONSTRAINT FK_IBCondiciones_Provincias
		FOREIGN KEY (IdProvincia) REFERENCES Provincias(IdProvincia)
go

alter table  IBCondiciones
		ADD   CONSTRAINT FK_IBCondiciones_Provincias_Real
		FOREIGN KEY (IdProvinciaReal) REFERENCES Provincias(IdProvincia)
go

alter table  IBCondiciones
		ADD   CONSTRAINT FK_IBCondiciones_Cuentas_IIBB
		FOREIGN KEY (IdCuentaPercepcionIIBB) REFERENCES Cuentas(IdCuenta)
go

alter table  IBCondiciones
		ADD   CONSTRAINT FK_IBCondiciones_Cuentas_IIBBConvenio
		FOREIGN KEY (IdCuentaPercepcionIIBBConvenio) REFERENCES Cuentas(IdCuenta)
go

alter table  IBCondiciones
		ADD   CONSTRAINT FK_IBCondiciones_Cuentas_IIBBCompras
		FOREIGN KEY (IdCuentaPercepcionIIBBCompras) REFERENCES Cuentas(IdCuenta)
go

exec sp_help 'IBCondiciones'


alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdCue__34BC17D4

alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdCue__47CEEC48
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdCue__4F700E10
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdPro__32D3CF62
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdPro__33C7F39B
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdPro__45E6A3D6
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdPro__46DAC80F
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdPro__4D87C59E
 
alter table  IBCondiciones drop   CONSTRAINT FK__IBCondici__IdPro__4E7BE9D7








select * from IBCondiciones
select * from Cuentas


select * from ListasPrecios
select * from ListasPreciosDetalle

exec sp_help 'ListasPreciosDetalle'
go

alter table  ListasPreciosDetalle
		ADD CONSTRAINT FK_ListasPreciosDetalle_Articulos
		FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
go


alter table  ListasPrecios
		ADD CONSTRAINT FK_ListasPrecios_Monedas
		FOREIGN KEY (IdMoneda) REFERENCES Monedas(IdMoneda)
go


--select * from autotrol.dbo.DetalleFacturas

exec sp_help 'DetalleFacturas'
exec sp_help 'Facturas'


alter table  DetalleFacturas
		ADD CONSTRAINT FK_DetalleFacturas_Facturas
		FOREIGN KEY (IdFactura) REFERENCES Facturas(IdFactura)
go

exec sp_help 'ListasPreciosDetalle'

alter table  ListasPreciosDetalle
		ADD CONSTRAINT FK_ListasPreciosDetalle_ListasPrecios
		FOREIGN KEY (IdListaPrecios) REFERENCES ListasPrecios(IdListaPrecios)
go

select * from Clientes
exec sp_help 'Clientes'
select * from DescripcionIva 

alter table  Clientes
		ADD CONSTRAINT FK_Clientes_DescripcionIva
		FOREIGN KEY (IdCodigoIVA) REFERENCES DescripcionIva(IdCodigoIVA)
go

alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Cuentas
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go








select * from Clientes
exec sp_help 'Clientes'
select * from IGCondiciones 

alter table  Clientes
		ADD CONSTRAINT FK_Clientes_IGCondiciones
		FOREIGN KEY (igcondicion) REFERENCES IGCondiciones(idigcondicion)
go


select * from [Condiciones Compra]
alter table  Clientes
		ADD CONSTRAINT FK_Clientes_CondicionCompras
		FOREIGN KEY (idcondicionventa) REFERENCES  [Condiciones Compra](idcondicioncompra)
go



alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Monedas
		FOREIGN KEY (idmoneda) REFERENCES Monedas(idmoneda)
go


select * from Clientes
exec sp_help 'Clientes'
select * from IBCondiciones 

select * from  ListasPrecios
alter table  Clientes
		ADD CONSTRAINT FK_Clientes_listasprecio
		FOREIGN KEY (idlistaprecios) REFERENCES ListasPrecios(idlistaprecios)
go


exec sp_help 'ListasPrecios'

--select * from  ListasPrecios
--alter table  Clientes
--		ADD CONSTRAINT FK_Clientes_listasprecio
--		FOREIGN KEY (idlistaprecios) REFERENCES ListasPrecios(idlistaprecios)
--go


--alter table  Clientes
--		ADD CONSTRAINT FK_Clientes_IBCondiciones_PorDefecto
--		FOREIGN KEY (idibcondicionpordefecto) REFERENCES IBCondiciones(idibcondicion)
--go



select * from Empleados
select idusuarioingreso from clientes


alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Empleados_Ingreso
		FOREIGN KEY (idusuarioingreso) REFERENCES Empleados(idempleado)
go

alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Empleados_Modifico
		FOREIGN KEY (idusuariomodifico) REFERENCES Empleados(idempleado)
go


exec sp_help 'Clientes'

alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Localidades
		FOREIGN KEY (IdLocalidad) REFERENCES Localidades(IdLocalidad)
go

alter table  Clientes
		ADD CONSTRAINT FK_Clientes_LocalidadEntrega
		FOREIGN KEY (IdLocalidadEntrega) REFERENCES Localidades(IdLocalidad)
go


alter table  Clientes drop   CONSTRAINT FK_Clientes_Provincia
go

--alter table  Clientes
--		ADD CONSTRAINT FK_Clientes_Provincia
--		FOREIGN KEY (IdProvincia) REFERENCES Provincias(IdProvincia)
--go



alter table  Clientes
		ADD CONSTRAINT FK_Clientes_ProvinciaEntrega
		FOREIGN KEY (IdProvinciaEntrega) REFERENCES Provincias(IdProvincia)
go



alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Pais
		FOREIGN KEY (IdPais) REFERENCES Paises(IdPais)
go



exec sp_help 'Clientes'


alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Vendedor
		FOREIGN KEY (Vendedor1) REFERENCES vendedores(IdVendedor)
go


alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Cobrador
		FOREIGN KEY (Cobrador) REFERENCES vendedores(IdVendedor)
go



--ésta quizas ya estaba
alter table  Clientes
		ADD CONSTRAINT FK_Clientes_DescripcionIVA
		FOREIGN KEY (IdCondicionIVA) REFERENCES DescripcionIVA(IdCondicionIVA)
go






alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Estados
		FOREIGN KEY (IdEstado) REFERENCES [estados proveedores](IdEstado)
go




 exec sp_helptext 'Clientes_TX_Detallado'


alter table  Clientes
		ADD CONSTRAINT FK_Clientes_Cuentas
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go
alter table  Clientes
		ADD CONSTRAINT FK_Clientes_CuentasMonedaExt
		FOREIGN KEY (IdCuentaMonedaExt) REFERENCES Cuentas(IdCuenta)
go






exec sp_help 'Clientes'


alter table  Clientes drop   CONSTRAINT FK_Clientes_CondicionIIBB

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Corrector de candidata a fk
---------------------------------------------------------------------------------------
select distinct IBCondiciones.idibcondicion,clientes.IdIBcondicionpordefecto
from clientes
left join IBCondiciones on IBCondiciones.idibcondicion=clientes.IdIBcondicionpordefecto
where IBCondiciones.idibcondicion is null
	and not clientes.IdIBcondicionpordefecto is null
--------------------------------------------------------------------------------------
update clientes
set clientes.IdIBcondicionpordefecto=null  
from clientes
left join IBCondiciones on IBCondiciones.idibcondicion=clientes.IdIBcondicionpordefecto
where IBCondiciones.idibcondicion is null
	and not clientes.IdIBcondicionpordefecto is null
go	
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------



alter table  Clientes
		ADD CONSTRAINT FK_Clientes_CatIIBB
		FOREIGN KEY (IdIBcondicionpordefecto) REFERENCES IBCondiciones(IdIBCondicion)
go


alter table  Clientes
		ADD CONSTRAINT FK_Clientes_CatIIBB2
		FOREIGN KEY (IdIBcondicionpordefecto2) REFERENCES IBCondiciones(IdIBCondicion)
go


alter table  Clientes
		ADD CONSTRAINT FK_Clientes_CatIIBB3
		FOREIGN KEY (IdIBcondicionpordefecto3) REFERENCES IBCondiciones(IdIBCondicion)
go


exec sp_help 'DetalleClientes'


alter table  DetalleClientes
		ADD CONSTRAINT FK_DetalleClientes_Clientes
		FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
go

alter table  DetalleClientesLugaresEntrega
		ADD CONSTRAINT FK_DetalleLugaresEntrega_Clientes
		FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
go



alter table  DetalleClientesLugaresEntrega
		ADD PRIMARY KEY (IdDetalleClienteLugarEntrega) 
go




exec sp_help 'DetalleOrdenesCompra'

exec sp_help 'DetalleRemitos'

alter table  DetalleOrdenesCompra
		ADD CONSTRAINT FK_DetalleOrdenesCompra_OrdenesCompra
		FOREIGN KEY (IdOrdenCompra) REFERENCES OrdenesCompra(IdOrdenCompra)
go


alter table  DetalleRemitos
		ADD CONSTRAINT FK_DetalleRemitos_Remitos
		FOREIGN KEY (IdRemito) REFERENCES Remitos(IdRemito)
go


exec sp_help 'DetalleRemitos'

alter table  DetalleOrdenesCompra
		ADD CONSTRAINT FK_DetalleOrdenesCompra_Unidades
		FOREIGN KEY (IdUnidad) REFERENCES Unidades(IdUnidad)
go

----------------------------------
update DetalleOrdenesCompra
set DetalleOrdenesCompra.IdUnidad=null  
from DetalleOrdenesCompra
left join Unidades on Unidades.IdUnidad=DetalleOrdenesCompra.IdUnidad
where Unidades.IdUnidad is null
	and not DetalleOrdenesCompra.IdUnidad is null
go	



exec sp_help 'DetalleFacturas'

alter table  DetalleFacturas
		ADD CONSTRAINT FK_DetalleFacturas_Unidades
		FOREIGN KEY (IdUnidad) REFERENCES Unidades(IdUnidad)
go




--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--agregar fks para el facturas_TT

--alter table  Facturas
--		ADD CONSTRAINT FK_DetalleFacturas_Unidades
--		FOREIGN KEY (IdUnidad) REFERENCES Unidades(IdUnidad)
--go

sp_help 'DetalleFacturasOrdenesCompra'
update T1
set T1.IdDetalleFactura=null  
--select T1.IdDetalleFactura,*
from DetalleFacturasOrdenesCompra T1
left join DetalleFacturas T2 on T1.IdDetalleFactura=T2.IdDetalleFactura
where T2.IdDetalleFactura is null
	and not T1.IdDetalleFactura is null
go	


alter table  DetalleFacturasOrdenesCompra
		ADD CONSTRAINT FK_DetalleFacturasOrdenesCompra_DetalleFacturas
		FOREIGN KEY (IdDetalleFactura) REFERENCES DetalleFacturas(IdDetalleFactura)
go


alter table  DetalleFacturasRemitos
		ADD CONSTRAINT FK_DetalleFacturasRemitos_DetalleFacturas
		FOREIGN KEY (IdDetalleFactura) REFERENCES DetalleFacturas(IdDetalleFactura)
go


----------------------------------
update DetalleFacturasRemitos
set DetalleFacturasRemitos.IdDetalleFactura=null  
--select *
from DetalleFacturasRemitos
left join DetalleFacturas on DetalleFacturas.IdDetalleFactura=DetalleFacturasRemitos.IdDetalleFactura
where DetalleFacturas.IdDetalleFactura is null
	and not DetalleFacturasRemitos.IdDetalleFactura is null
go	




---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
alter table  Facturas
		ADD CONSTRAINT FK_Facturas_Vendedor
		FOREIGN KEY (IdVendedor) REFERENCES Vendedores(IdVendedor)
go


----------------------------------
update T1
set T1.IdVendedor=null  
--select T1.IdVendedor,*
from Facturas T1
left join Vendedores T2 on T1.IdVendedor=T2.IdVendedor
where T2.IdVendedor is null
	and not T1.IdVendedor is null
go	


sp_help 'Facturas'


alter table  Facturas
		ADD CONSTRAINT FK_Facturas_Obra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go

update T1
set T1.IdObra=null  
--select T1.IdObra,*
from Facturas T1
left join Obras T2 on T1.IdObra=T2.IdObra
where T2.IdObra is null
	and not T1.IdObra is null
go	


alter table  Facturas
		ADD CONSTRAINT FK_Facturas_Provincia
		FOREIGN KEY (IdProvinciaDestino) REFERENCES Provincias(IdProvincia)
go

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------


sp_help 'articulos'
--sp_help 'Ubicaciones'

alter table  Articulos
		ADD CONSTRAINT FK_Articulos_Ubicacion
		FOREIGN KEY (IdUbicacionStandar) REFERENCES Ubicaciones(IdUbicacion)
go


---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

sp_help 'DetalleArticulosUnidades'

alter table  DetalleArticulosUnidades
		ADD CONSTRAINT FK_DetalleArticulosUnidades_Unidades
		FOREIGN KEY (IdUnidad) REFERENCES Unidades(IdUnidad)
go





sp_help 'DetalleArticulosUnidades'
 go


sp_help 'articulos'
go

alter table  DetalleArticulosUnidades
		ADD CONSTRAINT FK_DetalleArticulosUnidades_Articulos
		FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
go

alter table  DetalleArticulosDocumentos
		ADD CONSTRAINT FK_DetalleArticulosDocumentos_Articulos
		FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
go

alter table  DetalleArticulosImagenes
		ADD CONSTRAINT FK_DetalleArticulosImagenes_Articulos
		FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
go



---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------



sp_help 'empleados' 
go
sp_help 'empleadosaccesos'
go

alter table  empleadosaccesos
		ADD CONSTRAINT FK_EmpleadosAccesos_Empleados
		FOREIGN KEY (IdEmpleado) REFERENCES Empleados(IdEmpleado)
go

update T1
set T1.IdEmpleado=null  
--select T1.IdEmpleado,*
from empleadosaccesos T1
left join Empleados T2 on T1.IdEmpleado=T2.IdEmpleado
where T2.IdEmpleado is null
	and not T1.IdEmpleado is null
go	



---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

--alter table DetalleRecibos  drop constraint  FK_DetalleRecibos_Recibos

alter table DetalleRecibos  
		ADD CONSTRAINT FK_DetalleRecibos_Recibos
		FOREIGN KEY (IdRecibo) REFERENCES Recibos(IdRecibo)
go


alter table DetalleRecibosCuentas  
		ADD CONSTRAINT FK_DetalleRecibosCuentas_Recibos
		FOREIGN KEY (IdRecibo) REFERENCES Recibos(IdRecibo)
go

alter table DetalleRecibosRubrosContables  
		ADD CONSTRAINT FK_DetalleRecibosRubrosContables_Recibos
		FOREIGN KEY (IdRecibo) REFERENCES Recibos(IdRecibo)
go

alter table DetalleRecibosValores  
		ADD CONSTRAINT FK_DetalleRecibosValores_Recibos
		FOREIGN KEY (IdRecibo) REFERENCES Recibos(IdRecibo)
go



update T1
set T1.IdCliente=null  
--select T1.IdEmpleado,*
from Recibos T1
left join Clientes T2 on T1.IdCliente=T2.IdCliente
where T2.IdCliente is null
	and not T1.IdCliente is null
go	


alter table Recibos
		ADD CONSTRAINT FK_Recibos_Clientes
		FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
go



sp_help 'Facturas'
go






sp_help 'DetallePedidos' 
go

alter table DetallePedidos
		ADD CONSTRAINT FK_DetallePedidos_DetalleRequerimientos
		FOREIGN KEY (IdDetalleRequerimiento) REFERENCES DetalleRequerimientos(IdDetalleRequerimiento)
go

update T1
set T1.IdDetalleRequerimiento=null   
--select T1.IdDetalleRequerimiento,*
from DetallePedidos T1		--tabla apuntadora (tiene el FK)
left join DetalleRequerimientos T2 on T1.IdDetalleRequerimiento=T2.IdDetalleRequerimiento   --tabla apuntada (tiene el PK)
where T2.IdDetalleRequerimiento is null
	and not T1.IdDetalleRequerimiento is null
go	



alter table DetallePedidos
		ADD CONSTRAINT FK_DetallePedidos_DetalleComparativa
		FOREIGN KEY (IdDetalleComparativa) REFERENCES DetalleComparativas(IdDetalleComparativa)
go









---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

 
alter table _TempAutorizaciones add
		IdTempAutorizacion int IDENTITY (1, 1) PRIMARY KEY
go




--sp_help 'DetalleFacturasRemitos'

-- LEFT OUTER JOIN DetalleFacturasRemitos ON Det.IdDetalleFactura = DetalleFacturasRemitos.IdDetalleFactura  
-- LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura  
-- LEFT OUTER JOIN DetalleRemitos ON DetalleFacturasRemitos.IdDetalleRemito = DetalleRemitos.IdDetalleRemito  
-- LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito  

--  LEFT OUTER JOIN DetalleFacturasOrdenesCompra ON Det.IdDetalleFactura = DetalleFacturasOrdenesCompra.IdDetalleFactura  
-- LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura  
-- LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleFacturasOrdenesCompra.IdDetalleOrdenCompra = DetalleOrdenesCompra.IdDetalleOrdenCompra  
-- LEFT OUTER JOIN OrdenesCompra ON DetalleOrdenesCompra.IdOrdenCompra = OrdenesCompra.IdOrdenCompra  


--LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente  
--LEFT OUTER JOIN DescripcionIva ON IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva   
--LEFT OUTER JOIN Vendedores ON Clientes.Vendedor1 = Vendedores.IdVendedor  
--LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda  
--LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra  
--LEFT OUTER JOIN Provincias ON Facturas.IdProvinciaDestino = Provincias.IdProvincia  
--LEFT OUTER JOIN Empleados ON Facturas.IdUsuarioIngreso = Empleados.IdEmpleado  
--LEFT OUTER JOIN #Auxiliar1 ON Facturas.IdFactura=#Auxiliar1.IdFactura  
--LEFT OUTER JOIN #Auxiliar3 ON Facturas.IdFactura=#Auxiliar3.IdFactura  
--WHERE IsNull(FacturaContado,'NO')='NO'  
--ORDER BY Facturas.FechaFactura,Facturas.NumeroFactura  


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--update T1
--set T1.IdMoneda=null  
----select T1.IdMoneda,*
--from DetallePedidos T1
--left join Empleados T2 on T1.IdComprador=T2.IdEmpleado
--where T2.IdEmpleado is null
--	and not T1.IdComprador is null
--go	



sp_help 'Pedidos'
go
sp_helpconstraint 'Pedidos'
go

alter table  Pedidos
		ADD CONSTRAINT FK_Pedidos_EmpleadoComprador
		FOREIGN KEY (IdComprador) REFERENCES Empleados(IdEmpleado)
go

alter table  Pedidos
		ADD CONSTRAINT FK_Pedidos_EmpleadoAprobo
		FOREIGN KEY (Aprobo) REFERENCES Empleados(IdEmpleado)
go



--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


sp_help 'Proveedores'

alter table  Proveedores
		ADD CONSTRAINT FK_Proveedores_DescripcionIva
		FOREIGN KEY (IdCodigoIVA) REFERENCES DescripcionIva(IdCodigoIVA)
go



alter table  DetallePedidos
		ADD CONSTRAINT FK_DetallePedidos_ControlCalidad
		FOREIGN KEY (IdControlCalidad) REFERENCES ControlesCalidad(IdControlCalidad)
go


sp_help 'DetallePedidos'
go


sp_help 'DetalleComprobantesProveedores'
go

alter table  DetalleComprobantesProveedores
		ADD CONSTRAINT FK_DetalleComprobantesProveedores
		FOREIGN KEY (IdComprobanteProveedor) REFERENCES ComprobantesProveedores(IdComprobanteProveedor)
go






-------------------------------------------------

alter table  Comparativas
		ADD PRIMARY KEY (IdComparativa)  IDENTITY(1,1)???
go  

sp_help 'Comparativas'
alter table  DetalleComparativas
		ADD PRIMARY KEY (IdDetalleComparativa)   IDENTITY(1,1)???
go





sp_help 'Comparativas'
sp_help 'Pedidos'


UPDATE DetalleComparativas SET IdComparativa=0 WHERE IdComparativa IS NULL
--ALTER TABLE DetalleComparativas ALTER COLUMN IdComparativa int NULL --NOT NULL


alter table DetalleComparativas
		ADD CONSTRAINT FK_DetalleComparativas
		FOREIGN KEY (IdComparativa) REFERENCES Comparativas(IdComparativa)

go




update T1
set T1.IdArticulo=null  
--select T1.IdMoneda,*
from DetalleComparativas T1
left join Articulos T2 on T1.IdArticulo=T2.IdArticulo
where T2.IdArticulo is null
	and not T1.IdArticulo is null
go	


sp_help 'DetalleComparativas'
alter table  DetalleComparativas
		ADD CONSTRAINT FK_DetalleComparativas_Articulo
		FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
go



update T1
set T1.IdUnidad=null  
--select T1.IdMoneda,*
from DetalleComparativas T1
left join Unidades T2 on T1.IdUnidad=T2.IdUnidad
where T2.IdUnidad is null
	and not T1.IdUnidad is null
go	

alter table  DetalleComparativas
		ADD CONSTRAINT FK_DetalleComparativas_Unidad
		FOREIGN KEY (IdUnidad) REFERENCES Unidades(IdUnidad)
go


alter table DetalleComparativas add
		IdTempAutorizacion int IDENTITY (1, 1) PRIMARY KEY
go



sp_help 'ComprobantesProveedores'
sp_help 'DetalleComprobantesProveedores'

alter table  ComprobantesProveedores
		ADD CONSTRAINT FK_ComprobantesProveedores_Proveedor
		FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
go


alter table  DetalleComprobantesProveedores
		ADD CONSTRAINT FK_DetalleComprobantesProveedores_Cuenta
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go


sp_helptext 'DetOrdenesPago_TXOrdenPago'
/*
select  * from DetalleOrdenesPago
select  * from DetalleOrdenesPagoValores
select  * from DetalleOrdenesPagoCuentas
select  * from DetalleOrdenesPagoImpuestos
exec DetOrdenesPago_TX_PorIdOrdenPago 20
exec  DetOrdenesPago_TXOrdenPago 20

*/


update T1
set T1.IdProveedor=null  
--select T1.IdProveedor,*
from OrdenesPago T1
left join Proveedores T2 on T1.IdProveedor=T2.IdProveedor
where T2.IdProveedor is null
	and not T1.IdProveedor is null
go	


sp_help 'OrdenesPago'
alter table   OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_Proveedor
		FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
go


sp_help 'DetalleOrdenesPago'


exec  DetOrdenesPago_TXOrdenPago 20
select  * from DetalleOrdenesPago
--LEFT OUTER JOIN CuentasCorrientesAcreedores cc ON cc.IdCtaCte=DetOP.IdImputacion  
alter table   DetalleOrdenesPago
		ADD CONSTRAINT FK_DetalleOrdenesPago_Imputacion
		FOREIGN KEY (IdImputacion) REFERENCES CuentasCorrientesAcreedores(IdCtaCte)
go



/*
select  * from DetalleOrdenesPagoValores
select * from valores
exec  DetOrdenesPagoValores_TXOrdenPago 20
*/
sp_help 'DetalleOrdenesPago'
sp_helptext 'DetOrdenesPagoValores_TXOrdenPago'
--LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOP.IdTipoValor  
--LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOP.IdDetalleOrdenPagoValores  
alter table   DetalleOrdenesPagoValores
		ADD CONSTRAINT FK_DetalleOrdenesPagoValores_Imputacion
		FOREIGN KEY (IdDetalleOrdenPagoValores) REFERENCES Valores(IdDetalleOrdenPagoValores)
go

alter table   DetalleOrdenesPagoValores
		ADD CONSTRAINT FK_DetalleOrdenesPagoValores_IdTipoValor
		FOREIGN KEY (IdTipoValor) REFERENCES TiposComprobante(IdTipoComprobante)
go







alter table  ComprobantesProveedores
		ADD CONSTRAINT FK_ComprobantesProveedores_Cuenta
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go


sp_help 'Cuentas'
alter table  Cuentas
		ADD CONSTRAINT FK_Cuentas_TipoCuentaGrupos
		FOREIGN KEY (IdTipoCuentaGrupo) REFERENCES TiposCuentaGrupos(IdTipoCuentaGrupo)
go


alter table  Cuentas
		ADD CONSTRAINT FK_Cuentas_CuentasGastos
		FOREIGN KEY (IdCuentaGasto) REFERENCES CuentasGastos(IdCuentaGasto)
go


update T1
set T1.IdCuentaGasto=null  
--select T1.IdCuentaGasto,*
from Cuentas T1
left join CuentasGastos T2 on T1.IdCuentaGasto=T2.IdCuentaGasto
where T2.IdCuentaGasto is null
	and not T1.IdCuentaGasto is null
go	







alter table  ComprobantesProveedores
		ADD CONSTRAINT FK_ComprobantesProveedores_Obra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go



update T1
set T1.IdObra=null  
--select T1.IdObra,*
from ComprobantesProveedores T1
left join Obras T2 on T1.IdObra=T2.IdObra
where T2.IdObra is null
	and not T1.IdObra is null
go	



update T1
set T1.IdDetalleRequerimiento=null   
--select T1.IdDetalleRequerimiento,*
from DetallePedidos T1		--tabla apuntadora (tiene el FK)
left join DetalleRequerimientos T2 on T1.IdDetalleRequerimiento=T2.IdDetalleRequerimiento   --tabla apuntada (tiene el PK)
where T2.IdDetalleRequerimiento is null
	and not T1.IdDetalleRequerimiento is null
go	





sp_help 'ComprobantesProveedores'

--ALTER TABLE DescripcionIva ALTER COLUMN IdCodigoIVA int --hay que hacerlo mediante el ManagmentStudio por todas las referencias que hay que modificar
ALTER TABLE NotasDebito ALTER COLUMN IdCodigoIVA int --hay que hacerlo mediante el ManagmentStudio por todas las referencias que hay que modificar
ALTER TABLE NotasCredito ALTER COLUMN IdCodigoIVA int --hay que hacerlo mediante el ManagmentStudio por todas las referencias que hay que modificar



alter table  ComprobantesProveedores
		ADD CONSTRAINT FK_ComprobantesProveedores_DescripcionIva
		FOREIGN KEY (IdCodigoIVA) REFERENCES DescripcionIva(IdCodigoIVA)
go

update T1
set T1.IdCodigoIVA=null   
--select T1.IdCodigoIVA,*
from ComprobantesProveedores T1		--tabla apuntadora (tiene el FK)
left join DescripcionIva T2 on T1.IdCodigoIVA=T2.IdCodigoIVA   --tabla apuntada (tiene el PK)
where T2.IdCodigoIVA is null
	and not T1.IdCodigoIVA is null
go	




alter table  ComprobantesProveedores
		ADD CONSTRAINT FK_ComprobantesProveedores_CuentaOtros
		FOREIGN KEY (IdCuentaOtros) REFERENCES Cuentas(IdCuenta)
go







--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--agregar los de remitos y ordenescompra




alter table  Remitos
		ADD CONSTRAINT FK_Remitos_Obras
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go

alter table  Remitos
		ADD CONSTRAINT FK_Remitos_Transportistas
		FOREIGN KEY (IdTransportista) REFERENCES Transportistas(IdTransportista)
go

alter table  Remitos
		ADD CONSTRAINT FK_Remitos_Empleados
		FOREIGN KEY (IdAutorizaAnulacion) REFERENCES Empleados(IdEmpleado)
go




alter table  Remitos
		ADD CONSTRAINT FK_Remitos_Condiciones_Compras
		FOREIGN KEY (IdCondicionVenta) REFERENCES  [Condiciones Compra](IdCondicionCompra)
go


alter table  Remitos
		ADD CONSTRAINT FK_Remitos_ListasPrecios
		FOREIGN KEY (IdListaPrecios) REFERENCES ListasPrecios(IdListaPrecios)
go
--                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
--                        from d in db.Transportistas.Where(v => v.IdTransportista == a.IdTransportista).DefaultIfEmpty()
--                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
--                        from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
--                        from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()



alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_Obras
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go


alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_Condiciones_Compras
		FOREIGN KEY (IdCondicionVenta) REFERENCES  [Condiciones Compra](IdCondicionCompra)
go



alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_ListasPrecios
		FOREIGN KEY (IdListaPrecios) REFERENCES ListasPrecios(IdListaPrecios)
go


alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_IdUsuarioIngreso
		FOREIGN KEY (IdUsuarioIngreso) REFERENCES Empleados(IdEmpleado)
go


alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_IdUsuarioModifico
		FOREIGN KEY (IdUsuarioModifico) REFERENCES Empleados(IdEmpleado)
go


alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_IdUsuarioAnulacion
		FOREIGN KEY (IdUsuarioAnulacion) REFERENCES Empleados(IdEmpleado)
go


alter table  OrdenesCompra
		ADD CONSTRAINT FK_OrdenesCompra_Aprobo
		FOREIGN KEY (Aprobo) REFERENCES Empleados(IdEmpleado)
go
--                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
--                        from d in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
--                        from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
--                        from f in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioAnulacion).DefaultIfEmpty()
--                        from g in db.Empleados.Where(v => v.IdEmpleado == a.Aprobo).DefaultIfEmpty()
--                        from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
--                        from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()

--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////


alter table  Articulos
		ADD CONSTRAINT FK_Articulos_IdModelo
		FOREIGN KEY (IdModelo) REFERENCES Modelos(IdModelo)
go



alter table  Articulos
		ADD CONSTRAINT FK_Articulos_IdMarca
		FOREIGN KEY (IdMarca) REFERENCES Marcas(IdMarca)
go



--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////










						


alter table  Facturas
		ADD CONSTRAINT FK_Facturas_DescripcionIva
		FOREIGN KEY (IdCodigoIva) REFERENCES  DescripcionIva(IdCodigoIva)
go





alter table  Facturas
		ADD CONSTRAINT FK_Facturas_ListasPrecios
		FOREIGN KEY (IdListaPrecios) REFERENCES ListasPrecios(IdListaPrecios)
go




                     

alter table  Facturas
		ADD CONSTRAINT FK_Facturas_IdUsuarioIngreso
		FOREIGN KEY (IdUsuarioIngreso) REFERENCES Empleados(IdEmpleado)
go


alter table  Facturas
		ADD CONSTRAINT FK_Facturas_IdAutorizaAnulacion
		FOREIGN KEY (IdAutorizaAnulacion) REFERENCES Empleados(IdEmpleado)
go




alter table  Facturas
		ADD CONSTRAINT FK_Facturas_IdDeposito
		FOREIGN KEY (IdDeposito) REFERENCES Depositos(IdDeposito)
go



alter table  Facturas
		ADD CONSTRAINT FK_Facturas_Condiciones_Compras
		FOREIGN KEY (IdCondicionVenta) REFERENCES  [Condiciones Compra](IdCondicionCompra)
go


          

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdUsuarioIngreso
		FOREIGN KEY (IdUsuarioIngreso) REFERENCES Empleados(IdEmpleado)
go

alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdUsuarioModifico
		FOREIGN KEY (IdUsuarioModifico) REFERENCES Empleados(IdEmpleado)
go



alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdObra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go



alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdVendedor
		FOREIGN KEY (IdVendedor) REFERENCES Vendedores(IdVendedor)
go


alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdCobrador
		FOREIGN KEY (IdCobrador) REFERENCES Vendedores(IdVendedor)
go



alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdMoneda
		FOREIGN KEY (IdMoneda) REFERENCES Monedas(IdMoneda)
go


alter table  Recibos
		ADD CONSTRAINT FK_Recibos_IdCuenta
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go






--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////



                        


alter table  NotasCredito
		ADD CONSTRAINT FK_NotasCredito_IdCodigoIva
		FOREIGN KEY (IdCodigoIva) REFERENCES DescripcionIva(IdCodigoIva)
go



alter table  NotasCredito
		ADD CONSTRAINT FK_NotasCredito_IdObra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go


alter table  NotasCredito
		ADD CONSTRAINT FK_NotasCredito_IdVendedor
		FOREIGN KEY (IdVendedor) REFERENCES Vendedores(IdVendedor)
go



alter table  NotasCredito
		ADD CONSTRAINT FK_NotasCredito_IdUsuarioIngreso
		FOREIGN KEY (IdUsuarioIngreso) REFERENCES Empleados(IdEmpleado)
go

alter table  NotasCredito
		ADD CONSTRAINT FK_NotasCredito_IdUsuarioAnulacion
		FOREIGN KEY (IdUsuarioAnulacion) REFERENCES Empleados(IdEmpleado)
go

alter table  NotasCredito
		ADD CONSTRAINT FK_NotasCredito_IdProvinciaDestino
		FOREIGN KEY (IdProvinciaDestino) REFERENCES Provincias(IdProvincia)
go

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////


                        


alter table  NotasDebito
		ADD CONSTRAINT FK_NotasDebito_IdCodigoIva
		FOREIGN KEY (IdCodigoIva) REFERENCES DescripcionIva(IdCodigoIva)
go



alter table  NotasDebito
		ADD CONSTRAINT FK_NotasDebito_IdObra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go


                      

alter table  NotasDebito
		ADD CONSTRAINT FK_NotasDebito_IdVendedor
		FOREIGN KEY (IdVendedor) REFERENCES Vendedores(IdVendedor)
go



alter table  NotasDebito
		ADD CONSTRAINT FK_NotasDebito_IdUsuarioIngreso
		FOREIGN KEY (IdUsuarioIngreso) REFERENCES Empleados(IdEmpleado)
go

alter table  NotasDebito
		ADD CONSTRAINT FK_NotasDebito_IdUsuarioAnulacion
		FOREIGN KEY (IdUsuarioAnulacion) REFERENCES Empleados(IdEmpleado)
go



alter table  NotasDebito
		ADD CONSTRAINT FK_NotasDebito_IdProvinciaDestino
		FOREIGN KEY (IdProvinciaDestino) REFERENCES Provincias(IdProvincia)
go
                        




--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////


                        
alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdMoneda
		FOREIGN KEY (IdMoneda) REFERENCES Monedas(IdMoneda)
go
                      

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdConcepto
		FOREIGN KEY (IdConcepto) REFERENCES Conceptos(IdConcepto)
go

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdConcepto2
		FOREIGN KEY (IdConcepto2) REFERENCES Conceptos(IdConcepto)
go



                    

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdObra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go


alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdEmpleadoFF
		FOREIGN KEY (IdEmpleadoFF) REFERENCES Empleados(IdEmpleado)
go

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdUsuarioIngreso
		FOREIGN KEY (IdUsuarioIngreso) REFERENCES Empleados(IdEmpleado)
go


 

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdUsuarioModifico
		FOREIGN KEY (IdUsuarioModifico) REFERENCES Empleados(IdEmpleado)
go

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdUsuarioAnulo
		FOREIGN KEY (IdUsuarioAnulo) REFERENCES Empleados(IdEmpleado)
go

alter table  OrdenesPago
		ADD CONSTRAINT FK_OrdenesPago_IdOPComplementariaFF
		FOREIGN KEY (IdOPComplementariaFF) REFERENCES OrdenesPago(IdOrdenPago)
go



--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////

alter table  RubrosContables
		ADD CONSTRAINT FK_RubrosContables_IdObra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go

alter table  RubrosContables
		ADD CONSTRAINT FK_RubrosContables_IdTipoRubroFinancieroGrupo
		FOREIGN KEY (IdTipoRubroFinancieroGrupo) REFERENCES TiposRubrosFinancierosGrupos(IdTipoRubroFinancieroGrupo)
go


alter table  RubrosContables
		ADD CONSTRAINT FK_RubrosContables_IdCuenta
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////

alter table  Cuentas
		ADD CONSTRAINT FK_Cuentas_IdTipoCuentaGrupo
		FOREIGN KEY (IdTipoCuentaGrupo) REFERENCES TiposCuentaGrupos(IdTipoCuentaGrupo)
go

alter table  Cuentas
		ADD CONSTRAINT FK_Cuentas_IdTipoCuenta
		FOREIGN KEY (IdTipoCuenta) REFERENCES TiposCuenta(IdTipoCuenta)
go




alter table  Cuentas
		ADD CONSTRAINT FK_Cuentas_IdRubroContable
		FOREIGN KEY (IdRubroContable) REFERENCES RubrosContables(IdRubroContable)
go

alter table  Cuentas
		ADD CONSTRAINT FK_Cuentas_IdRubroFinanciero
		FOREIGN KEY (IdRubroFinanciero) REFERENCES RubrosContables(IdRubroContable)
go




--/////////////////////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////



alter table  DetalleAsientos
		ADD CONSTRAINT FK_DetalleAsientos_IdCuenta
		FOREIGN KEY (IdCuenta) REFERENCES Cuentas(IdCuenta)
go



alter table  DetalleAsientos
		ADD CONSTRAINT FK_DetalleAsientos_IdObra
		FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
go

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Corrector de candidata a fk
---------------------------------------------------------------------------------------
select distinct Obras.IdObra,DetalleAsientos.IdObra
from DetalleAsientos
left join Obras on DetalleAsientos.IdObra=Obras.IdObra
where Obras.IdObra is null
	and not DetalleAsientos.IdObra is null
--------------------------------------------------------------------------------------
update DetalleAsientos
set DetalleAsientos.IdObra=null  
from DetalleAsientos
left join Obras on Obras.IdObra=DetalleAsientos.IdObra
where Obras.IdObra is null
	and not DetalleAsientos.IdObra is null
go	
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


alter table  DetalleAsientos
		ADD CONSTRAINT FK_DetalleAsientos_IdMoneda
		FOREIGN KEY (IdMoneda) REFERENCES Monedas(IdMoneda)
go

alter table  DetalleAsientos
		ADD CONSTRAINT FK_DetalleAsientos_IdMonedaDestino
		FOREIGN KEY (IdMonedaDestino) REFERENCES Monedas(IdMoneda)
go


alter table  DetalleEventosDelSistema
		ADD CONSTRAINT FK_DetalleEventosDelSistema_IdEventoDelSistema
		FOREIGN KEY (IdEventoDelSistema) REFERENCES EventosDelSistema(IdEventoDelSistema)
go




