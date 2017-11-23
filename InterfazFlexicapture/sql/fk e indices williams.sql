--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--fks  (mas abajo estan los indices)
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

alter table CartasDePorte add
		 IdCorredor2 int null references Vendedores(IdVendedor)
go

create table CartasDePorteReglasDeFacturacion 
			IdCliente int REFERENCES Clientes(idCliente)






alter table  cartasdeporte
		ADD FOREIGN KEY (Vendedor) REFERENCES Clientes(IdCliente)
go




alter table CartasDePorte ADD
	 IdClienteAuxiliar int null references Clientes(IdCliente)
go

alter table WilliamsMailFiltros ADD
	IdClienteAuxiliar int null references Clientes(IdCliente) 
GO

alter table [WilliamsMailFiltrosCola] ADD
	 IdClienteAuxiliar int null references Clientes(IdCliente) 
GO



create table CartasDePorteMailClusters
(	
	IdCartaDePorte  int  REFERENCES CartasDePorte(IdCartaDePorte)
)







--agregar tambien fk en destinos????

create table Partidos (
	IdProvincia int null references Provincias(IdProvincia),
	 
)
go



alter table Localidades ADD
	 IdPartido int null references Partidos(IdPartido)
go


alter table WilliamsDestinos add
	IdProvincia  int null references Provincias(IdProvincia),
	IdLocalidad int null references Localidades(IdLocalidad)
go



alter table CartasDePorte ADD
	 IdDetalleFactura int null references DetalleFacturas(IdDetalleFactura)
go



alter table CartasPorteMovimientos ADD
	 IdDetalleFactura int null references DetalleFacturas(IdDetalleFactura)
go



alter table CartasDePorte ADD
	 IdClienteEntregador int null references Clientes(IdCliente)
go






--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--indices
--indices
--indices
--indices
--indices
--indices
--indices
--indices
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		
alter table partidos	constraint U_Partidos_Unicidad unique NONCLUSTERED (Nombre)


alter table cartasdeporte ADD
	constraint U_NumeroCartaRestringido
	 unique NONCLUSTERED (NumeroCartaDePorte,SubnumeroVagon,SubnumeroDeFacturacion)
	--no se incluye el 'anulada'. si se 'desanula', basta con poner fechaanulacion en null
	--MODIFICACION: ni siquiera dejé la fecha de anulacion. ahora deje sola la unicidad de las 3: (NCDP-subnumero-subfacturacion)
	--No entiendo. Cómo hacés con las anuladas entonces? "anulada" puede quedar afuera, pero fechaanulacion tiene que estar!
	--una opcion sería poner subnumerovagon muy negativos, 

go



alter table cartasdeporte ADD
	constraint U_NumeroCartaRestringido2 
	unique NONCLUSTERED (NumeroCartaDePorte,SubnumeroVagon,SubnumeroDeFacturacion,FechaAnulacion)
	--no se incluye el 'anulada'. si se 'desanula', basta con poner fechaanulacion en null
	--MODIFICACION: ni siquiera dejé la fecha de anulacion. ahora deje sola la unicidad de las 3: (NCDP-subnumero-subfacturacion)
	--No entiendo. Cómo hacés con las anuladas entonces? "anulada" puede quedar afuera, pero fechaanulacion tiene que estar!
	--una opcion sería poner subnumerovagon muy negativos, 

go





CREATE nonclustered INDEX IDX_Cartasdeporte_IdClienteAFacturarle on CartasDePorte(Vendedor)
	include (idcartadeporte,numerocartadeporte,cuentaorden1,cuentaorden2,corredor,entregador,procedencia,idarticulo,netofinal,destino,fechadescarga,subnumerovagon,fechaarribo,idclienteafacturarle,subnumerodefacturacion)
go

CREATE nonclustered INDEX IDX_Clientes_RazonSocial on Clientes(RazonSocial)
go

CREATE nonclustered INDEX IDX_FactAuto_IdSesion on wTempCartasPorteFacturacionAutomatica(IdSesion)
go


CREATE UNIQUE INDEX IDX_Cartasdeporte_Superbuscador
ON CartasDePorte (NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,FechaArribo,FechaIngreso,FechaAnulacion)
--eso taambien tiene que incluir el fechaanulacion
GO



--sql2000
CREATE UNIQUE INDEX IDX_Clientes_Filtro2
ON Clientes (IdCliente,RazonSocial,CUIT,Telefono,Email,FechaAlta)
GO



CREATE UNIQUE INDEX IDX_CartasDePorte_Filtro4
ON CartasDePorte(IdCartaDePorte,AgregaItemDeGastosAdministrativos)
GO




CREATE UNIQUE INDEX IDX_WilliamsMailFiltrosCola_SelectDinamico
	ON WilliamsMailFiltrosCola (IdWilliamsMailFiltroCola,UltimoResultado)
GO



--ESTE ES EL INDICE FUNDAMENTAL
CREATE UNIQUE INDEX IDX_CartasDePorte_SelectDinamico
	ON CartasDePorte 
			(IdCartaDePorte,SubnumeroDeFacturacion,Vendedor,CuentaOrden1,CuentaOrden2,Corredor,Entregador,IdArticulo,NetoProc,IdFacturaImputada,Anulada,FechaDescarga,FechaArribo,Exporta,EnumSyngentaDivision,PuntoVenta)
GO



--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL  .. no puede ser nonclustered?
--------------------------------------------------
--------------------------------------------------
--agregar destino? agregar clienteobs?
--experimental   Cannot specify more than 16 column names for statistics or index key list. 18 specified.
--CREATE UNIQUE INDEX IDX_CartasDePorte_SelectDinamico2
--	ON CartasDePorte 
--			(IdCartaDePorte,SubnumeroDeFacturacion,Vendedor,CuentaOrden1,CuentaOrden2,Corredor,Entregador,				IdArticulo,NetoProc,IdFacturaImputada,Anulada,FechaDescarga,FechaArribo				,Exporta,EnumSyngentaDivision,PuntoVenta				,Destino,IdClienteAuxiliar				)
--GO





alter table CartasDePorte ADD
	constraint U_cartasdeporte_Imputador unique NONCLUSTERED 
	(IdCartaDePorte,IdFacturaImputada)
go


drop table wGrillaPersistencia
create table wGrillaPersistencia (

	constraint U_Unicidad unique NONCLUSTERED (IdRenglon,Sesion)
)
go






CREATE INDEX IDX_Cartasdeporte_PorFecha  on cartasdeporte(FechaModificacion )
go






alter table Facturas ADD
	constraint U_Facturas_SuperBuscador unique NONCLUSTERED 
	(IdFactura,NumeroFactura,TipoABC,PuntoVenta,FechaFactura)
go



alter table Articulos ADD
	constraint U_Articulos_SuperBuscador unique NONCLUSTERED 
	(IdArticulo,Descripcion,codigo,FechaAlta)
go












CREATE INDEX IDX_idcomprobante  on log(idcomprobante )
go



--drop index IDX_cartasdeporte_AgrupadorDeTandaPeriodos on cartasdeporte
CREATE NONCLUSTERED INDEX IDX_cartasdeporte_AgrupadorDeTandaPeriodos
ON [dbo].cartasdeporte (IdCartaDePorte,AgrupadorDeTandaPeriodos)
GO

--UPDATE CartasDePorte  SET AgrupadorDeTandaPeriodos=NULL



--drop index IDX_WilliamsMailFiltrosCola_UltimoResultado on WilliamsMailFiltrosCola
CREATE NONCLUSTERED INDEX IDX_WilliamsMailFiltrosCola_UltimoResultado
ON [dbo].WilliamsMailFiltrosCola (UltimoResultado,AgrupadorDeTandaPeriodos)
GO






alter table cartasdeporte ADD
	constraint U_cartasdeporte_SuperBuscador4 unique NONCLUSTERED 
	(IdCartaDePorte,NumeroCartaDePorte,NumeroSubfijo,SubnumeroVagon,SubNumeroDeFacturacion,FechaArribo,FechaModificacion)
go



--este es el poteito. De clientes no tiene mucho sentido hacer indice 
--porque buscas con comodin tambien como PREFIJO, asi que en esa tabla no podes hacer el cambiazo de INDEX SCAN por INDEX SEEK
CREATE NONCLUSTERED INDEX IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador4
ON CartasDePorte (NumeroCartaEnTextoParaBusqueda,NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,
					FechaArribo,FechaIngreso,FechaModificacion)
GO



CREATE NONCLUSTERED INDEX IDX_Facturas_Superbuscador5
ON Facturas (IdFactura,NumeroFactura,FechaFactura)
GO









go




alter table CartasDePorteMailClusters ADD
	constraint U_CartasDePorteMailClusters unique NONCLUSTERED (IdCartaDePorte,AgrupadorDeTandaPeriodos)
go


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


create table CartasDePorteReglasDeFacturacion 
			constraint U_CartasDePorteReglasDeFacturacion unique NONCLUSTERED (IdCliente,PuntoVenta)
go



CREATE NONCLUSTERED INDEX IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador6
ON CartasDePorte (SubnumeroVagonEnTextoParaBusqueda,NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,FechaArribo,FechaIngreso,FechaModificacion)
GO



create table CartasPorteAcopios (

	constraint U_Unicidad_CartasPorteAcopios unique NONCLUSTERED (Descripcion)
)
go












CREATE NONCLUSTERED INDEX [<IDX_CartasDePorte_InformesCorregidoOptimizar>]
ON [dbo].[CartasDePorte] ([Vendedor],[Corredor],[Entregador],[IdArticulo])
INCLUDE ([IdCartaDePorte],[NumeroCartaDePorte],[IdUsuarioIngreso],[FechaIngreso],[Anulada],[IdUsuarioAnulo],
[FechaAnulacion],[Observaciones],[FechaTimeStamp],[CuentaOrden1],[CuentaOrden2],[Procedencia],[Patente],[IdStock],
[Partida],[IdUnidad],[IdUbicacion],[Cantidad],[Cupo],[NetoProc],[Calidad],[BrutoPto],[TaraPto],[NetoPto],[Acoplado],
[Humedad],[Merma],[NetoFinal],[FechaDeCarga],[FechaVencimiento],[CEE],[IdTransportista],[TransportistaCUITdesnormalizado],
[IdChofer],[ChoferCUITdesnormalizado],[CTG],[Contrato],[Destino],[Subcontr1],[Subcontr2],[Contrato1],[contrato2],[KmARecorrer],
[Tarifa],[FechaDescarga],[Hora],[NRecibo],[CalidadDe],[TaraFinal],[BrutoFinal],[Fumigada],[Secada],[Exporta],[NobleExtranos],
[NobleNegros],[NobleQuebrados],[NobleDaniados],[NobleChamico],[NobleChamico2],[NobleRevolcado],[NobleObjetables],[NobleAmohosados],
[NobleHectolitrico],[NobleCarbon],[NoblePanzaBlanca],[NoblePicados],[NobleMGrasa],[NobleAcidezGrasa],[NobleVerdes],[NobleGrado],[NobleConforme],
[NobleACamara],[Cosecha],[HumedadDesnormalizada],[Factor],[IdFacturaImputada],[PuntoVenta],[SubnumeroVagon],[TarifaFacturada],
[TarifaSubcontratista1],[TarifaSubcontratista2],[FechaArribo],[Version],[MotivoAnulacion],[NumeroSubfijo],[IdEstablecimiento],
[EnumSyngentaDivision],[Corredor2],[IdUsuarioModifico],[FechaModificacion],[FechaEmision],[EstaArchivada],[ExcluirDeSubcontratistas],
[IdTipoMovimiento],[IdClienteAFacturarle],[SubnumeroDeFacturacion],[AgregaItemDeGastosAdministrativos],[CalidadGranosQuemados],
[CalidadGranosQuemadosBonifica_o_Rebaja],[CalidadTierra],[CalidadTierraBonifica_o_Rebaja],[CalidadMermaChamico],
[CalidadMermaChamicoBonifica_o_Rebaja],[CalidadMermaZarandeo],[CalidadMermaZarandeoBonifica_o_Rebaja],[FueraDeEstandar],
[CalidadPuntaSombreada],[CobraAcarreo],[LiquidaViaje],[IdClienteAuxiliar],[CalidadDescuentoFinal],[PathImagen],[PathImagen2],
[AgrupadorDeTandaPeriodos],[ClaveEncriptada],[NumeroCartaEnTextoParaBusqueda],[IdClienteEntregador],[IdDetalleFactura],
[SojaSustentableCodCondicion],[SojaSustentableCondicion],[SojaSustentableNroEstablecimientoDeProduccion],[IdClientePagadorFlete],
[SubnumeroVagonEnTextoParaBusqueda],[IdCorredor2],[Acopio1],[Acopio2],[Acopio3],[Acopio4],[Acopio5],[AcopioFacturarleA])
GO













