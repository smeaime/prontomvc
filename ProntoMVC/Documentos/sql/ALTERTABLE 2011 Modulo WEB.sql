
ALTER TABLE  WilliamsMailFiltros  ADD
	 PuntoVenta int null
GO

ALTER TABLE  Clientes ADD
	[DireccionDeCorreos]        VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdLocalidadDeCorreos]      INT             NULL,
	[IdProvinciaDeCorreos]      INT             NULL,
	[CodigoPostalDeCorreos]		VARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ObservacionesDeCorreos]	VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
 GO


 
alter table cartasdeporte ADD
	NumeroSubfijo				INT				NULL
GO

alter table cartasdeporte ADD
	IdEstablecimiento			INT				NULL
GO

alter table cartasdeporte ADD
	EnumSyngentaDivision	VARCHAR (10)			NULL
GO
	

alter table ExcelImportador ADD
	EntregadorFiltrarPorWilliams	VARCHAR (50)	NULL
GO






ALTER TABLE  WilliamsMailFiltros  ADD
	 QueContenga VARCHAR(100) NULL
GO


alter table cartasdeporte ADD
	IdUsuarioModifico int NULL,
	FechaModificacion datetime NULL
go



--ALTER table customer change Address Addr char(50)

sp_RENAME 'cartasdeporte.[ChoferCUIT]' , 'ChoferCUITdesnormalizado', 'COLUMN'
go
sp_RENAME 'cartasdeporte.[TransportistaCUIT]' , 'TransportistaCUITdesnormalizado', 'COLUMN'
go

alter table cartasdeporte ADD
	FechaEmision datetime NULL
go

alter table cartasdeporte ADD
	EstaArchivada	varchar(2)
go

--alter table cartasdeporte ADD
--	constraint U_NumeroCarta unique NONCLUSTERED (NumeroCartaDePorte,NumeroSubfijo,SubnumeroVagon)
--go

--alter table cartasdeporte drop
--	 U_NumeroCartaRestringido
--go

--alter table cartasdeporte ADD
--	constraint U_NumeroCartaRestringido unique NONCLUSTERED (NumeroCartaDePorte,SubnumeroVagon,Anulada,FechaAnulacion)
--go




	
ALTER TABLE  WilliamsMailFiltros  ADD
	 EstadoDeCartaPorte VARCHAR(20) NULL
GO
--select * from WilliamsMailFiltros




ALTER TABLE  Clientes ADD
	IncluyeTarifaEnFactura 	varchar(2) NULL
GO


alter table cartasdeporte ADD
	 ExcluirDeSubcontratistas varchar(2) NULL
go


alter table Clientes ADD
         SeLeFacturaCartaPorteComoTitular 	varchar(2) NULL,
         SeLeFacturaCartaPorteComoIntermediario varchar(2) NULL,
         SeLeFacturaCartaPorteComoRemcomercial varchar(2) NULL,
         SeLeFacturaCartaPorteComoCorredor varchar(2) NULL,
         SeLeFacturaCartaPorteComoDestinatario varchar(2) NULL
go



alter table WilliamsMailFiltros ADD
	EnumSyngentaDivision	VARCHAR (10)			NULL
GO

alter table [WilliamsMailFiltrosCola] ADD
	EnumSyngentaDivision	VARCHAR (10)			NULL
GO


alter table cartasdeporte ADD
	 IdTipoMovimiento int null
go



alter table CDPEstablecimientos ADD
	 IdTitular int null
go


alter table localidades
	add CodigoWilliams varchar(20) null
go

alter table williamsdestinos
	add CodigoWilliams varchar(20) null
go



alter table williamsdestinos
	add CodigoPostal VARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go

alter table CDPEstablecimientos ADD
	CUIT varchar(13) NULL,
	AuxiliarString1 VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AuxiliarString2 VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AuxiliarString3 VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go



alter table cartasdeporte ADD
	 IdClienteAFacturarle int null,
	 SubnumeroDeFacturacion  int null
go

alter table cartasdeporte ADD
	 AgregaItemDeGastosAdministrativos  varchar(2) NULL
go





alter table cartasdeporte DROP
	constraint U_NumeroCarta
go

alter table cartasdeporte DROP
	constraint U_NumeroCartaRestringido
go

alter table cartasdeporte ADD
	constraint U_NumeroCartaRestringido unique NONCLUSTERED (NumeroCartaDePorte,SubnumeroVagon,SubnumeroDeFacturacion)
	--no se incluye el 'anulada'. si se 'desanula', basta con poner fechaanulacion en null
	--MODIFICACION: ni siquiera dejé la fecha de anulacion. ahora deje sola la unicidad de las 3: (NCDP-subnumero-subfacturacion)
	--No entiendo. Cómo hacés con las anuladas entonces? "anulada" puede quedar afuera, pero fechaanulacion tiene que estar!
	--una opcion sería poner subnumerovagon muy negativos, 

go


alter table cartasdeporte DROP
	constraint U_NumeroCartaRestringido
go
alter table cartasdeporte ADD
	constraint U_NumeroCartaRestringido2 unique NONCLUSTERED (NumeroCartaDePorte,SubnumeroVagon,SubnumeroDeFacturacion,FechaAnulacion)
	--no se incluye el 'anulada'. si se 'desanula', basta con poner fechaanulacion en null
	--MODIFICACION: ni siquiera dejé la fecha de anulacion. ahora deje sola la unicidad de las 3: (NCDP-subnumero-subfacturacion)
	--No entiendo. Cómo hacés con las anuladas entonces? "anulada" puede quedar afuera, pero fechaanulacion tiene que estar!
	--una opcion sería poner subnumerovagon muy negativos, 

go




alter table  bdlmaster.dbo.UserDatosExtendidos ADD
	RazonSocial		varchar(50) NULL,
	CUIT			varchar(50) NULL,
	PreCUIT			varchar(50) NULL
go

--alter table bdlmaster.dbo.UserDatosExtendidos ADD
--	PRIMARY KEY (UserId)
--go




alter table cartasdeporte ADD
	CalidadGranosQuemados numeric(18,2) NULL,
	CalidadGranosQuemadosBonifica_o_Rebaja varchar(2) NULL,
	CalidadTierra  numeric(18,2) NULL,
	CalidadTierraBonifica_o_Rebaja varchar(2) NULL,
	CalidadMermaChamico  numeric(18,2) NULL,
	CalidadMermaChamicoBonifica_o_Rebaja  varchar(2) NULL,
	CalidadMermaZarandeo numeric(18,2) NULL,
	CalidadMermaZarandeoBonifica_o_Rebaja varchar(2) NULL,
    FueraDeEstandar varchar(2) NULL
go



--////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////
--CREATE INDEX IDX_Cartasdeporte_IdClienteAFacturarle 
--on cartasdeporte(IdClienteAFacturarle )
--go
--drop index IDX_Cartasdeporte_IdClienteAFacturarle on cartasdeporte

--sql2000 y nonclustered?
--sql2000 y nonclustered?
--sql2000 y nonclustered?
CREATE nonclustered INDEX IDX_Cartasdeporte_IdClienteAFacturarle on CartasDePorte(Vendedor)
	include (idcartadeporte,numerocartadeporte,cuentaorden1,cuentaorden2,corredor,entregador,procedencia,idarticulo,netofinal,destino,fechadescarga,subnumerovagon,fechaarribo,idclienteafacturarle,subnumerodefacturacion)
go

CREATE nonclustered INDEX IDX_Clientes_RazonSocial on Clientes(RazonSocial)
go

CREATE nonclustered INDEX IDX_FactAuto_IdSesion on wTempCartasPorteFacturacionAutomatica(IdSesion)
go

--////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////


alter table cartasdeporte ADD
	CalidadPuntaSombreada  numeric(18,2) 
go




alter table Clientes ADD
         SeLeFacturaCartaPorteComoDestinatarioExportador 	varchar(2) NULL,
         SeLeDerivaSuFacturaAlCorredorDeLaCarta		varchar(2) NULL
go


alter table williamsdestinos ADD
	CUIT varchar(13) NULL
go





ALTER TABLE ExcelImportador alter column Producto varchar(100) NULL
ALTER TABLE ExcelImportador alter column Titular varchar(100) NULL
ALTER TABLE ExcelImportador alter column Intermediario varchar(100) NULL
ALTER TABLE ExcelImportador alter column RComercial varchar(100) NULL
ALTER TABLE ExcelImportador alter column Corredor varchar(100) NULL
ALTER TABLE ExcelImportador alter column Comprador varchar(100) NULL
ALTER TABLE ExcelImportador alter column Destino varchar(100) NULL
ALTER TABLE ExcelImportador alter column Procedencia varchar(100) NULL
go



ALTER TABLE WilliamsMailFiltros alter column Emails 	varchar(300) NULL
ALTER TABLE WilliamsMailFiltrosCola alter column Emails 	varchar(300) NULL
GO



--drop INDEX IDX_Cartasdeporte_Filtro1  on CartasDePorte
--go

--sql2000

drop index IDX_Cartasdeporte_Superbuscador on cartasdeporte

CREATE UNIQUE INDEX IDX_Cartasdeporte_Superbuscador
ON CartasDePorte (NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,FechaArribo,FechaIngreso,FechaAnulacion)
--eso taambien tiene que incluir el fechaanulacion
GO




/*
CREATE nonclustered INDEX IDX_Cartasdeporte_Filtro1 on  --en sql 2000 se usa unique index
		CartasDePorte(NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon)
		INCLUDE (FechaArribo,FechaIngreso)
go
*/


--drop INDEX IDX_Clientes_Filtro2  on Clientes
--go

--sql2000
CREATE UNIQUE INDEX IDX_Clientes_Filtro2
ON Clientes (IdCliente,RazonSocial,CUIT,Telefono,Email,FechaAlta)
GO


--select RazonSocial,CUIT,Telefono,Email,FechaAlta,count(*) from Clientes  group by RazonSocial,CUIT,Telefono,Email,FechaAlta having count(*)>1 

/* 
CREATE nonclustered INDEX IDX_Clientes_Filtro2 on Clientes(RazonSocial,CUIT)
			INCLUDE (Telefono,Email,FechaAlta)
go
*/






--update CartasDePorte set SubNumeroDeFacturacion=-2 where IdCartaDePorte=5506 --SubnumeroDeFacturacion is null 

ALTER TABLE CartasDePorte alter column SubNumeroDeFacturacion int NOT NULL
go




CREATE UNIQUE INDEX IDX_CartasDePorte_Filtro4
ON CartasDePorte(IdCartaDePorte,AgregaItemDeGastosAdministrativos)
GO




alter table wTempCartasPorteFacturacionAutomatica ADD
	[AgregaItemDeGastosAdministrativos]   varchar(2) NULL
go





alter table InformesWeb  add
	RolExigidoParaLectura varchar(50) null
go



--------------------------------------------------

alter table localidades
	add CodigoLosGrobo varchar(20) null
go


alter table williamsdestinos
	add CodigoLosGrobo varchar(20) null
go



alter table  CartasPorteMovimientos
	add IdFacturaImputada int null 
go


alter table  cartasdeporte
		ADD FOREIGN KEY (Vendedor) REFERENCES Clientes(IdCliente)
go


CREATE UNIQUE INDEX IDX_WilliamsMailFiltrosCola_SelectDinamico
	ON WilliamsMailFiltrosCola (IdWilliamsMailFiltroCola,UltimoResultado)
GO



--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--drop INDEX  IDX_CartasDePorte_SelectDinamico on CartasDePorte
CREATE UNIQUE INDEX IDX_CartasDePorte_SelectDinamico
	ON CartasDePorte 
			(IdCartaDePorte,SubnumeroDeFacturacion,Vendedor,CuentaOrden1,CuentaOrden2,Corredor,Entregador,
				IdArticulo,NetoProc,IdFacturaImputada,Anulada,FechaDescarga,FechaArribo
				,Exporta,EnumSyngentaDivision,PuntoVenta)
GO



--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL
--ESTE ES EL INDICE FUNDAMENTAL  .. no puede ser nonclustered?
--------------------------------------------------
--------------------------------------------------
--agregar destino? agregar clienteobs?
--experimental   Cannot specify more than 16 column names for statistics or index key list. 18 specified.
CREATE UNIQUE INDEX IDX_CartasDePorte_SelectDinamico2
	ON CartasDePorte 
			(IdCartaDePorte,SubnumeroDeFacturacion,Vendedor,CuentaOrden1,CuentaOrden2,Corredor,Entregador,
				IdArticulo,NetoProc,IdFacturaImputada,Anulada,FechaDescarga,FechaArribo
				,Exporta,EnumSyngentaDivision,PuntoVenta
				,Destino,IdClienteAuxiliar
				)
GO
--select * from CartasDePorte
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------






--exec  sp_help 'listaspreciosdetalle'
alter table listaspreciosdetalle add 
	PrecioExportacion	money null,
	PrecioEmbarque		money null
go


alter table CartasDePorte ADD
	constraint U_cartasdeporte_Imputador unique NONCLUSTERED 
	(IdCartaDePorte,IdFacturaImputada)
go


drop table wGrillaPersistencia
create table wGrillaPersistencia (
	IdRenglon  int not null,
	Sesion  varchar(50) not null,
	Tilde    bit not null,
	
	constraint U_Unicidad unique NONCLUSTERED (IdRenglon,Sesion)
)
go




alter table cartasdeporte ADD
    CobraAcarreo varchar(2) NULL,
    LiquidaViaje varchar(2) NULL
go




alter table clientes ADD
    HabilitadoParaCartaPorte varchar(2) NULL
go





CREATE INDEX IDX_Cartasdeporte_PorFecha  on cartasdeporte(FechaModificacion )
go






alter table ExcelImportador ADD
        CTG						VARCHAR (50)	NULL,
        KmARecorrer				VARCHAR (50)	NULL,
        TarifaTransportista   	VARCHAR (50)	NULL
GO





alter table Facturas ADD
	constraint U_Facturas_SuperBuscador unique NONCLUSTERED 
	(IdFactura,NumeroFactura,TipoABC,PuntoVenta,FechaFactura)
go



alter table Articulos ADD
	constraint U_Articulos_SuperBuscador unique NONCLUSTERED 
	(IdArticulo,Descripcion,codigo,FechaAlta)
go



alter table CartasDePorte ADD
	 IdClienteAuxiliar int null references Clientes(IdCliente)
go

alter table Clientes ADD
         SeLeFacturaCartaPorteComoClienteAuxiliar 	varchar(2) NULL
go

alter table WilliamsMailFiltros ADD
	IdClienteAuxiliar int null references Clientes(IdCliente) 
GO

alter table [WilliamsMailFiltrosCola] ADD
	 IdClienteAuxiliar int null references Clientes(IdCliente) 
GO


alter table [CartasDePorte] ADD
	 Corredor2 int
GO



alter table  bdlmaster.dbo.UserDatosExtendidos ADD
	UltimaBaseAccedida varchar(50) NULL
go

alter table Pedidos ADD
         ConfirmadoPorWeb varchar(2) NULL
go



alter table cartasdeporte add
	CalidadDescuentoFinal numeric(18,2) NULL
go



alter table Clientes ADD
         EsAcondicionadoraDeCartaPorte varchar(2) NULL
go



ALTER TABLE bdlmaster.dbo.DetalleUserPermisos ADD
	Instalado		 bit  NOT NULL  default(1)
go

--alter table bdlmaster.dbo.DetalleUserPermisos drop column Instalado



ALTER TABLE  Clientes ADD
	Contactos				VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TelefonosFijosOficina	VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TelefonosCelulares		VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CorreosElectronicos		VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
 GO



 --///////////////////////////////////////////////////////////////////////////////////////////////
---///////////////////////////////////////////////////////////////////////////////////////////////
---///////////////////////////////////////////////////////////////////////////////////////////////
---///////////////////////////////////////////////////////////////////////////////////////////////
--cómo hacer para actualizar el sqlmetal de toque?





alter table cartasdeporte ADD
	PathImagen    VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go

alter table cartasdeporte ADD
	PathImagen2    VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go





CREATE INDEX IDX_idcomprobante  on log(idcomprobante )
go



alter table cartasdeporte drop constraint FK__CartasDeP__IdCli__72A50F69
go






--CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
--ON [dbo].[CartasDePorte] ([Anulada],[Vendedor],[Corredor],[Entregador],[FechaDescarga])
--INCLUDE ([IdArticulo],[NetoPto],[Merma],[NetoFinal],[Destino],[Exporta],[PuntoVenta],[TarifaFacturada])
--GO


--CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
--ON [dbo].[DetalleFacturas] ([IdArticulo])
--INCLUDE ([PrecioUnitario])
--GO


--sp_help 'WilliamsMailFiltrosCola'
--select TOP 1 * from WilliamsMailFiltrosCola where UltimoResultado='En Cola' 



alter table cartasdeporte ADD
	AgrupadorDeTandaPeriodos  int 
go

alter table [WilliamsMailFiltros] ADD
	 AgrupadorDeTandaPeriodos int 
go

alter table [WilliamsMailFiltrosCola] ADD
	 AgrupadorDeTandaPeriodos int 
GO


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
	ClaveEncriptada    VARCHAR (150)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go





ALTER TABLE WilliamsMailFiltros		alter column   Modo varchar(8) NULL
GO
ALTER TABLE WilliamsMailFiltrosCola		alter column   Modo varchar(8) NULL
GO




--drop index U_cartasdeporte_SuperBuscador4 on cartasdeporte

alter table cartasdeporte ADD
	constraint U_cartasdeporte_SuperBuscador4 unique NONCLUSTERED 
	(IdCartaDePorte,NumeroCartaDePorte,NumeroSubfijo,SubnumeroVagon,SubNumeroDeFacturacion,FechaArribo,FechaModificacion)
go


sp_help 'cartasdeporte'
--sp_help 'Facturas'




alter table cartasdeporte ADD
	NumeroCartaEnTextoParaBusqueda    VARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go

update CartasDePorte 
set NumeroCartaEnTextoParaBusqueda=NumeroCartaDePorte+' '+ NumeroSubFijo+'-'+ SubNumeroVagon


--este es el poteito. De clientes no tiene mucho sentido hacer indice 
--porque buscas con comodin tambien como PREFIJO, asi que en esa tabla no podes hacer el cambiazo de INDEX SCAN por INDEX SEEK
CREATE NONCLUSTERED INDEX IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador4
ON CartasDePorte (NumeroCartaEnTextoParaBusqueda,NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,
					FechaArribo,FechaIngreso,FechaModificacion)
GO


DBCC SHOW_STATISTICS (CartasDePorte, IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador4)
go




sp_help 'CartasDePorte'

CREATE NONCLUSTERED INDEX IDX_Facturas_Superbuscador5
ON Facturas (IdFactura,NumeroFactura,FechaFactura)
GO





alter table CartasDePorte ADD
	 IdClienteEntregador int null references Clientes(IdCliente)
go

alter table Clientes ADD
         EsEntregador 	varchar(2) NULL
go



alter table PuntosVenta ADD
         AgentePercepcionIIBB 	varchar(2) NULL
go


--select * from PuntosVenta
--update PuntosVenta  set AgentePercepcionIIBB='SI' where puntoventa=2 or puntoventa=3 


--CREATE NONCLUSTERED INDEX IDX_FacturacionAutomatica
--ON CartasDePorte ([PuntoVenta],[IdClienteAFacturarle],[NumeroCartaDePorte],[Vendedor],[CuentaOrden1],[CuentaOrden2],[Corredor],[Entregador],[Procedencia],[IdArticulo],[NetoFinal],[Destino],[FechaDescarga],[Exporta],[SubnumeroVagon],[AgregaItemDeGastosAdministrativos])
--GO


create table CartasDePorteMailClusters
(	
	IdCartaDePorte  int REFERENCES CartasDePorte(IdCartaDePorte),
	AgrupadorDeTandaPeriodos  int 
)
go





alter table CartasDePorteMailClusters ADD
	constraint U_CartasDePorteMailClusters unique NONCLUSTERED (IdCartaDePorte,AgrupadorDeTandaPeriodos)
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

exec sp_who2
sp_whoisactive 

use wDemoWilliams 

select AgrupadorDeTandaPeriodos,* from [WilliamsMailFiltrosCola]
group by FechaDesde,FechaHasta



--truncate table [WilliamsMailFiltrosCola]



 
 IF (select COUNT (*) from WilliamsMailFiltrosCola) > 20000 BEGIN   DELETE from WilliamsMailFiltrosCola where UltimoResultado<>'En Cola'    END 


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



alter table CartasDePorte ADD
	 IdDetalleFactura int null references DetalleFacturas(IdDetalleFactura)
go



alter table CartasPorteMovimientos ADD
	 IdDetalleFactura int null references DetalleFacturas(IdDetalleFactura)
go



--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table listaspreciosdetalle add 
	PrecioEmbarque2	money null,
	MaximaCantidadParaPrecioEmbarque  numeric(18,2) NULL
go


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table cartasdeporte ADD
	SojaSustentableCodCondicion    VARCHAR (50) null,
	SojaSustentableCondicion VARCHAR (50) null,
	SojaSustentableNroEstablecimientoDeProduccion VARCHAR (50) null
go


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

alter table cartasdeporte ADD
	 IdClientePagadorFlete int null
go


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


create table CartasDePorteReglasDeFacturacion 
(

			IdRegla int IDENTITY (1, 1) PRIMARY KEY,

			IdCliente int REFERENCES Clientes(idCliente),
			PuntoVenta int ,

			SeLeFacturaCartaPorteComoTitular 	varchar(2) NULL,
			SeLeFacturaCartaPorteComoIntermediario varchar(2) NULL,
			SeLeFacturaCartaPorteComoRemcomercial varchar(2) NULL,
			SeLeFacturaCartaPorteComoCorredor varchar(2) NULL,
			SeLeFacturaCartaPorteComoDestinatario varchar(2) NULL,
			SeLeFacturaCartaPorteComoDestinatarioExportador 	varchar(2) NULL,
			SeLeDerivaSuFacturaAlCorredorDeLaCarta		varchar(2) NULL,
			SeLeFacturaCartaPorteComoClienteAuxiliar 	varchar(2) NULL,
			EsEntregador 	varchar(2) NULL,

			constraint U_CartasDePorteReglasDeFacturacion unique NONCLUSTERED (IdCliente,PuntoVenta)
)

go



--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







ALTER TABLE WilliamsMailFiltros		add  ModoImpresion	 varchar(6) NULL
GO
ALTER TABLE WilliamsMailFiltrosCola	add  ModoImpresion	 varchar(6) NULL
GO
ALTER TABLE Localidades				add  Partido		 varchar(60) NULL
GO








ALTER TABLE  Clientes alter column Contactos				VARCHAR (400)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
ALTER TABLE  Clientes alter column TelefonosFijosOficina	VARCHAR (400)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
ALTER TABLE  Clientes alter column TelefonosCelulares		VARCHAR (400)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
ALTER TABLE  Clientes alter column CorreosElectronicos		VARCHAR (400)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL

 GO






--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



--agregar tambien fk en destinos????

create table Partidos (
	IdPartido int IDENTITY (1, 1) PRIMARY KEY,

	
	Nombre varchar(100) not null,
	Codigo varchar(15) not null,
	IdProvincia int null references Provincias(IdProvincia),
	CodigoONCCA varchar(15), 
	CodigoPostal varchar(15)
	 
		
	constraint U_Partidos_Unicidad unique NONCLUSTERED (Nombre)
)
go



alter table Localidades ADD
	 IdPartido int null references Partidos(IdPartido)
go


alter table WilliamsDestinos add
	CodigoYPF varchar(20) null,
	IdProvincia  int null references Provincias(IdProvincia),
	IdLocalidad int null references Localidades(IdLocalidad)
go





--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table cartasdeporte add -- el largo del varchar tiene que ser 50 tambien para evitar el casteo en wFuncionBusqueda!!!!
	SubnumeroVagonEnTextoParaBusqueda    VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
go


update CartasDePorte 
set SubnumeroVagonEnTextoParaBusqueda=SubNumeroVagon

CREATE NONCLUSTERED INDEX IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador6
ON CartasDePorte (SubnumeroVagonEnTextoParaBusqueda,
					NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,
					FechaArribo,FechaIngreso,FechaModificacion)
GO







--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



alter table CartasDePorte add
		 IdCorredor2 int null references Vendedores(IdVendedor)
go


alter table CartasDePorte add
		 Acopio1 int null,
		 Acopio2 int null,
		 Acopio3 int null,
		 Acopio4 int null,
		 Acopio5 int null
go


create table CartasPorteAcopios (
	IdAcopio  int not null,
	Descripcion  varchar(60) not null,

	constraint U_Unicidad_CartasPorteAcopios unique NONCLUSTERED (Descripcion)
)
go





sp_help WilliamsMailFiltros

ALTER TABLE  WilliamsMailFiltros  ADD
	 Corredor2 int null
GO


ALTER TABLE  [WilliamsMailFiltrosCola]  ADD
	 Corredor2 int null
GO



-----------------------------------------------------------------

ALTER TABLE empleadosaccesos ALTER COLUMN Nodo varchar(100) NULL
go
ALTER TABLE Tree ALTER COLUMN IdItem varchar(30) 
go
ALTER TABLE Tree ALTER COLUMN Clave varchar(100) NULL
go


-----------------------------------------------------------------


ALTER TABLE Proveedores ALTER COLUMN IdCodigoIva int NULL
go
ALTER TABLE Clientes ALTER COLUMN IdCodigoIva int NULL
go



-----------------------------------------------------------------

ALTER TABLE Clientes ADD CartaPorteTipoDeAdjuntoDeFacturacion int NULL
go







alter table ExcelImportador ADD
        Exporta VARCHAR (10)	NULL,
        SubnumeroDeFacturacion VARCHAR (10)	NULL
go




--//////////////////////////////////////////////////////////////////////////////////////////////////


ALTER TABLE  CartasPorteAcopios  ADD
	IdCliente int null references Clientes(IdCliente)
GO

select * from CartasPorteAcopios

INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  1, 'AGRO', 4333              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  2, 'SEEDS', 4333              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  3, 'PEHUA', 10              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  4, 'OLAVARR', 10              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  5, 'NAON', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  6, 'G.VILL', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  7, 'IRIARTE', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  8, 'WRIGHT', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  9, 'CDC ACA', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  10, 'GUALEGUAY', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  11, 'GLGUAYCHU', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  12, 'RUFINO', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  13, 'BRAGADO', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  14, 'LAS FLORES', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  15, 'OTROS', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  16, 'CDC Eduardo Castex', 10) --A.C.A. LTDA   id10

INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  17, 'LDC acopio1', 2775) --ldc   id2775
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  18, 'LDC acopio2', 2775) --ldc   id2775
--select * from clientes where razonsocial like '%ldc%'


alter table CartasDePorte add
		 AcopioFacturarleA int null
go




ALTER TABLE  Facturas ADD
	 FueEnviadoCorreoConFacturaElectronica VARCHAR(2) NULL
GO




CREATE NONCLUSTERED INDEX CartasDePorte_TarifaFacturada
ON [dbo].[CartasDePorte] ([TarifaFacturada],[IdFacturaImputada])
INCLUDE ([IdCartaDePorte],[Anulada],[Vendedor],[IdArticulo],[Destino],[Exporta])
GO





alter table cartasdeporte ADD
	CalidadGranosDanadosRebaja numeric(18,2) NULL,
	CalidadGranosExtranosRebaja  numeric(18,2) NULL
go




