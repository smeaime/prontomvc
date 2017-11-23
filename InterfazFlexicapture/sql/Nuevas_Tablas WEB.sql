
--////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////
--18 de mayo 2010
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

CREATE TABLE CartasDePorte
(
	IdCartaDePorte int IDENTITY (1, 1) PRIMARY KEY,

	NumeroCartaDePorte int,

	---------------------------------------------
	--cosas que van pegadas genericamente a toda entidad pronto

	IdUsuarioIngreso int NULL , --REFERENCES Empleados(idEmpleado),
	FechaIngreso datetime NULL,
	--FechaRegistracion datetime,

	Anulada varchar(2) NULL,
	IdUsuarioAnulo int NULL,
	FechaAnulacion datetime NULL,

	Observaciones varchar(200) NULL,
	FechaTimeStamp		timestamp,
	--------------------------------------------




	--------------------------------------------

	Vendedor			int NULL, --REFERENCES Articulos(idArticulo),
	CuentaOrden1		int NULL, --REFERENCES Articulos(idArticulo),
	CuentaOrden2		int NULL, --REFERENCES Articulos(idArticulo),
	Corredor			int NULL, --REFERENCES Articulos(idArticulo),
	Entregador			int NULL, --REFERENCES Articulos(idArticulo),
	Procedencia			varchar(30) NULL,
	Patente				varchar(30) NULL,	



	--------------------------------------------
	IdArticulo			int NULL REFERENCES Articulos(idArticulo),
	IdStock				int NULL,
	Partida				varchar(20),
	IdUnidad			int NULL, -- REFERENCES Unidades(idUnidad),
	IdUbicacion			int NULL,
	Cantidad			numeric(12,2) NULL,
	-------------------------------------------

	Cupo				varchar(30) NULL,	
	NetoProc			numeric(18,2) NULL,	
	Calidad				varchar(30) NULL,	
	BrutoPto			numeric(18,2) NULL,	
	TaraPto				numeric(18,2) NULL,
	NetoPto				numeric(18,2) NULL,

	Acoplado			varchar(30) NULL,	
	Humedad 			numeric(18,2) NULL,
	Merma				numeric(18,2) NULL,	
	NetoFinal			numeric(18,2) NULL,	
	FechaDeCarga		datetime NULL,
	FechaVencimiento	datetime NULL,
	CEE					varchar(20) NULL,	
	IdTransportista		int NULL REFERENCES Transportistas(idTransportista),
	TransportistaCUIT	varchar(13) NULL,--desnormalizado
	IdChofer			int NULL,
	ChoferCUIT			varchar(13) NULL,--desnormalizado



	CTG int NULL,

	Contrato varchar(20) NULL ,

	Destino int NULL,
	Subcontr1 int NULL,
	Subcontr2 int NULL,
	Contrato1 int NULL,
	contrato2 int NULL,

	KmARecorrer numeric(18,2) NULL,
	Tarifa numeric(18,2) NULL,
	FechaDescarga datetime NULL,
	Hora datetime NULL,
	NRecibo int NULL,
	CalidadDe int NULL,
	TaraFinal numeric(18,2) NULL,
	BrutoFinal numeric(18,2) NULL,


	Fumigada numeric(18,2) NULL,
	Secada numeric(18,2) NULL,

	Exporta  varchar(2) NULL,

	NobleExtranos numeric(18,2) NULL,
	NobleNegros numeric(18,2) NULL,
	NobleQuebrados numeric(18,2) NULL,
	NobleDaniados numeric(18,2) NULL,
	NobleChamico numeric(18,2) NULL,
	NobleChamico2 numeric(18,2) NULL,
	NobleRevolcado numeric(18,2) NULL,
	NobleObjetables numeric(18,2) NULL,
	NobleAmohosados numeric(18,2) NULL,
	NobleHectolitrico numeric(18,2) NULL,
	NobleCarbon numeric(18,2) NULL,
	NoblePanzaBlanca numeric(18,2) NULL,
	NoblePicados numeric(18,2) NULL,
	NobleMGrasa numeric(18,2) NULL,
	NobleAcidezGrasa numeric(18,2) NULL,
	NobleVerdes numeric(18,2) NULL,
	NobleGrado int NULL,
	NobleConforme varchar(2) NULL,
	NobleACamara varchar(2) NULL,




	Cosecha				varchar(20) NULL ,--desnormalizado

	HumedadDesnormalizada numeric(18,2) NULL,
	Factor numeric(18,2) NULL,


	IdFacturaImputada int,

	PuntoVenta int,
	SubnumeroVagon int,


	TarifaFacturada  numeric(18,2) NULL,

	TarifaSubcontratista1  numeric(18,2) NULL,
	TarifaSubcontratista2  numeric(18,2) NULL,

	FechaArribo  datetime NULL,
	Version  int NULL, --para tener un campo alternativo de concurrencia (el otro es un timestamp con el que tengo problemas para leer/grabar (8 bytes))

	MotivoAnulacion varchar(100) NULL,
	
	constraint U_NumeroCarta unique NONCLUSTERED (NumeroCartaDePorte,SubnumeroVagon)
)

go






ALTER TABLE CartasDePorte
	ADD CONSTRAINT FK_Vendedor_Cliente FOREIGN KEY (Vendedor) REFERENCES Clientes (IdCliente)
ALTER TABLE CartasDePorte
	ADD CONSTRAINT FK_CuentaOrden1_Cliente FOREIGN KEY (CuentaOrden1) REFERENCES Clientes (IdCliente)
ALTER TABLE CartasDePorte
	ADD CONSTRAINT FK_CuentaOrden2_Cliente FOREIGN KEY (CuentaOrden2) REFERENCES Clientes (IdCliente)
ALTER TABLE CartasDePorte
	ADD CONSTRAINT FK_Entregador_Cliente FOREIGN KEY (Entregador) REFERENCES Clientes (IdCliente)
ALTER TABLE CartasDePorte
	ADD CONSTRAINT FK_Corredor_Cliente FOREIGN KEY (Corredor) REFERENCES Vendedores (IdVendedor)

go







CREATE TABLE CDPHumedades
(
	IdCDPHumedad		int IDENTITY (1, 1) PRIMARY KEY,
	IdArticulo 			int NULL REFERENCES Articulos(idArticulo),
	Humedad 			numeric(18,2) NULL,
	Merma				numeric(18,2) NULL	
)

go





--////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////
--9 de junio 2010
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


Create TABLE WilliamsDestinos 
(
	IdWilliamsDestino			int IDENTITY (1, 1) PRIMARY KEY,
	Descripcion					varchar(50) NULL,
	Codigo						varchar(20) NULL,
	Subcontratista1				int NULL REFERENCES Clientes(idCliente),
	Subcontratista2				int NULL REFERENCES Clientes(idCliente),
	CodigoSAJPYA				varchar(20) NULL,
	CodigoONCAA					varchar(20) NULL,
	SincronismoNoble1			varchar(20) NULL,
	SincronismoNoble2			varchar(20) NULL,
	AuxiliarString1				varchar(50) NULL,
	AuxiliarString2				varchar(50) NULL,
	AuxiliarString3				varchar(50) NULL
)
go



Create TABLE WilliamsMailFiltros
(
	IdWilliamsMailFiltro int IDENTITY (1, 1) PRIMARY KEY,

	Descripcion			varchar(50) NULL,
	Emails				varchar(150) NULL,
	
	FechaDesde				datetime NULL,
	FechaHasta				datetime NULL,
	
	EsPosicion			varchar(6) NULL, --posicion o descarga

	Enviar				varchar(6) NULL,
	EsMailOesFax		varchar(6) NULL,

	Orden				int NULL,
	Modo				varchar(6) NULL,--local, ambas o exportacion
	
	AplicarANDuORalFiltro varchar(6) NULL,
	Vendedor			int NULL REFERENCES Clientes(idCliente),
	CuentaOrden1		int NULL REFERENCES Clientes(idCliente),
	CuentaOrden2		int NULL REFERENCES Clientes(idCliente),
	Corredor			int NULL REFERENCES Vendedores(idVendedor),
	Entregador			int NULL REFERENCES Clientes(idCliente),

	IdArticulo			int NULL REFERENCES Articulos(idArticulo),

	Contrato			int NULL,

	Destino				int NULL REFERENCES WilliamsDestinos(idWilliamsDestino),
	Procedencia			int NULL REFERENCES Localidades(idLocalidad),

	AuxiliarString1		varchar(50) NULL,
	AuxiliarString2		varchar(50) NULL,

	UltimoResultado varchar(100) NULL
)
go






--////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////
--16 de agosto 2010
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////

Create TABLE DiccionarioEquivalencias
(
	IdDiccionarioEquivalencia int IDENTITY (1, 1) PRIMARY KEY,

	Palabra				varchar(100) ,
	Traduccion			varchar(100) ,
	
	Tabla				varchar(50) NULL
)
go






--////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////
--18 de agosto 2010
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////
 
Create TABLE ExcelImportador
(
	IdExcelImportador int IDENTITY (1, 1) PRIMARY KEY,

	IdTanda					int,
	FechaIngreso			datetime NULL,
	IdUsuarioIngreso		int NULL , 
	FechaTimeStamp			timestamp,


	Estado					varchar(50) NULL,
	check1					varchar(50) NULL,
	URLgenerada				varchar(50) NULL,
	IdTitular				varchar(50) NULL,
	IdIntermediario			varchar(50) NULL,
	IdRComercial			varchar(50) NULL,
	IdCorredor				varchar(50) NULL,
	IdDestinatario			varchar(50) NULL,
	IdChofer				varchar(50) NULL,


	Producto				varchar(50) NULL,
	Titular					varchar(50) NULL,
	Intermediario			varchar(50) NULL,
	RComercial				varchar(50) NULL,
	Corredor				varchar(50) NULL,
	
	Procedencia				varchar(50) NULL,
	Patente					varchar(50) NULL,
	NumeroCDP				varchar(50) NULL,
	Acoplado				varchar(50) NULL,
	NetoProc				varchar(50) NULL,
	Calidad					varchar(50) NULL,
	

	
	
	column12				varchar(50) NULL,
	column13				varchar(50) NULL,
	column14				varchar(50) NULL,
	column15				varchar(50) NULL,
	column16				varchar(50) NULL,
	column17				varchar(50) NULL,
	column18				varchar(50) NULL,
	column19				varchar(50) NULL,
	column20				varchar(50) NULL,
	column21				varchar(50) NULL,
	column22				varchar(50) NULL,
	column23				varchar(50) NULL,
	column24				varchar(50) NULL,
	column25				varchar(50) NULL,

	Comprador				varchar(50) NULL,
	Destino					varchar(50) NULL,
	Subcontratista1			varchar(50) NULL,
	Subcontratista2			varchar(50) NULL,
	FechaDescarga			varchar(50) NULL,
	Hora					varchar(50) NULL,



	Auxiliar1				varchar(50) NULL,
	Auxiliar2				varchar(50) NULL,
	Auxiliar3				varchar(50) NULL,
	Auxiliar4				varchar(50) NULL,
	Auxiliar5				varchar(50) NULL


)
go



CREATE INDEX IDX_ExcelImportador_IdTanda
on ExcelImportador (IdTanda)
go




--////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////
--2 oct 2010
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////


ALTER TABLE ListasPreciosDetalle 
	ALTER COLUMN PrecioDescargaLocal money NULL
ALTER TABLE ListasPreciosDetalle 
	ALTER COLUMN PrecioDescargaExportacion money NULL
ALTER TABLE ListasPreciosDetalle 
	ALTER COLUMN PrecioCaladaLocal money NULL 
ALTER TABLE ListasPreciosDetalle 
	ALTER COLUMN PrecioCaladaExportacion money NULL 
go
ALTER TABLE ListasPreciosDetalle 
	ALTER COLUMN PrecioRepetidoPeroConPrecision money NULL 
go






ALTER TABLE ListasPreciosDetalle 
	ADD constraint U_DetalleWilliams unique NONCLUSTERED (IdListaPrecios,IdArticulo,IdDestinoDeCartaDePorte)
go







--////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////
--22 de marzo 2011
--/////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////



Create TABLE _Temp_Requerimientos_TX_PendientesDeAsignar
(
			 IdDetalleRequerimiento INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecibida NUMERIC(18,2),
			 CantidadVales NUMERIC(18,2),
			 CantidadEnStock NUMERIC(18,2),
			 IdDetalleRecepcion INTEGER
			)

GO


Create TABLE _Temp_Requerimientos_TX_Pendientes1
(
			 IdDetalleRequerimiento INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecibida NUMERIC(18,2),
			 CantidadVales NUMERIC(18,2),
			 CantidadEnStock NUMERIC(18,2),
			 IdAutorizacionPorComprobante INTEGER,
			)

GO



CREATE TABLE [dbo].[CartasPorteMovimientos]
(
	IdCDPMovimiento int IDENTITY (1, 1) PRIMARY KEY,
	NumeroCDPMovimiento int,

	---------------------------------------------
	---------------------------------------------
	--cosas que van pegadas genericamente a toda entidad pronto

	IdUsuarioIngreso int NULL , --REFERENCES Empleados(idEmpleado),
	FechaIngreso datetime NULL,
	--FechaRegistracion datetime,

	Anulada varchar(2) NULL,
	IdUsuarioAnulo int NULL,
	FechaAnulacion datetime NULL,

	Observaciones varchar(200) NULL,
	FechaTimeStamp		timestamp,
	---------------------------------------------
	--------------------------------------------


	
	
	
	IdAjusteStock int null REFERENCES AjustesStock(idAjusteStock),
	
	
	IdCartaDePorte int null REFERENCES CartasDePorte(idCartaDePorte),
	

	Entrada_o_Salida int ,

	IdExportadorOrigen int NULL REFERENCES Clientes(idCliente),
	IdExportadorDestino int NULL REFERENCES Clientes(idCliente),

	
	Tipo	int,	--??
	Contrato varchar(40) NULL,
	Puerto	int NULL, --no sé si apuntará a Localidad o DestinoWilliams
	Vapor	varchar(40) NULL,
	Numero	varchar(40) NULL,


	--------------------------------------------
	IdArticulo			int NULL REFERENCES Articulos(idArticulo),
	Cantidad			numeric(12,2) NULL,

	
	-------------------------------------------
	IdStock				int NULL,
	Partida				varchar(20) NULL,
	IdUnidad			int NULL, -- REFERENCES Unidades(idUnidad),
	IdUbicacion			int NULL
	-------------------------------------------

)





CREATE TABLE [dbo].[WilliamsMailFiltrosCola](
	[IdWilliamsMailFiltroCola] [int] IDENTITY(1,1) PRIMARY KEY,
	[IdWilliamsMailFiltro] [int] NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[Emails] [varchar](250) NULL,
	[FechaDesde] [datetime] NULL,
	[FechaHasta] [datetime] NULL,
	[EsPosicion] [varchar](6) NULL,
	[Enviar] [varchar](6) NULL,
	[EsMailOesFax] [varchar](6) NULL,
	[Orden] [int] NULL,
	[Modo] [varchar](6) NULL,
	[AplicarANDuORalFiltro] [varchar](6) NULL,
	[Vendedor] [int] NULL,
	[CuentaOrden1] [int] NULL,
	[CuentaOrden2] [int] NULL,
	[Corredor] [int] NULL,
	[Entregador] [int] NULL,
	[IdArticulo] [int] NULL,
	[Contrato] [int] NULL,
	[Destino] [int] NULL,
	[Procedencia] [int] NULL,
	[AuxiliarString1] [varchar](50) NULL,
	[AuxiliarString2] [varchar](50) NULL,
	[UltimoResultado] [varchar](100) NULL,
	[PuntoVenta] [int] NULL,
	[QueContenga] [varchar](100) NULL,
	[EstadoDeCartaPorte] [varchar](20) NULL,
	[IdUsuarioEncolo] [int] NULL
	)
GO



CREATE TABLE [dbo].[CDPEstablecimientos](
	[IdEstablecimiento] [int] IDENTITY(1,1) PRIMARY KEY,
	[Descripcion] [varchar](50),
	[IdLocalidad] int NULL
)
go




--drop table wTempCartasPorteFacturacionAutomatica
create table wTempCartasPorteFacturacionAutomatica  (
	IdTempCartasPorteFacturacionAutomatica  [int] IDENTITY(1,1) PRIMARY KEY,
	IdSesion int,
	IdCartaDePorte int,
	IdFacturarselaA int,
	ColumnaTilde int,
	IdArticulo int,
	NumeroCartaDePorte bigint,
	SubNumeroVagon  int,
	SubnumeroDeFacturacion int,
	FechaArribo datetime,
	FechaDescarga datetime,
	FacturarselaA varchar(50),
	Confirmado varchar(2),
	IdCodigoIVA int,
	CUIT varchar(50),
	ClienteSeparado varchar(50),
	TarifaFacturada  numeric(18,2),
	Producto varchar(50),
	KgNetos  numeric(18,2),
	IdCorredor int,
	IdTitular int,
	IdIntermediario int,
	IdRComercial int,
	Titular varchar(50),
	RComercial varchar(50),
	Corredor varchar(50),
	Destinatario varchar(50),
	Procedcia varchar(50),
	DestinoDesc  varchar(50),
	IdDestino int
	)
go


--drop table PlantillasXML  
create table PlantillasXML  (
	IdPlantilla [int] IDENTITY(1,1) PRIMARY KEY,
	NombreUnico varchar(50) UNIQUE,
	NombreArchivo varchar(50),
	BinarioPlantillaXML image,
	Observaciones varchar(200) NULL
)
go







CREATE TABLE [dbo].[CartasDePorteHistorico](
	[IdCartaDePorte] [int] NOT NULL,
	[NumeroCartaDePorte] [bigint] NULL,
	[IdUsuarioIngreso] [int] NULL,
	[FechaIngreso] [datetime] NULL,
	[Anulada] [varchar](2) NULL,
	[IdUsuarioAnulo] [int] NULL,
	[FechaAnulacion] [datetime] NULL,
	[Observaciones] [varchar](200) NULL,
	[FechaTimeStamp] [timestamp] NULL,
	[Vendedor] [int] NULL,
	[CuentaOrden1] [int] NULL,
	[CuentaOrden2] [int] NULL,
	[Corredor] [int] NULL,
	[Entregador] [int] NULL,
	[Procedencia] [varchar](30) NULL,
	[Patente] [varchar](30) NULL,
	[IdArticulo] [int] NULL,
	[IdStock] [int] NULL,
	[Partida] [varchar](20) NULL,
	[IdUnidad] [int] NULL,
	[IdUbicacion] [int] NULL,
	[Cantidad] [numeric](12, 2) NULL,
	[Cupo] [varchar](30) NULL,
	[NetoProc] [numeric](18, 2) NULL,
	[Calidad] [varchar](30) NULL,
	[BrutoPto] [numeric](18, 2) NULL,
	[TaraPto] [numeric](18, 2) NULL,
	[NetoPto] [numeric](18, 2) NULL,
	[Acoplado] [varchar](30) NULL,
	[Humedad] [numeric](18, 2) NULL,
	[Merma] [numeric](18, 2) NULL,
	[NetoFinal] [numeric](18, 2) NULL,
	[FechaDeCarga] [datetime] NULL,
	[FechaVencimiento] [datetime] NULL,
	[CEE] [varchar](20) NULL,
	[IdTransportista] [int] NULL,
	[TransportistaCUITdesnormalizado] [varchar](13) NULL,
	[IdChofer] [int] NULL,
	[ChoferCUITdesnormalizado] [varchar](13) NULL,
	[CTG] [int] NULL,
	[Contrato] [varchar](20) NULL,
	[Destino] [int] NULL,
	[Subcontr1] [int] NULL,
	[Subcontr2] [int] NULL,
	[Contrato1] [int] NULL,
	[contrato2] [int] NULL,
	[KmARecorrer] [numeric](18, 2) NULL,
	[Tarifa] [numeric](18, 2) NULL,
	[FechaDescarga] [datetime] NULL,
	[Hora] [datetime] NULL,
	[NRecibo] [int] NULL,
	[CalidadDe] [int] NULL,
	[TaraFinal] [numeric](18, 2) NULL,
	[BrutoFinal] [numeric](18, 2) NULL,
	[Fumigada] [numeric](18, 2) NULL,
	[Secada] [numeric](18, 2) NULL,
	[Exporta] [varchar](2) NULL,
	[NobleExtranos] [numeric](18, 2) NULL,
	[NobleNegros] [numeric](18, 2) NULL,
	[NobleQuebrados] [numeric](18, 2) NULL,
	[NobleDaniados] [numeric](18, 2) NULL,
	[NobleChamico] [numeric](18, 2) NULL,
	[NobleChamico2] [numeric](18, 2) NULL,
	[NobleRevolcado] [numeric](18, 2) NULL,
	[NobleObjetables] [numeric](18, 2) NULL,
	[NobleAmohosados] [numeric](18, 2) NULL,
	[NobleHectolitrico] [numeric](18, 2) NULL,
	[NobleCarbon] [numeric](18, 2) NULL,
	[NoblePanzaBlanca] [numeric](18, 2) NULL,
	[NoblePicados] [numeric](18, 2) NULL,
	[NobleMGrasa] [numeric](18, 2) NULL,
	[NobleAcidezGrasa] [numeric](18, 2) NULL,
	[NobleVerdes] [numeric](18, 2) NULL,
	[NobleGrado] [int] NULL,
	[NobleConforme] [varchar](2) NULL,
	[NobleACamara] [varchar](2) NULL,
	[Cosecha] [varchar](20) NULL,
	[HumedadDesnormalizada] [numeric](18, 2) NULL,
	[Factor] [numeric](18, 2) NULL,
	[IdFacturaImputada] [int] NULL,
	[PuntoVenta] [int] NULL,
	[SubnumeroVagon] [int] NULL,
	[TarifaFacturada] [numeric](18, 2) NULL,
	[TarifaSubcontratista1] [numeric](18, 2) NULL,
	[TarifaSubcontratista2] [numeric](18, 2) NULL,
	[FechaArribo] [datetime] NULL,
	[Version] [int] NULL,
	[MotivoAnulacion] [varchar](100) NULL,
	[NumeroSubfijo] [int] NULL,
	[IdEstablecimiento] [int] NULL,
	[EnumSyngentaDivision] [varchar](10) NULL,
	[Corredor2] [int] NULL,
	[IdUsuarioModifico] [int] NULL,
	[FechaModificacion] [datetime] NULL,
	[FechaEmision] [datetime] NULL,
	[EstaArchivada] [varchar](2) NULL,
	[ExcluirDeSubcontratistas] [varchar](2) NULL,
	[IdTipoMovimiento] [int] NULL,
	[IdClienteAFacturarle] [int] NULL,
	[SubnumeroDeFacturacion] [int] NULL,
	[AgregaItemDeGastosAdministrativos] [varchar](2) NULL,
	[CalidadGranosQuemados] [numeric](18, 2) NULL,
	[CalidadGranosQuemadosBonifica_o_Rebaja] [varchar](2) NULL,
	[CalidadTierra] [numeric](18, 2) NULL,
	[CalidadTierraBonifica_o_Rebaja] [varchar](2) NULL,
	[CalidadMermaChamico] [numeric](18, 2) NULL,
	[CalidadMermaChamicoBonifica_o_Rebaja] [varchar](2) NULL,
	[CalidadMermaZarandeo] [numeric](18, 2) NULL,
	[CalidadMermaZarandeoBonifica_o_Rebaja] [varchar](2) NULL,
	[FueraDeEstandar] [varchar](2) NULL,
	[CalidadPuntaSombreada] [numeric](18, 2) NULL,
) 

GO


create table InformesWeb  (
	IdInformeWeb [int] IDENTITY(1,1) PRIMARY KEY,
	NombreUnico varchar(50) UNIQUE,
	URL varchar(300),
	Observaciones varchar(200) NULL
)
go





