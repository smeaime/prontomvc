

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
--eso taamten tiene que incluir el fechaanulacion
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


--la diferencia con el IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador4 es que este es para el subnumero vagon
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
delete CartasPorteAcopios 

INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  1, 'Agro', 4333              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  2, 'Seeds', 4333              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  3, 'CDC Pehua.', 10              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  4, 'CDC Olavar', 10              ) --syngenta 4333
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  5, 'CDC Naon', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  6, 'CDC G.Vill', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  7, 'CDC Iriart', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  8, 'CDC Wright', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  9, 'CDC ACA', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  10, 'GUALEGUAY', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  11, 'GLGUAYCHU', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  12, 'Rufino', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  13, 'Bragado', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  14, 'Las Flores', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  15, ',E.CASTEX', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  16, 'HUANGUELEN', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  17, '16 DE JULI', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  18, 'OTROS', 10) --A.C.A. LTDA   id10
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  19, 'LDC acopio1', 2775) --ldc   id2775
INSERT  INTO CartasPorteAcopios ( IdAcopio, Descripcion,IdCliente) 
VALUES  (  20, 'LDC acopio2', 2775) --ldc   id2775
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











alter table cartasdeporte ADD
	CalidadGranosExtranosMerma numeric(18,2) NULL,
	CalidadQuebradosMerma numeric(18,2) NULL,
	CalidadDanadosMerma numeric(18,2) NULL,
	CalidadChamicoMerma numeric(18,2) NULL,
	CalidadRevolcadosMerma numeric(18,2) NULL,
	CalidadObjetablesMerma numeric(18,2) NULL,
	CalidadAmohosadosMerma numeric(18,2) NULL,
	CalidadPuntaSombreadaMerma numeric(18,2) NULL,
	CalidadHectolitricoMerma numeric(18,2) NULL,
	CalidadCarbonMerma numeric(18,2) NULL,
	CalidadPanzaBlancaMerma numeric(18,2) NULL,
	CalidadPicadosMerma numeric(18,2) NULL,
	CalidadVerdesMerma numeric(18,2) NULL,
	CalidadQuemadosMerma numeric(18,2) NULL,
	CalidadTierraMerma numeric(18,2) NULL,
	CalidadZarandeoMerma numeric(18,2) NULL,
	CalidadDescuentoFinalMerma numeric(18,2) NULL,
	CalidadHumedadMerma numeric(18,2) NULL,
	CalidadGastosFumigacionMerma numeric(18,2) NULL
go


alter table cartasdeporte ADD
--	CalidadGranosExtranosRebaja numeric(18,2) NULL,
	CalidadQuebradosRebaja numeric(18,2) NULL,
--  CalidadDanadosRebaja numeric(18,2) NULL,
	CalidadChamicoRebaja numeric(18,2) NULL,
	CalidadRevolcadosRebaja numeric(18,2) NULL,
	CalidadObjetablesRebaja numeric(18,2) NULL,
	CalidadAmohosadosRebaja numeric(18,2) NULL,
	CalidadPuntaSombreadaRebaja numeric(18,2) NULL,
	CalidadHectolitricoRebaja numeric(18,2) NULL,
	CalidadCarbonRebaja numeric(18,2) NULL,
	CalidadPanzaBlancaRebaja numeric(18,2) NULL,
	CalidadPicadosRebaja numeric(18,2) NULL,
	CalidadVerdesRebaja numeric(18,2) NULL,
	CalidadQuemadosRebaja numeric(18,2) NULL,
	CalidadTierraRebaja numeric(18,2) NULL,
	CalidadZarandeoRebaja numeric(18,2) NULL,
	CalidadDescuentoFinalRebaja numeric(18,2) NULL,
	CalidadHumedadRebaja numeric(18,2) NULL,
	CalidadGastosFumigacionRebaja numeric(18,2) NULL,
	
	CalidadHumedadResultado numeric(18,2) NULL,
	CalidadGastosFumigacionResultado numeric(18,2) NULL
go








alter table CartasPorteAcopios add primary key (IdAcopio)
go








CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[Facturas] ([FechaFactura])
INCLUDE ([IdFactura],[NumeroFactura],[TipoABC],[PuntoVenta],[IdCliente],[IdVendedor],[Anulada],[ImporteTotal],[ImporteIva1],[ImporteIva2],[ImporteBonificacion],[RetencionIBrutos1],[RetencionIBrutos2],[RetencionIBrutos3],[FechaVencimiento],[IVANoDiscriminado],[IdMoneda],[IdProvinciaDestino],[IdUsuarioIngreso],[FechaIngreso],[IdObra],[IdCodigoIva],[PercepcionIVA],[ActivarRecuperoGastos],[ContabilizarAFechaVencimiento],[FacturaContado],[CAE],[RechazoCAE],[FechaVencimientoORechazoCAE],[AjusteIva],[FueEnviadoCorreoConFacturaElectronica])
GO


CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
		ON [dbo].[CartasDePorte] ([IdFacturaImputada])
		INCLUDE([IdCartaDePorte], [NumeroCartaDePorte], [Vendedor], [CuentaOrden1],
		[CuentaOrden2], [Corredor], [Entregador], [IdArticulo], [NetoFinal], [Contrato],
		[Destino], [FechaDescarga], [IdEstablecimiento], [AgregaItemDeGastosAdministrativos])
GO






-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
alter table Localidades add 
	 CodigoAfip int null
go

alter table Localidades ADD
	constraint U_LocalidadesAFIP unique NONCLUSTERED (CodigoAfip)
go




ALTER TABLE   williamsdestinos ADD
	 PuntoVenta int null
GO





-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------



alter table CartasDePorte add
		 Acopio6 int null REFERENCES CartasPorteAcopios(IdAcopio)
go


--drop table CartasDePorteDetalle
create table CartasDePorteDetalle (
		IdCartaDePorteDetalle int IDENTITY (1, 1) PRIMARY KEY,
		IdCartaDePorte int REFERENCES CartasDePorte(IdCartaDePorte),
		Campo varchar(40),
		Valor numeric(18,2) NULL,		
		
		constraint U_Unicidad_CartasDePorteDetalle unique NONCLUSTERED (IdCartaDePorte,Campo)
		)
go


--select * from CartasDePorteDetalle









----//////////////////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].FertilizantesCupos (
    [IdFertilizanteCupo]                                INT             IDENTITY (1, 1) PRIMARY KEY,
    [Numero]											BIGINT          NULL,


	
--Nº CUPO


    [IdUsuarioIngreso]                              INT             NULL,
    [FechaIngreso]                                  DATETIME        NULL,
    [Anulada]                                       VARCHAR (2)     NULL,
    [IdUsuarioAnulo]                                INT             NULL,
    [FechaAnulacion]                                DATETIME        NULL,
    [FechaTimeStamp]                                ROWVERSION      NULL,





	--Fecha
    [FechaCupo]                                  DATETIME        NULL,
--Cliente
--C/ORDEN
--CUIT
--Nombre del Chofer
--DNI /CUIL
	TipoEgresoIngreso							VARCHAR(1) NULL,

    [Cliente]	                                    INT             NULL,
    [CuentaOrden]									INT             NULL,
    [IdChofer]                                      INT             NULL,






    [Chasis]                                      VARCHAR (20)    NULL,
    [Acoplado]                                      VARCHAR (20)    NULL,


--Chasis
--Acoplado


	
    [IdTransportista]                               INT             NULL,
--Transporte
--CUIT
--Localidad Transp
    [IdLocalidadTransportista]                                       INT             NULL,
--Recorrido
   Recorrido									INT             NULL,
 --Destino de la mercaderia
    [Destino]                                       INT             NULL,
--Codigo de San
--Contrato
    [Contrato]                                      VARCHAR (20)    NULL,







--Producto (UG,DAP,MAP,etc)
--Puro
--Mezcla
--Producto 1
--%
--Producto 2
--%
--Producto 3
--%
--Producto4
--%


    [IdArticulo]                                    INT             NULL,

    Puro                                       VARCHAR (2)     NULL,
    Mezcla                                       VARCHAR (2)     NULL,


    [IdArticuloComponente1]                             INT             NULL,
    [Porcentaje1]	                                    NUMERIC (18, 2) NULL,
    [IdArticuloComponente2]                             INT             NULL,
    [Porcentaje2]	                                    NUMERIC (18, 2) NULL,
    [IdArticuloComponente3]                             INT             NULL,
    [Porcentaje3]	                                    NUMERIC (18, 2) NULL,
    [IdArticuloComponente4]                             INT             NULL,
    [Porcentaje4]	                                    NUMERIC (18, 2) NULL,
    [IdArticuloComponente5]                             INT             NULL,
    [Porcentaje5]	                                    NUMERIC (18, 2) NULL,


	--Forma de despacho (granel,bls, bigbag)
	FormaDespacho									INT NULL,

--Cantidad (Kg)
--OBSERVACIONES


    [Cantidad]                                      NUMERIC (12, 2) NULL,

    [Observaciones]                                 VARCHAR (200)   NULL,




    [PathImagen]                                    VARCHAR (150)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PathImagen2]                                   VARCHAR (150)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AgrupadorDeTandaPeriodos]                      INT             NULL,
    [ClaveEncriptada]                               VARCHAR (150)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroCartaEnTextoParaBusqueda]                VARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SubnumeroVagonEnTextoParaBusqueda]             VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,



	

);

alter table FertilizantesCupos ADD
	IdUsuarioModifico int NULL,
	FechaModificacion datetime NULL,
	IdFacturaImputada int null,
	NumeradorTexto        VARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go

alter table FertilizantesCupos ADD
	constraint U_Numero unique NONCLUSTERED (NumeradorTexto,FechaAnulacion)
go


alter table  FertilizantesCupos ADD
		 FOREIGN KEY (Cliente) REFERENCES Clientes(IdCliente),
		 FOREIGN KEY (CuentaOrden) REFERENCES Clientes(IdCliente),
		 FOREIGN KEY (IdArticulo) REFERENCES Articulos(IdArticulo)
go

alter table  FertilizantesCupos ADD
		 FOREIGN KEY (IdArticuloComponente1) REFERENCES Articulos(IdArticulo),
		 FOREIGN KEY (IdArticuloComponente2) REFERENCES Articulos(IdArticulo),
		 FOREIGN KEY (IdArticuloComponente3) REFERENCES Articulos(IdArticulo),
		 FOREIGN KEY (IdArticuloComponente4) REFERENCES Articulos(IdArticulo),
		 FOREIGN KEY (IdArticuloComponente5) REFERENCES Articulos(IdArticulo),
		 FOREIGN KEY (IdChofer) REFERENCES Choferes(IdChofer),
		 FOREIGN KEY (IdTransportista) REFERENCES Transportistas(IdTransportista),
		 FOREIGN KEY (IdLocalidadTransportista) REFERENCES Localidades(Idlocalidad),
		 FOREIGN KEY (Destino) REFERENCES WilliamsDestinos(idWilliamsDestino),
		 FOREIGN KEY (IdUsuarioIngreso) REFERENCES empleados(Idempleado),
		 FOREIGN KEY (IdUsuarioAnulo) REFERENCES empleados(Idempleado)
go




--alter table  FertilizantesCupos ADD
--    [NetoProc]                                      NUMERIC (12, 2) NULL,
--    [TaraProc]                                      NUMERIC (12, 2) NULL,
--    [BrutoProc]                                      NUMERIC (12, 2) NULL,
--    [NetoFinal]                                      NUMERIC (12, 2) NULL
--go

--------------------------------------------------------------------------

 update  cartasdeporte
 set fechaanulacion=getdate()
  where Anulada='SI' and FechaAnulacion is null
 
update CartasDePorte
set FechaAnulacion =null
where FechaAnulacion is not  null AND Anulada='NO'

update CartasDePorte
set Anulada='SI'
where FechaAnulacion is not  null AND Anulada='NO'


select SubnumeroDeFacturacion,* from cartasdeporte where numerocartadeporte=540816830 

--alter table CartasDePorte ADD
--	CONSTRAINT chk_FechaAnulacion2 CHECK ((FechaAnulacion is null AND Anulada='NO') OR (FechaAnulacion is not null AND Anulada='SI')) 
--go

alter table CartasDePorte ADD
	CONSTRAINT chk_FechaAnulacion3 CHECK (not (FechaAnulacion is not null AND Anulada='NO') ) 
go






-----------------------------------------------------------------------------------------------------------------------

ALTER TABLE FertilizantesCupos alter column contrato varchar(50) NULL
go

alter table FertilizantesCupos ADD
	HoraArribo datetime NULL,
	HoraCarga  datetime NULL,
	HoraAutorizacion  datetime NULL,
	HoraDespacho  datetime NULL,
	KilosMaximo NUMERIC (12, 2) NULL,
	NumeroRemito VARCHAR (20)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NumeroCotizacion VARCHAR (20)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Tara            NUMERIC (12, 2) NULL,
	Bruto			NUMERIC (12, 2) NULL,
	Despacho		VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PuntoDespacho	VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL
go

---------------------------------------------------------------------------


alter table CartasDePorte ADD
	ConDuplicados	INT				NULL
go




Update CartasDePorte  
set ConDuplicados =    
        (  
        	select count(*) from cartasdeporte as Q2   
        		where    
        			Q2.NumeroCartaDePorte=NumeroCartaDePorte AND   
        			Q2.NumeroSubFijo=NumeroSubFijo AND   
        			Q2.SubNumeroVagon=SubNumeroVagon  
        			and Anulada<>'SI'  
        )
select Q.NumeroCartaDePorte,Q.NumeroSubFijo,Q.SubNumeroVagon  
        from  cartasdeporte as Q  
        inner join    
        (  
        select NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon  
        from cartasdeporte  
        where Anulada<>'SI'  
        group by NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon  
        having     COUNT(NumeroCartaDePorte) > 1  
        ) as REPES on REPES.NumeroCartaDePorte=Q.NumeroCartaDePorte AND REPES.NumeroSubFijo=Q.NumeroSubFijo AND       
        REPES.SubNumeroVagon=Q.SubNumeroVagon  
go

select conduplicados from cartasdeporte





-----------------------------------------------------------------------------------------------------------------------


alter table FertilizantesCupos ADD
	LitrosFinal NUMERIC (12, 2) NULL
go



ALTER TABLE facturas alter column idcondicionventa int NULL



-----------------------------------------------------------------------------------------------------------------------




alter table cartasdeporte ADD
	TieneRecibidorOficial varchar(2),
	EstadoRecibidor INT NULL,
	ClienteAcondicionador INT NULL REFERENCES Clientes(IdCliente),
	MotivoRechazo INT NULL
go



--alter table cartasdeporte drop column 
--	MotivoRechazo 
--go

--alter table cartasdeporte ADD
--	MotivoRechazo INT NULL




alter table wTempCartasPorteFacturacionAutomatica alter column TarifaFacturada money
go







------------------------------------------------------------------------

create table FertilizantesPuntosDespacho (
	IdFertilizantesPuntosDespacho int IDENTITY (1, 1) PRIMARY KEY,
	Nombre varchar(50)
)
go

create table UsuariosRelacionFertilizantesPuntosDespacho (
	IdUsuariosRelacionFertilizantesPuntosDespacho int IDENTITY (1, 1) PRIMARY KEY,
	IdFertilizantesPuntosDespacho INT REFERENCES FertilizantesPuntosDespacho(IdFertilizantesPuntosDespacho),
	UsuarioEnBaseBDLMaster UNIQUEIDENTIFIER 
)

create table FertilizantesTiposDespacho (
	IdFertilizantesTiposDespacho int IDENTITY (1, 1) PRIMARY KEY,
	Nombre varchar(50)
)
go

create table UsuariosRelacionFertilizantesTiposDespacho (
	IdUsuariosRelacionFertilizantesTiposDespacho int IDENTITY (1, 1) PRIMARY KEY,
	IdFertilizantesTiposDespacho INT REFERENCES FertilizantesTiposDespacho(IdFertilizantesTiposDespacho),
	UsuarioEnBaseBDLMaster UNIQUEIDENTIFIER 
)


go





----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

alter table Log ADD
	IdLog int IDENTITY (1, 1) PRIMARY KEY
go


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------




sp_help facturas

select * from facturas where idfactura>79302 and idfactura < 79306



CREATE nonclustered INDEX IDX_Cartasdeporte_CalidadTierra on CartasDePorte(CalidadTierra)
go

CREATE nonclustered INDEX IDX_Cartasdeporte_PathImagen2 on CartasDePorte(PathImagen, PathImagen2,FechaModificacion)
go
CREATE nonclustered INDEX IDX_Cartasdeporte_PathImagen3 on CartasDePorte(PathImagen2,FechaModificacion)
go

select top 10 cosecha  from cartasdeporte where idcartadeporte>1000000




create table CartasDePorteLogDeOCR
(	
	IdCartasDePorteLog int IDENTITY (1, 1) PRIMARY KEY,
	NumeroCarta int NULL,
	IdCartaDePorte  int REFERENCES CartasDePorte(IdCartaDePorte),
	Fecha datetime NULL,
	IdUsuario int NULL,
	Observaciones varchar(100) NULL,
	TextoAux1 varchar(100) NULL,
	TextoAux2 varchar(100) NULL,
	IntAux1 int NULL,
	IntAux2 int NULL,
)
go



SELECT  dbo.LevenshteinDistance(nombre,'IRENEO PORTELA - BSAS'), Localidades.* FROM Localidades 
WHERE ltrim(nombre)<>'' AND dbo.LevenshteinDistance(nombre,'IRENEO PORTELA - BSAS')<10
order by dbo.LevenshteinDistance(nombre,'IRENEO PORTELA - BSAS') asc


SELECT  dbo.LevenshteinDistance(palabra,'IRENEO PORTELA - BSAS'), DiccionarioEquivalencias.* FROM DiccionarioEquivalencias 
WHERE ltrim(palabra)<>'' AND dbo.LevenshteinDistance(palabra,'IRENEO PORTELA - BSAS')<10
order by dbo.LevenshteinDistance(palabra,'IRENEO PORTELA - BSAS') asc

SELECT traduccion,palabra FROM DiccionarioEquivalencias WHERE 
ltrim(palabra)<>'' AND 
dbo.LevenshteinDistance(palabra,'IRENEO PORTELA - BS. AS.') < 7  
order by dbo.LevenshteinDistance(palabra,'IRENEO PORTELA - BS. AS.')  asc



drop  INDEX IDX_DiccionarioEquivalencias_Traduccion on DiccionarioEquivalencias
go
CREATE nonclustered INDEX IDX_DiccionarioEquivalencias_Palabra2 on DiccionarioEquivalencias(palabra,traduccion)
go



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


ALTER TABLE ExcelImportador add  BrutoProc   varchar(100) NULL
ALTER TABLE ExcelImportador add  TaraProc    varchar(100) NULL
ALTER TABLE ExcelImportador add  Auxiliar6   varchar(100) NULL
ALTER TABLE ExcelImportador add  Auxiliar7   varchar(100) NULL
ALTER TABLE ExcelImportador add  Auxiliar8   varchar(100) NULL 
ALTER TABLE ExcelImportador add  Auxiliar9   varchar(100) NULL




ALTER TABLE Localidades add  CodigoCGG   varchar(10) NULL


--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table CartasDePorte add
	FacturarA_Manual bit  NOT NULL  default(0)
go


sp_help WilliamsDestinos
go

alter table WilliamsDestinos add
	IdLocalidad2 int null references Localidades(IdLocalidad),
	IdLocalidad3 int null references Localidades(IdLocalidad),
	IdLocalidad4 int null references Localidades(IdLocalidad)
go





--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////




drop table CartasDePorteControlDescarga
create table CartasDePorteControlDescarga (
	IdCartasDePorteControlDescarga int IDENTITY (1, 1) PRIMARY KEY,

	Fecha datetime not null,
	IdDestino int null references williamsdestinos(Idwilliamsdestino),
	IdPuntoVenta int,
	TotalDescargaDia int,
	PorcentajeDesnormalizado  numeric(18,2) NULL

	--,constraint U_Unicidad unique NONCLUSTERED (IdCartasDePorteControlDescarga,Sesion)
)
go




--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////

--NumeroCartaEnTextoParaBusqueda y [SubnumeroVagonEnTextoParaBusqueda] en indice (creo que estaba [SubnumeroVagonEnTextoParaBusqueda] y NumeroCarta)


CREATE NONCLUSTERED INDEX IDX_NumeroCartaEnTextoParaBusqueda_Superbuscador7
ON CartasDePorte (NumeroCartaEnTextoParaBusqueda,SubnumeroVagonEnTextoParaBusqueda, NumeroCartaDePorte,NumeroSubFijo,SubNumeroVagon,SubnumeroDeFacturacion,
					FechaArribo,FechaIngreso,FechaModificacion)
GO




--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////




CREATE NONCLUSTERED INDEX IDX_CartaPorte_EstadisticasDeDescarga
ON [dbo].[CartasDePorte] ([Anulada],[Vendedor],[FechaDescarga])
INCLUDE ([FechaIngreso],[IdArticulo],[NetoProc],[NetoPto],[Merma],[NetoFinal],[Exporta],[HumedadDesnormalizada],[PuntoVenta],[TarifaFacturada])
GO



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////






alter table listaspreciosdetalle add 
	PrecioVagonesBalanza	money null,
	PrecioVagonesCalada		money null
go


CREATE NONCLUSTERED INDEX CartasDePorte_IdFacturaImputada_Subcontr
ON [dbo].[CartasDePorte] ([IdFacturaImputada])
INCLUDE ([Anulada],[Subcontr1],[Subcontr2])
go


--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////

--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////



CREATE NONCLUSTERED INDEX IDX_CartasDePorte_IndiceParaControlDeDescargas
ON [dbo].[CartasDePorte] ([SubnumeroDeFacturacion])
INCLUDE ([NetoFinal],[Destino],[FechaDescarga],[PuntoVenta])
GO



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table listaspreciosdetalle add 
	PrecioVagonesBalanzaExportacion		money null,
	PrecioVagonesCaladaExportacion		money null
go


--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


CREATE NONCLUSTERED INDEX IDX_ExcelImportador_IdTanda
ON [dbo].[ExcelImportador] ([IdTanda])
INCLUDE ([IdExcelImportador])
GO


--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


ALTER TABLE listaspreciosdetalle DROP CONSTRAINT [U_DetalleWilliams]
GO


alter table listaspreciosdetalle ADD
	constraint [U_DetalleWilliams] unique NONCLUSTERED ([IdListaPrecios],[IdArticulo],[IdDestinoDeCartaDePorte],Idcliente)
go



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////

alter table listaspreciosdetalle add 
	PrecioBuquesCalada money null
go



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table cartasdeporte ADD
	EntregaSAP 		VARCHAR (20)	NULL
GO
	


--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table CartasDePorteControlDescarga ADD
	constraint U_CartasDePorteControlDescarga unique NONCLUSTERED (Fecha,IdDestino)
go






--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table cartasdeporte ADD
	Situacion int NULL,
	SituacionAntesDeEditarManualmente int NULL,
	FechaActualizacionAutomatica datetime NULL,
	FechaAutorizacion datetime NULL,
	ObservacionesSituacion  varchar(200) NULL
GO



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table cartasdeporte ADD
	SituacionLog  varchar(300) NULL
GO



--////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////


alter table cartasdeporte ADD
	Turno	VARCHAR (10)			NULL,
	FechaEnvioASyngenta datetime NULL
GO










alter table  bdlmaster.dbo.UserDatosExtendidos ADD
	TextoAuxiliar		varchar(500) NULL
go






--sp_help [wGrillaPersistencia]

CREATE NONCLUSTERED INDEX IDX_wGrillaPersistencia_Sesion
ON [dbo].[wGrillaPersistencia] ([Sesion],[IdRenglon])
go


alter table [wGrillaPersistencia] ADD
	constraint U_Unicidad unique NONCLUSTERED (IdRenglon,Sesion)
go







alter table localidades ADD
	lat decimal(15, 12)  NULL   ,
    lng decimal(15, 12)  NULL   
go










create table CartaPorteRubrosCalidad
(	
	IdCartaPorteRubroCalidad int IDENTITY (1, 1) PRIMARY KEY,
	Descripcion  varchar(60) not null,

	constraint U_CartaPorteRubrosCalidad unique NONCLUSTERED (Descripcion)
)


create table CartaPorteNormasCalidad
(
		IdCartaPorteNormaCalidad  int IDENTITY (1, 1) PRIMARY KEY,

		IdCartaPorteRubroCalidad int references CartaPorteRubrosCalidad(IdCartaPorteRubroCalidad),
		ResultadoDesde  numeric(18,2),
		ResultadoHasta  numeric(18,2),
		RebajaIncremento  numeric(18,2),
		IdArticulo int NULL  references Articulos(IdArticulo) ,
		IdDestino int NULL references WilliamsDestinos(IdWilliamsDestino)
)







INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Materias extrañas' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Quebrados partidos' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Dañados' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Semilla de chamico' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Revolcado en tierra' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Olores objetables' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Granos amohosados' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Punta sombreada' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Peso hectolítrico' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Granos con carbón' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Panza blanca' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Picados' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Granos verdes' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Granos Quemados o de Avería' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Tierra' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Mermas por Zarandeo' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Humedad' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Gastos de fumigación' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Gastos de Secada' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Merma Volatil' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Fondo Nidera' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Merma Convenida' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Tal Cual Vicentin' ) 
INSERT  INTO CartaPorteRubrosCalidad ( Descripcion)  VALUES  (  'Descuento Final' ) 
	
--select * from CartaPorteRubrosCalidad
--select * from tiposcomprobante


--select idcartadeporte, numerocartadeporte,idfacturaimputada, fechaingreso, fechadescarga from cartasdeporte where iddetallefactura=1 order by idcartadeporte desc

CREATE TABLE [dbo].[ColaCorreosComprobantes] (
    [IdTipoComprobante] INT NOT NULL,
    [IdComprobante]     INT NOT NULL
);
go

alter table [ColaCorreosComprobantes] add
	IdColaCorreoComprobante int IDENTITY (1, 1) PRIMARY KEY
go

select * from [ColaCorreosComprobantes]
delete [ColaCorreosComprobantes]

INSERT  INTO [ColaCorreosComprobantes] ( IdTipoComprobante,IdComprobante)  VALUES  (  17,10 ) 
INSERT  INTO [ColaCorreosComprobantes] ( IdTipoComprobante,IdComprobante)  VALUES  (  15,9 ) 
INSERT  INTO [ColaCorreosComprobantes] ( IdTipoComprobante,IdComprobante)  VALUES  (  17,11 ) 


select * from aspnet_Users
select * from UserDatosExtendidos
select * from aspnet_Membership




--exec  sp_help 'listaspreciosdetalle'
alter table listaspreciosdetalle add 
	PrecioComboCaladaMasBalanza  money null
go



update
select * from listaspreciosdetalle where idlistaprecios=2219








--////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////






create table Reclamos
(	
	IdReclamo int IDENTITY (1, 1) PRIMARY KEY,
	Descripcion  varchar(60) not null,

	--constraint U_CartaPorteRubrosCalidad unique NONCLUSTERED (Descripcion)

	Estado int
)
GO


create table ReclamoComentarios
(
		IdReclamoComentario  int IDENTITY (1, 1) PRIMARY KEY,

		IdReclamo int references Reclamos(IdReclamo),
		
		IdEmpleado int REFERENCES Empleados(IdEmpleado),

		Comentario  varchar(1000), 
		Fecha datetime,

		ArchivoAdjunto  varchar(150) NULL
)
GO


alter table cartasdeporte ADD
	IdReclamo int references Reclamos(IdReclamo)
GO





CREATE NONCLUSTERED INDEX IDX_cartasdeporte_IdReclamo
ON [dbo].[cartasdeporte] (IdReclamo)
go





alter table ReclamoComentarios ADD
	NombreUsuario varchar(150) NULL
go







CREATE INDEX IDX_Cartasdeporte_PorFecha  on cartasdeporte(FechaModificacion )
go







sp_help cartasdeporte

ALTER TABLE  cartasdeporte  ALTER COLUMN  
	 NRecibo VARCHAR(15) NULL  --de int a string   
GO



