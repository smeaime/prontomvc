--use DemoProntovarchar(5


--Mariano tenes que cambiar el SP Tree_Generar y en la creacion del #Auxiliar0
--agrandar el campo Clave VARCHAR(100) (originalmente 50),  

--y en la tabal Tree
--agrandar los campos 
-- IdItem VARCHAR(30),  
-- Clave VARCHAR(100),  
--Yo ya lo tengo arreglado pero documentalo vos
--Saludos

--Si cambias eso hay que cambiar tambien el largo de Nodo en EmpleadosAceesos



--ALTER TABLE empleadosaccesos ALTER COLUMN Nodo varchar(100) NULL


[Tree_TX_Generar]
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tree]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[Tree]
GO

CREATE TABLE [dbo].[Tree] (
	[IdItem] [varchar] (30) COLLATE Modern_Spanish_CI_AS NOT NULL ,
	[Clave] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL ,
	[Descripcion] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL ,
	[ParentId] [varchar] (30) COLLATE Modern_Spanish_CI_AS NULL ,
	[Orden] [int] NULL ,
	[Parametros] [varchar] (50) COLLATE Modern_Spanish_CI_AS NULL ,
	[Link] [varchar] (200) COLLATE Modern_Spanish_CI_AS NULL ,
	[Imagen] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL ,
	[EsPadre] [varchar] (2) COLLATE Modern_Spanish_CI_AS NULL ,
	[GrupoMenu] [varchar] (30) COLLATE Modern_Spanish_CI_AS NULL 
) ON [PRIMARY]
GO



--ALTER TABLE [dbo].[Tree] WITH NOCHECK ADD 
--	CONSTRAINT [PK_Tree] PRIMARY KEY  CLUSTERED 
--	(
--		[IdItem]
--	)  ON [PRIMARY] 
--GO










if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tree_TX_Arbol]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [dbo].[Tree_TX_Arbol]
GO

CREATE Procedure [dbo].[Tree_TX_Arbol]
@GrupoMenu varchar(30) = Null
AS 
SET @GrupoMenu=IsNull(@GrupoMenu,'Principal')
SELECT *
FROM Tree
WHERE GrupoMenu=@GrupoMenu   --poner indice acá
ORDER BY IdItem, Orden
GO





ALTER Procedure [dbo].[Tree_TX_Generar]  
  
AS   

DECLARE @Directorio as varchar(50), @BasePRONTOMANT varchar(50), @TipoComprobante int, @IdObra int, @Año int, @Mes int, @Obra varchar(30), @NombreMes varchar(15),   
		@Parent varchar(30), @Parent2 varchar(30), @Parent3 varchar(30), @Clave varchar(30), @FechaInicial varchar(10), @FechaFinal varchar(10), @Fecha datetime, 
		@ActivarCircuitoChequesDiferidos varchar(2), @FechaArranqueCajaYBancos datetime

SET @Directorio='Pronto2'    
--SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')    
SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')
SET @FechaArranqueCajaYBancos=ISNULL((Select FechaArranqueCajaYBancos From Parametros Where IdParametro=1),Convert(datetime,'01/01/1980'))

CREATE TABLE #Auxiliar0     
   (    
    IdItem VARCHAR(30) COLLATE Modern_Spanish_CI_AS NULL ,        
    Clave VARCHAR(100)  COLLATE Modern_Spanish_CI_AS NULL ,    
    Descripcion VARCHAR(100) COLLATE Modern_Spanish_CI_AS NULL ,        
    ParentId VARCHAR(30) COLLATE Modern_Spanish_CI_AS NULL ,        
    Orden INTEGER,    
    Parametros VARCHAR(50) COLLATE Modern_Spanish_CI_AS NULL ,       
    Link VARCHAR(200) COLLATE Modern_Spanish_CI_AS NULL ,     
    Imagen VARCHAR(100) COLLATE Modern_Spanish_CI_AS NULL ,       
    EsPadre VARCHAR(2) COLLATE Modern_Spanish_CI_AS NULL ,        
    GrupoMenu VARCHAR(30) COLLATE Modern_Spanish_CI_AS NULL        
   )    
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar0 (IdItem) ON [PRIMARY]    
    
CREATE TABLE #Auxiliar1     
   (    
    TipoComprobante INTEGER,    
    IdObra INTEGER,    
    Obra VARCHAR(30),    
    Año INTEGER,    
    Mes INTEGER    
   )    
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (TipoComprobante, Obra, IdObra, Año, Mes) ON [PRIMARY]    

CREATE TABLE #Auxiliar2     
   (    
    IdEntidad INTEGER,    
    Entidad VARCHAR(50)    
   )    
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdEntidad) ON [PRIMARY]    
    
CREATE TABLE #Auxiliar3     
   (    
    IdEntidad2 INTEGER,    
    Entidad2 VARCHAR(50)    
   )    
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdEntidad2) ON [PRIMARY]    
    

INSERT INTO #Auxiliar1     
 SELECT DISTINCT 103, Null, Null, Year(FechaRequerimiento), Month(FechaRequerimiento)   
 FROM Requerimientos   
 ORDER BY Year(FechaRequerimiento), Month(FechaRequerimiento) desc    
  
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 1030, IsNull(Requerimientos.IdObra,0), IsNull(Obras.NumeroObra,''), Null, Null    
 FROM Requerimientos    
 LEFT OUTER JOIN Obras ON Obras.IdObra=Requerimientos.IdObra    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 104, Null, Null, Year(FechaIngreso), Month(FechaIngreso) FROM Presupuestos ORDER BY Year(FechaIngreso), Month(FechaIngreso) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 140, Null, Null, Year(FechaOrdenCompra), Month(FechaOrdenCompra) FROM OrdenesCompra ORDER BY Year(FechaOrdenCompra), Month(FechaOrdenCompra) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 41, Null, Null, Year(FechaRemito), Month(FechaRemito) FROM Remitos ORDER BY Year(FechaRemito), Month(FechaRemito) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 1, Null, Null, Year(FechaFactura), Month(FechaFactura) FROM Facturas ORDER BY Year(FechaFactura), Month(FechaFactura) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 2, Null, Null, Year(FechaRecibo), Month(FechaRecibo) FROM Recibos ORDER BY Year(FechaRecibo), Month(FechaRecibo) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 3, Null, Null, Year(FechaNotaDebito), Month(FechaNotaDebito) FROM NotasDebito ORDER BY Year(FechaNotaDebito), Month(FechaNotaDebito) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 4, Null, Null, Year(FechaNotaCredito), Month(FechaNotaCredito) FROM NotasCredito ORDER BY Year(FechaNotaCredito), Month(FechaNotaCredito) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 14, Null, Null, Year(FechaDeposito), Month(FechaDeposito) FROM DepositosBancarios ORDER BY Year(FechaDeposito), Month(FechaDeposito) desc    

INSERT INTO #Auxiliar1     
 SELECT DISTINCT 17, Null, Null, Year(FechaOrdenPago), Month(FechaOrdenPago) FROM OrdenesPago ORDER BY Year(FechaOrdenPago), Month(FechaOrdenPago) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 51, Null, Null, Year(FechaPedido), Month(FechaPedido) FROM Pedidos  ORDER BY Year(FechaPedido), Month(FechaPedido) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 105, Null, Null, Year(Fecha), Month(Fecha) FROM Comparativas  ORDER BY Year(Fecha), Month(Fecha) desc    
    
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 106, Null, Null, Year(FechaAjuste), Month(FechaAjuste) FROM AjustesStock  ORDER BY Year(FechaAjuste), Month(FechaAjuste) desc    

INSERT INTO #Auxiliar1     
 SELECT DISTINCT 60, Null, Null, Year(FechaRecepcion), Month( FechaRecepcion) FROM Recepciones ORDER BY Year(FechaRecepcion), Month(FechaRecepcion) desc    
  
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 600, Null, Null, Year(FechaRecepcion), Month( FechaRecepcion) FROM ComprobantesProveedores   
 WHERE IdProveedor is null and IdCuenta is not null   
 ORDER BY Year(FechaRecepcion), Month(FechaRecepcion) desc    
  
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 50, Null, Null, Year(FechaSalidaMateriales), Month(FechaSalidaMateriales) FROM SalidasMateriales  ORDER BY Year(FechaSalidaMateriales), Month(FechaSalidaMateriales) desc    

INSERT INTO #Auxiliar1     
 SELECT DISTINCT 108, Null, Null, Year(FechaOtroIngresoAlmacen), Month(FechaOtroIngresoAlmacen) FROM OtrosIngresosAlmacen  ORDER BY Year(FechaOtroIngresoAlmacen), Month(FechaOtroIngresoAlmacen) desc    

INSERT INTO #Auxiliar1     
 SELECT DISTINCT 9100, isnull(ComprobantesProveedores.idcuenta,0), Left( cuentas.descripcion,30), null, null  
 FROM ComprobantesProveedores   
 LEFT OUTER JOIN  cuentas on cuentas.idcuenta=ComprobantesProveedores.idcuenta  
 WHERE IdProveedor is null and ComprobantesProveedores.IdCuenta is not null   
   
INSERT INTO #Auxiliar1     
 SELECT DISTINCT 91002, isnull(ComprobantesProveedores.NumeroRendicionFF,0), Left(cuentas.descripcion,30), ComprobantesProveedores.IdCuenta, null  
 FROM ComprobantesProveedores   
 LEFT OUTER JOIN  cuentas on cuentas.idcuenta=ComprobantesProveedores.idcuenta  
 WHERE IdProveedor is null and ComprobantesProveedores.IdCuenta is not null   

INSERT INTO #Auxiliar1     
 SELECT DISTINCT -100, Null, Null, Year(FechaComprobante), Month(FechaComprobante) FROM Subdiarios ORDER BY Year(FechaComprobante), Month(FechaComprobante) desc    

INSERT INTO #Auxiliar1     
 SELECT DISTINCT -101, Null, Null, Year(FechaAsiento), Month(FechaAsiento) FROM Asientos ORDER BY Year(FechaAsiento), Month(FechaAsiento) desc    
  
INSERT INTO #Auxiliar1     
 SELECT DISTINCT -102, Null, Null, Year(FechaComprobante), Month(FechaComprobante) FROM Valores WHERE Estado='G' ORDER BY Year(FechaComprobante), Month(FechaComprobante) desc    
  
/*   Conciliaciones bancos   */
INSERT INTO #Auxiliar1
 SELECT DISTINCT 
  -103, 
  Case When v.Estado='D' Then v.IdCuentaBancariaDeposito Else v.IdCuentaBancaria End, 
  Null, 
  Year(Case When IsNull(v.Estado,'')='D' Then IsNull(v.FechaDeposito,v.FechaComprobante) When IsNull(v.Estado,'')='G' Then v.FechaComprobante Else Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End End), 
  Month(Case When IsNull(v.Estado,'')='D' Then IsNull(v.FechaDeposito,v.FechaComprobante) When IsNull(v.Estado,'')='G' Then v.FechaComprobante Else Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End End) 
 FROM Valores v 
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON v.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras bc ON dopv.IdBancoChequera=bc.IdBancoChequera
 WHERE v.FechaComprobante is not null and 
	(
	 (v.Estado='D' and IsNull(v.FechaDeposito,v.FechaComprobante)>=@FechaArranqueCajaYBancos) 
	 or  
	 ((v.IdTipoComprobante=17 or v.IdDetalleComprobanteProveedor is not null) and 
	  Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End >=@FechaArranqueCajaYBancos and 
	  not (@ActivarCircuitoChequesDiferidos='SI' and v.IdTipoValor=6 and IsNull(bc.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(v.RegistroContableChequeDiferido,'NO')='NO'))
	 or
	 (v.Estado='G' and v.FechaComprobante>=@FechaArranqueCajaYBancos)
	 or 
	 (not (v.IdTipoComprobante=17 or v.IdDetalleComprobanteProveedor is not null) and v.Estado is null and 
	  Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End >=@FechaArranqueCajaYBancos and 
	  not (@ActivarCircuitoChequesDiferidos='SI' and v.IdTipoValor=6 and IsNull(bc.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(v.RegistroContableChequeDiferido,'NO')='NO'))
	 )
 ORDER BY Year(Case When IsNull(v.Estado,'')='D' Then IsNull(v.FechaDeposito,v.FechaComprobante) When IsNull(v.Estado,'')='G' Then v.FechaComprobante Else Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End End), 
			Month(Case When IsNull(v.Estado,'')='D' Then IsNull(v.FechaDeposito,v.FechaComprobante) When IsNull(v.Estado,'')='G' Then v.FechaComprobante Else Case When IsNull(v.RegistroContableChequeDiferido,'NO')='SI' Then v.FechaValor Else v.FechaComprobante End End) desc    

/*   Conciliaciones cajas   */
INSERT INTO #Auxiliar1
 SELECT DISTINCT 
  -104, 
  v.IdCaja, 
  Null, 
  Year(Case When v.IdBancoDeposito is not null and v.FechaDeposito is not null Then v.FechaDeposito Else v.FechaComprobante End), 
  Month(Case When v.IdBancoDeposito is not null and v.FechaDeposito is not null Then v.FechaDeposito Else v.FechaComprobante End) 
 FROM Valores v 
 WHERE IsNull(v.IdCaja,0)>0
 ORDER BY Year(Case When v.IdBancoDeposito is not null and v.FechaDeposito is not null Then v.FechaDeposito Else v.FechaComprobante End), 
			Month(Case When v.IdBancoDeposito is not null and v.FechaDeposito is not null Then v.FechaDeposito Else v.FechaComprobante End) desc    

/*   Conciliaciones tarjetas   */
INSERT INTO #Auxiliar1
 SELECT DISTINCT -105, v.IdTarjetaCredito, Null,  Year(v.FechaComprobante), Month(v.FechaComprobante) 
 FROM Valores v 
 WHERE IsNull(v.IdTarjetaCredito,0)>0
 ORDER BY Year(v.FechaComprobante), Month(v.FechaComprobante) desc    

/*   Resumenes de Conciliaciones   */
INSERT INTO #Auxiliar1     
 SELECT DISTINCT -106, Null, Null, Year(FechaFinal), Month(FechaFinal) FROM Conciliaciones  ORDER BY Year(FechaFinal), Month(FechaFinal) desc    


 TRUNCATE TABLE tree
--INSERT INTO #Auxiliar0 Select '01','Ppal','PRINCIPAL',Null,1,Null,Null,'Ppal','SI','Principal'    
  
INSERT INTO #Auxiliar0 Select '01-01','Tablas Generales','Generales','01',1,Null,Null,'TablasG','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-01-01','ArchivosATransmitirDestinos','Novedades','01-01',1,Null,Null,'ArchivosATransmitirDestinos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-01-02','Localidades','Localidades','01-01',2,Null,'<a href="/' + @Directorio + '/Localidad/Index">Localidades</a>','Localidades','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-01-03','Monedas','Monedas','01-01',3,Null,'<a href="/' + @Directorio + '/Moneda/Index">Monedas</a>','Monedas','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-01-04','Paises','Paises','01-01',4,Null,'<a href="/' + @Directorio + '/Pais/Index">Paises</a>','Paises','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-01-05','Provincias','Provincias','01-01',5,Null,'<a href="/' + @Directorio + '/Provincia/Index">Provincias</a>','Provincias','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-01-06','TiposComprobante','Tipos de comprobante','01-01',6,Null,'<a href="/' + @Directorio + '/TiposComprobante/Index">Tipos de comprobante</a>','TiposComprobante','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-01-07','Traducciones','Traducciones','01-01',7,Null,Null,'Traducciones','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-01-08','Transportistas','Transportistas','01-01',8,Null,'<a href="/' + @Directorio + '/Transportista/Index">Transportistas</a>','Transportistas','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-02','Articulos','Artículos','01',1,Null,Null,'Articulos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-01','ArticulosTodos','Todos','01-02',1,Null,Null,'Articulos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-01-02','ArticulosTodosDetallados','Detallados','01-02-01',2,Null,'<a href="/' + @directorio + '/Articulo/Index">Detallados</a>','Detallados','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-01-03','ArticulosTodosResumidos','Resumidos','01-02-01',3,Null,'<a href="/' + @directorio + '/Articulo/IndexResumido">Resumidos</a>','Resumidos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-04','ArticulosRubros','Por rubros','01-02',4,Null,Null,'Articulos','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-05','ArticulosEquiposTerceros','Equipos de terceros','01-02',5,Null,Null,'Articulos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-06','ArticulosInactivos','Inactivos','01-02',6,Null,Null,'Articulos','NO','Principal'  
If Len(@BasePRONTOMANT)>0   
	INSERT INTO #Auxiliar0 Select '01-02-07','ArticulosProntoMantenimiento','Mantenimiento','01-02',7,Null,Null,'Articulos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-08','DefinicionesArt','Máscaras','01-02',8,Null,Null,'DefinicionesArt','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-08-01','DefinicionesArtTodos','Todas','01-02-08',1,Null,Null,'DefinicionesArt','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-08-02','DefinicionesArtRubros','Por rubros','01-02-08',2,Null,Null,'DefinicionesArt','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-09','Rubros','Rubros','01-02',9,Null,'<a href="/' + @Directorio + '/Rubro/Index">Rubros</a>','Rubros','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-10','Subrubros','Subrubros','01-02',10,Null,'<a href="/' + @Directorio + '/Subrubro/Index">Subrubros</a>','Subrubros','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-11','Conjuntos','Conjuntos','01-02',11,Null,Null,'Conjuntos','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-11-01','ConjuntosTodos','Todos','01-02-11',1,Null,Null,'Conjuntos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-11-02','ConjuntosFinales','Finales','01-02-11',2,Null,Null,'Conjuntos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-11-03','ConjuntosDependientes','Subconjuntos','01-02-11',3,Null,Null,'Conjuntos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-12','ItemsPopUpMateriales','Menu desplegable','01-02',12,Null,Null,'ItemsPopUpMateriales','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-13','Depositos','Depositos','01-02',13,Null,'<a href="/' + @Directorio + '/Deposito/Index">Depositos</a>','Depositos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-14','Ubicaciones','Ubicaciones','01-02',14,Null,'<a href="/' + @Directorio + '/Ubicacion/Index">Ubicaciones</a>','Ubicaciones','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15','Tablas relacionadas','Tablas relacionadas','01-02',15,Null,Null,'TablasG','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-01','Acabados','Acabados','01-02-15',1,Null,Null,'Acabados','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-02','AlimentacionesElectricas','Alimentaciones Electricas','01-02-15',2,Null,Null,'AlimentacionesElectricas','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-03','AniosNorma','Años y Adenda de Normas','01-02-15',3,Null,Null,'AniosNorma','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-04','Biselados','Biselados','01-02-15',4,Null,Null,'Biselados','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-05','Calidades','Calidades','01-02-15',5,Null,Null,'Calidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-06','CalidadesClad','Calidades clad','01-02-15',6,Null,Null,'CalidadesClad','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-07','Codigos','Codigos','01-02-15',7,Null,Null,'Codigos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-08','CodigosUniversales','Codigos Universales','01-02-15',8,Null,Null,'CodigosUniversales','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-09','Colores','Colores','01-02-15',9,Null,'<a href="/' + @Directorio + '/Color/Index">Colores</a>','Colores','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-10','ControlesCalidad','Controles de Calidad','01-02-15',10,Null,'<a href="/' + @Directorio + '/ControlCalidad/Index">Controles de Calidad</a>','ControlesCalidad','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-11','Densidades','Densidades','01-02-15',11,Null,Null,'Densidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-12','Formas','Formas','01-02-15',12,Null,Null,'Formas','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-13','Grados','Grados','01-02-15',13,Null,Null,'Grados','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-14','Marcas','Marcas','01-02-15',14,Null,'<a href="/' + @Directorio + '/Marca/Index">Marcas</a>','Marcas','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-15','Materiales','Materiales','01-02-15',15,Null,'<a href="/' + @Directorio + '/Material/Index">Materiales</a>','Materiales','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-16','Modelos','Modelos','01-02-15',16,Null,'<a href="/' + @Directorio + '/Modelo/Index">Modelos</a>','Modelos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-17','Normas','Normas','01-02-15',17,Null,Null,'Normas','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-18','Rangos','Rangos','01-02-15',18,Null,Null,'Rangos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-19','Relaciones','Relaciones','01-02-15',19,Null,Null,'Relaciones','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-20','Schedulers','Schedulers','01-02-15',20,Null,Null,'Schedulers','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-21','Series','Series','01-02-15',21,Null,Null,'Series','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-22','Tipos','Tipos genericos','01-02-15',22,Null,'<a href="/' + @Directorio + '/Tipo/IndexGenericos">Tipos genericos</a>','Tipos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-23','TiposArticulos','Tipos de articulo','01-02-15',23,Null,'<a href="/' + @Directorio + '/Tipo/IndexArticulos">Tipos de articulo</a>','Tipos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-24','TiposRosca','Tipos 2','01-02-15',24,Null,Null,'TiposRosca','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-02-15-25','TTermicos','Tratamientos Termicos','01-02-15',25,Null,Null,'TTermicos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-02-15-26','Unidades','Unidades','01-02-15',26,Null,'<a href="/' + @Directorio + '/Unidad/Index">Unidades</a>','Unidades','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-03','Personal','Personal','01',1,Null,Null,'Empleados','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-03-01','Empleados','Personal','01-03',1,Null,Null,'Empleados','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-03-01-01','Empleados1','De Obra','01-03-01',1,Null,Null,'Empleados','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-03-01-02','Empleados2','Usuarios','01-03-01',2,Null,Null,'Empleados','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-03-01-03','Empleados3','Todos','01-03-01',3,Null,'<a href="/' + @Directorio + '/Empleado/Index">Todos</a>','Empleados','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-03-02','Vendedores','Vendedores','01-03',2,Null,'<a href="/' + @Directorio + '/Vendedor/Index">Vendedores</a>','Vendedores','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-03-03','Cargos','Cargos','01-03',3,Null,'<a href="/' + @Directorio + '/Cargo/Index">Cargos</a>','Cargos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-03-04','Sectores','Sectores','01-03',4,Null,'<a href="/' + @Directorio + '/Sector/Index">Sectores</a>','Sectores','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-03-05','AnticiposAlPersonal','Anticipos','01-03',5,Null,Null,'AnticiposAlPersonal','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-03-06','AnticiposAlPersonalSyJ','Anticipos via SyJ)','01-03',6,Null,Null,'AnticiposAlPersonal','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-04','Obras','Obras','01',1,Null,Null,'Obras','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-01','UnidadesOperativas','Unidades operativas','01-04',1,Null,'<a href="/' + @Directorio + '/UnidadesOperativa/Index">Unidades operativas</a>','UnidadesOperativas','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-02','GruposObras','Grupos de obras','01-04',2,Null,'<a href="/' + @Directorio + '/GruposObra/Index">Grupos de obras</a>','GruposObras','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-03','Obras1','Obras','01-04',3,Null,'<a href="/' + @Directorio + '/Obra/Index">Obras</a>','Obras','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-04','Planos','Planos','01-04',4,Null,Null,'Planos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-05','Equipos','Equipos','01-04',5,Null,Null,'Equipos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-06','LMateriales','Lista de Materiales','01-04',6,Null,Null,'LMateriales','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-07','PresupuestoObrasRubros','Rubros para obras','01-04',7,Null,Null,'PresupuestoObrasRubros','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-08','PresupuestoObrasGruposMateriales','Grupos de materiales','01-04',8,Null,Null,'PresupuestoObrasGruposMateriales','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-09','PresupuestoObras','Presupuesto de obras','01-04',9,Null,'<a href="/' + @Directorio + '/PresupuestoObra/Index">Presupuestos de Obras</a>','PresupuestoObras','NO','Principal' 
INSERT INTO #Auxiliar0 Select '01-04-10','CertificacionesObra','Certificacion de obras','01-04',10,Null,Null,'CertificacionesObra','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-11','Subcontratos','Subcontratos','01-04',11,Null,Null,'Subcontratos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-04-12','PartesProduccion','Partes de produccion (Auxiliares)','01-04',12,Null,Null,'PartesProduccion','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-05','OrdenesTrabajo','Ordenes de trabajo','01',1,Null,Null,'OrdenesTrabajo','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-05-01','OrdenesTrabajoAgrupadas','Por Períodos','01-05',1,Null,Null,'OrdenesTrabajo','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-05-02','OrdenesTrabajoTodas','Todas','01-05',2,Null,Null,'OrdenesTrabajo','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-06','Requerimientos','Requerimientos','01',1,Null,Null,'Requerimientos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-06-01','RequerimientosAgrupados','Por Períodos','01-06',1,Null,Null,'Requerimientos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-06-02','RequerimientosPorObra','Por Obra','01-06',2,Null,Null,'Requerimientos','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-06-03','RequerimientosALiberar','A Liberar','01-06',3,Null,'<a href="/' + @directorio + '/Requerimiento/Index?bALiberar=true">A Liberar</a>','Requerimientos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-06-04','RequerimientosAConfirmar','A Confirmar','01-06',4,Null,'<a href="/' + @directorio + '/Requerimiento/Index?bAConfirmar=true">A Confirmar</a>','Requerimientos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-06-05','RequerimientosTodos','Todos','01-06',5,Null,'<a href="/' + @Directorio + '/Requerimiento/Index">Todos</a>','Requerimientos','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-06-10','RequerimientoNuevo','Todos','01-06',5,Null,'<a href="/' + @Directorio + '/Requerimiento/Edit/-1">Nuevo</a>','Requerimientos','NO','Principal'    
    
INSERT INTO #Auxiliar0 Select '01-06-06','SolicitudesCompra','Solicitudes de compra','01-06',6,Null,Null,'SolicitudesCompra','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-06-06-01','SolicitudesCompraAgrupadas','Por Períodos','01-06-06',1,Null,Null,'SolicitudesCompra','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-06-06-02','SolicitudesCompraTodas','Todos','01-06-06',2,Null,Null,'SolicitudesCompra','NO','Principal'    
    
INSERT INTO #Auxiliar0 Select '01-07','MovStock','Movimientos de stock','01',1,Null,Null,'MovStock','SI','Principal'    
--INSERT INTO #Auxiliar0 Select '01-07-01','Reservas','Reservas de stock','01-07',1,Null,Null,'Reservas','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-07-02','AjustesStock','Ajustes de stock','01-07',2,Null,Null,'AjustesStock','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-02-01','AjustesStockAgrupados','Por Períodos','01-07-02',1,Null,Null,'AjustesStock','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-02-02','AjustesStockTodos','Todos','01-07-02',2,Null,'<a href="/' + @directorio + '/AjusteStock/Index">Todos</a>','AjustesStock','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-07-03','Recepciones','Recepcion de proveedores','01-07',3,Null,Null,'Recepciones','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-03-01','RecepcionesAgrupadas','Por Períodos','01-07-03',1,Null,Null,'Recepciones','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-03-02','RecepcionesTodas','Todas','01-07-03',2,Null,'<a href="/' + @directorio + '/Recepcion/Index">Todas</a>','Recepciones','NO','Principal'  

--INSERT INTO #Auxiliar0 Select '01-07-04','CCalidades','Controles de calidad','01-07',4,Null,Null,'CCalidades','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-04-01','CCalidadesPendientes','Pendientes','01-07-04',1,Null,Null,'CCalidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-04-02','CCalidadesControlados','Controlados','01-07-04',2,Null,Null,'CCalidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-04-03','CCalidadesTodos','Todos','01-07-04',3,Null,Null,'CCalidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-05','ValesSalida','Solicitud de materiales a almacen','01-07',5,Null,Null,'ValesSalida','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-05-01','ValesSalidaAgrupados','Por Períodos','01-07-05',1,Null,Null,'ValesSalida','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-05-02','ValesSalidaTodos','Todas','01-07-05',2,Null,Null,'ValesSalida','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-07-06','SalidaMateriales','Salida de materiales de almacen','01-07',6,Null,Null,'SalidaMateriales','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-06-01','SalidaMaterialesAgrupadas','Por Períodos','01-07-06',1,Null,Null,'SalidaMateriales','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-06-02','SalidaMaterialesTodas','Todas','01-07-06',2,Null,'<a href="/' + @directorio + '/SalidaMateriales/Index">Todas</a>','SalidaMateriales','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-07-07','OtrosIngresosAlmacen','Otros ingresos a almacen','01-07',7,Null,Null,'OtrosIngresosAlmacen','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-07-01','OtrosIngresosAlmacenAgrupados','Por Períodos','01-07-07',1,Null,Null,'OtrosIngresosAlmacen','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-07-07-02','OtrosIngresosAlmacenTodos','Todos','01-07-07',2,Null,'<a href="/' + @directorio + '/OtroIngresoAlmacen/Index">Todos</a>','OtrosIngresosAlmacen','NO','Principal'  

--INSERT INTO #Auxiliar0 Select '01-07-08','UnidadesEmpaque','Unidades de empaque','01-07',8,Null,Null,'UnidadesEmpaque','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-08-01','UnidadesEmpaqueAgrupados','Unidades de empaque (por períodos)','01-07-08',1,Null,Null,'UnidadesEmpaque','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-08-02','UnidadesEmpaqueTodos','Unidades de empaque (Todas)','01-07-08',2,Null,Null,'UnidadesEmpaque','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-09','MovimientosBalanza','Movimientos balanza','01-07',9,Null,Null,'Balanza','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-09-01','Pesadas','Pesadas','01-07-09',1,Null,Null,'Balanza','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-09-02','RecepcionesBalanza','Recepciones','01-07-09',2,Null,Null,'Recepciones','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-07-09-03','SalidasBalanza','Salidas','01-07-09',3,Null,Null,'SalidaMateriales','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-08','CtrlTransp','Transportes','01',1,Null,Null,'CtrlTransp','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-08-01','Transportistas1','Transportistas','01-08',1,Null,'<a href="/' + @Directorio + '/Transportista/Index">Transportistas</a>','Transportistas','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-08-02','Choferes','Choferes','01-08',2,Null,Null,'Choferes','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-08-03','Fletes','Unidades - Fletes','01-08',3,Null,Null,'Fletes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-08-04','TarifasFletes','Tarifas fletes','01-08',4,Null,Null,'TarifasFletes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-08-05','GastosFletes','Otros conceptos fletes','01-08',5,Null,Null,'GastosFletes','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-08-05-01','GastosFletesAgrupados','Otros conceptos fletes (por períodos)','01-08-05',1,Null,Null,'GastosFletes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-08-05-02','GastosFletesTodos','Otros conceptos fletes (Todos)','01-08-05',2,Null,Null,'GastosFletes','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-08-06','LiquidacionesFletes','Liquidaciones fletes','01-08',6,Null,Null,'LiquidacionesFletes','SI','Principal'    
--INSERT INTO #Auxiliar0 Select '01-08-06-01','GastosFletesAgrupados','Liquidaciones fletes (por períodos)','01-08-06',1,Null,Null,'LiquidacionesFletes','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-08-06-02','GastosFletesTodos','Liquidaciones fletes (Todas)','01-08-06',2,Null,Null,'LiquidacionesFletes','NO','Principal'    
    
INSERT INTO #Auxiliar0 Select '01-09','Cotizaciones','Cotizaciones','01',1,Null,'<a href="/' + @Directorio + '/CotizacionMoneda/Index">Cotizaciones</a>','Cotizaciones','NO','Principal'    
    
INSERT INTO #Auxiliar0 Select '01-10','Comercial','Comercial','01',1,Null,Null,'Comercial','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-01','Clientes','Clientes','01-10',1,Null,Null,'Clientes','SI','Principal'    
--INSERT INTO #Auxiliar0 Select '01-10-01-01','ClientesResumen','Resumido','01-10-01',1,Null,'<a href="/' + @Directorio + '/Cliente/Index">Todos</a>','Clientes','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-01-02','ClientesDetalle','Detallado','01-10-01',2,Null,'<a href="/' + @Directorio + '/Cliente/Index">Detallado</a>','Clientes','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-01-03','ClientesAConfirmar','A Confirmar','01-10-01',3,Null,'<a href="/' + @Directorio + '/Cliente/IndexAConfirmar">A confirmar</a>','Clientes','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-02','PuntosVenta','Puntos de Venta','01-10',2,Null,'<a href="/' + @Directorio + '/PuntoVenta/Index">Puntos de venta</a>','PuntosVenta','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-03','Ganancias1','Ganancias','01-10',3,Null,'<a href="/' + @Directorio + '/Ganancia/Index">Tabla de ganancias</a>','Ganancias','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-04','IGCondiciones1','Categorías ganancias','01-10',4,Null,'<a href="/' + @Directorio + '/TipoRetencionGanancia/Index">Categ. de ganancias</a>','IGCondiciones','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-05','IBCondiciones1','Ingresos brutos','01-10',5,Null,'<a href="/' + @Directorio + '/IBCondicion/Index">Ingresos brutos</a>','IBCondiciones','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-06','CondicionesCompra1','Condiciones de venta','01-10',6,Null,'<a href="/' + @Directorio + '/CondicionVenta/Index">Condiciones de venta</a>','CondicionesCompra','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-07','ListasPrecios','Listas de precios','01-10',7,Null,Null,'ListasPrecios','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-07-01','ListasPreciosDefinicion','Definicion de listas de precios','01-10-07',1,Null,'<a href="/' + @Directorio + '/ListaPrecio/Index">Todos</a>','ListasPrecios','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-08','Conceptos','Conceptos','01-10',8,Null,'<a href="/' + @Directorio + '/Concepto/Index">Conceptos</a>','Conceptos','NO','Principal'    

INSERT INTO #Auxiliar0 Select '01-10-09','OrdenesCompra','Ordenes de compra','01-10',9,Null,Null,'OrdenesCompra','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-09-01','OrdenesCompraAgrupadas','Por Períodos','01-10-09',1,Null,Null,'OrdenesCompra','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-09-02','OrdenesCompraTodas','Todas','01-10-09',2,Null,'<a href="/' + @directorio + '/OrdenCompra/Index">Todas</a>','OrdenesCompra','NO','Principal'    

INSERT INTO #Auxiliar0 Select '01-10-10','Remitos','Remitos','01-10',10,Null,Null,'Remitos','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-10-01','RemitosAgrupados','Por Períodos','01-10-10',1,Null,Null,'Remitos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-10-02','RemitosTodos','Todos','01-10-10',2,Null,'<a href="/' + @directorio + '/Remito/Index">Todos</a>','Remitos','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-10-11','Facturas','Facturas','01-10',11,Null,Null,'Facturas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-11-01','FacturasAgrupadas','Por Períodos','01-10-11',1,Null,Null,'Facturas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-11-02','FacturasTodas','Todas','01-10-11',2,Null,'<a href="/' + @directorio + '/Factura/Index">Todas</a>','Facturas','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-10-12','FacturasContado','Facturas contado','01-10',12,Null,Null,'Facturas','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-12-01','FacturasContadoAgrupadas','Por Períodos','01-10-12',1,Null,Null,'Facturas','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-12-02','FacturasContadoTodas','Todas','01-10-12',2,Null,Null,'Facturas','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-10-13','Devoluciones','Devoluciones','01-10',13,Null,Null,'Devoluciones','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-13-01','DevolucionesAgrupadas','Devoluciones (por períodos)','01-10-13',1,Null,Null,'Devoluciones','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-13-02','DevolucionesTodas','Devoluciones (Todas)','01-10-13',2,Null,Null,'Devoluciones','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-10-14','Recibos','Recibos','01-10',14,Null,Null,'Recibos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-14-01','RecibosAgrupados','Por Períodos','01-10-14',1,Null,Null,'Recibos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-14-02','RecibosTodos','Recibos (Todos)','01-10-14',2,Null,'<a href="/' + @directorio + '/Recibo/Index">Todos</a>','Recibos','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-10-15','NotasDebito','Notas de Debito','01-10',15,Null,Null,'NotasDebito','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-15-01','NotasDebitoAgrupadas','Por Períodos','01-10-15',1,Null,Null,'NotasDebito','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-15-02','NotasDebitoTodas','Todas','01-10-15',2,Null,'<a href="/' + @directorio + '/NotaDebito/Index">Todas</a>','NotasDebito','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-10-16','NotasCredito','Notas de Credito','01-10',16,Null,Null,'NotasCredito','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-16-01','NotasCreditoAgrupadas','Por Períodos','01-10-16',1,Null,Null,'NotasCredito','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-10-16-02','NotasCreditoTodas','Todas','01-10-16',2,Null,'<a href="/' + @directorio + '/NotaCredito/Index">Todas</a>','NotasCredito','NO','Principal'  

--INSERT INTO #Auxiliar0 Select '01-10-17','DiferenciasCambio_C','Difer. de cambio (cobranzas)','01-10',17,Null,Null,'DiferenciasCambio_C','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-17-01','DiferenciasCambio_CP','Pendientes','01-10-17',1,Null,Null,'DiferenciasCambio_C','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-17-02','DiferenciasCambio_CG','Generadas - Anuladas','01-10-17',2,Null,Null,'DiferenciasCambio_C','NO','Principal'  

--INSERT INTO #Auxiliar0 Select '01-10-18','VentasCuotas','Ventas en cuotas fijas','01-10',18,Null,Null,'VentasCuotas','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-18-01','VentasCuotasOperacion','Ingreso de operacion de venta','01-10-18',1,Null,Null,'VentasCuotasOperacion','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-10-18-02','VentasCuotasGeneracion','Generacion de comprobantes','01-10-18',2,Null,Null,'VentasCuotasOperacion','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-10-18-03','VentasCuotasCobranzas','Registro de cobranzas','01-10-18',3,Null,Null,'VentasCuotasCobranzas','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-10-19','CtasCtesD','Resumen Cta. Cte.','01-10',19,Null,'<a href="/' + @Directorio + '/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Deudores">Cta Cte Deudores</a>','CtasCtesD','NO','Principal'    

INSERT INTO #Auxiliar0 Select '01-11','Compras','Compras','01',1,Null,Null,'Compras','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-01','Proveedores','Proveedores','01-11',1,Null,Null,'Proveedores','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-01-01','ProveedoresResumen','Resumido','01-11-01',1,Null,Null,'Proveedores','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-01-02','ProveedoresDetalle','Detallado','01-11-01',2,Null,'<a href="/' + @Directorio + '/Proveedor/Index">Detallado</a>','Proveedores','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-01-03','ProveedoresEventuales','Eventuales','01-11-01',3,Null,'<a href="/' + @Directorio + '/Proveedor/IndexEventuales">Eventuales</a>','Proveedores','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-01-04','ProveedoresAConfirmar','A Confirmar','01-11-01',4,Null,'<a href="/' + @Directorio + '/Proveedor/IndexAConfirmar">A Confirmar</a>','Proveedores','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-02','Ganancias2','Tabla de ganancias','01-11',2,Null,'<a href="/' + @Directorio + '/Ganancia/Index">Tabla de ganancias</a>','Ganancias','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-03','IGCondiciones2','Categ. de ganancias','01-11',3,Null,'<a href="/' + @Directorio + '/TipoRetencionGanancia/Index">Categ. de ganancias</a>','IGCondiciones','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-04','IBCondiciones2','Categ. de ing. brutos','01-11',4,Null,'<a href="/' + @Directorio + '/IBCondicion/Index">Ingresos brutos</a>','IBCondiciones','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-05','ImpuestosDirectos','Otros impuestos directos','01-11',5,Null,'<a href="/' + @Directorio + '/ImpuestosDirecto/Index">Otros impuestos directos</a>','ImpuestosDirectos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-06','CondicionesCompra2','Condiciones de compra','01-11',6,Null,'<a href="/' + @Directorio + '/CondicionVenta/Index">Condiciones de compra</a>','CondicionesCompra','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-07','PosicionesImportacion','Posiciones de importacion','01-11',7,Null,Null,'PosicionesImportacion','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-08','CostosImportacion','Costos de importacion','01-11',8,Null,Null,'CostosImportacion','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-09','ActividadesP','Actividad principal','01-11',9,Null,'<a href="/' + @Directorio + '/Actividades_Proveedore/Index">Actividad principal</a>','ActividadesP','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-10','DistribucionesObras','Distribucion de gastos','01-11',10,Null,Null,'DistribucionesObras','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-11','ConceptosOP','Conceptos p/OP otros','01-11',11,Null,'<a href="/' + @Directorio + '/Concepto/IndexOP">Conceptos p/OP otros</a>','Conceptos','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-11-12','Presupuestos','Solicitudes de cotizacion','01-11',12,Null,Null,'Presupuestos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-12-01','PresupuestosAgrupados','Por Períodos','01-11-12',1,Null,Null,'Presupuestos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-12-02','PresupuestosTodos','Todos','01-11-12',2,Null,Null,'Presupuestos','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-11-13','Comparativas','Comparativas','01-11',13,Null,'<a href="/' + @directorio + '/Comparativa/Index">Comparativas (Todos)</a>','Comparativas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-13','Comparativas','Comparativas','01-11',13,Null,Null,'Comparativas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-13-01','ComparativasAgrupadas','Por Períodos','01-11-13',1,Null,Null,'Comparativas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-13-02','ComparativasTodas','Todas','01-11-13',2,Null,Null,'<a href="/' + @Directorio + '/Comparativa/Index">Todos</a>','NO','Principal'    
  
INSERT INTO #Auxiliar0 Select '01-11-14','Pedidos','Notas de pedido','01-11',14,Null,Null,'Pedidos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-14-01','PedidosAgrupados','Por Períodos','01-11-14',1,Null,Null,'Pedidos','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-14-02','PedidosPendientes','Pendientes','01-11-14',2,Null,Null,'Pedidos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-14-03','PedidosPorObra','por obra','01-11-14',3,Null,Null,'Pedidos','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-11-14-04','PedidosTodos','Todos','01-11-14',4,Null,'<a href="/' + @Directorio + '/Pedido/Index">Todos</a>','Pedidos','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-14-04','PedidosTodos','Todos','01-11-14',4,Null,'<a href="/' + @Directorio + '/Pedido/Index">Todos</a>','Pedidos','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-14-05','PedidosSubcontratos','Subcontratos','01-11-14',5,Null,Null,'Pedidos','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-14-05-01','PedidosSubcontratosAgrupados','Por Períodos','01-11-14-05',1,Null,Null,'Pedidos','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-14-05-02','PedidosSubcontratosAgrupados','Todos','01-11-14-05',2,Null,Null,'Pedidos','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-11-14-06','PedidosAbiertos','Abiertas','01-11-14',6,Null,Null,'Pedidos','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-14-20','PedidoNuevo','Nuevo','01-11-14',5,Null,'<a href="/' + @Directorio + '/Pedido/Edit/-1">Nuevo</a>','Pedidos','NO','Principal'    
  
INSERT INTO #Auxiliar0 Select '01-11-14-07','Clausulas','Clausulas','01-11-14',7,Null,Null,'Pedidos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-14-08','LugaresEntrega','Lugares','01-11-14',8,Null,Null,'Pedidos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-14-09','PlazosEntrega','Plazos','01-11-14',9,Null,Null,'Pedidos','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-11-15','AutorizacionesCompra','Autorizaciones de compra','01-11',15,Null,Null,'AutorizacionesCompra','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-15-01','AutorizacionesCompraAgrupadas','Autorizaciones de compra (por períodos)','01-11-15',1,Null,Null,'AutorizacionesCompra','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-15-02','AutorizacionesCompraTodas','Todas','01-11-15',2,Null,Null,'AutorizacionesCompra','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-11-16','FondosFijos','Fondos fijos','01-11',16,Null,Null,'FondosFijos','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-16-01','FondosFijos','Cuentas','01-11-16',1,Null,'<a href="/' + @directorio + '/Cuenta/IndexFF">Cuentas</a>','FondosFijos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-16-02','FondosFijos','Nuevo f. fijo','01-11-16',2,Null,'<a href="/' + @directorio + '/ComprobanteProveedor/EditFF/-1?q=ff">Nuevo f. fijo</a>','ComprobantesPrv','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-16-03','FondosFijosPorMes','Por Períodos','01-11-16',6,Null,Null,'FondosFijos','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-16-07','FondosFijosPorRendicion','Por Rendición','01-11-16',7,Null,Null,'FondosFijos','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-16-08','FondosFijos','Todos','01-11-16',8,Null,'<a href="/' + @Directorio + '/ComprobanteProveedor/IndexFF">Todos</a>','ComprobantesPrv','NO','Principal'    
  
INSERT INTO #Auxiliar0 Select '01-11-17','ComprobantesPrv','Ingreso de Comprobantes','01-11',17,Null,Null,'ComprobantesPrv','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-17-01','ComprobantesPrvPorMes','Por Períodos','01-11-17',1,Null,Null,'ComprobantesPrv','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-17-02','ComprobantesAConfirmar','A Confirmar','01-11-17',2,Null,Null,'ComprobantesPrv','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-17-03','ComprobantesPrvTodos','Todos','01-11-17',3,Null,'<a href="/' + @Directorio + '/ComprobanteProveedor/Index">Todos</a>','ComprobantesPrv','NO','Principal'    
--INSERT INTO #Auxiliar0 Select '01-11-17-05','ComprobantesPrvTodos','Nuevo f. fijo','01-11-17',5,Null,'<a href="/' + @directorio + '/ComprobanteProveedor/EditFF/-1?q=ff">Nuevo f. fijo</a>','ComprobantesPrv','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-17-06','ComprobantesPrvPorMes','Por Períodos','01-11-17',6,Null,Null,'ComprobantesPrv','SI','Principal'    
--INSERT INTO #Auxiliar0 Select '01-11-17-08','ComprobantesPrvTodos','Todos','01-11-17',8,Null,'<a href="/' + @Directorio + '/ComprobanteProveedor/IndexFF">Todos</a>','ComprobantesPrv','NO','Principal'    
  
INSERT INTO #Auxiliar0 Select '01-11-18','OPago','Ordenes de Pago','01-11',18,Null,Null,'OPago','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-18-01','OPagoPorMes','Por Períodos','01-11-18',1,Null,Null,'OPago','SI','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-18-02','OPagoALaFirma','A la firma','01-11-18',2,Null, '<a href="/' + @Directorio + '/OrdenPago/Index">A la firma</a>'         ,'OPago','NO','Principal'    
INSERT INTO #Auxiliar0 Select '01-11-18-03','OPagoEnCaja',      'En caja','01-11-18',  3,Null,'<a href="/' + @Directorio + '/OrdenPago/IndexExterno">En caja</a>'     ,'OPago','NO','Principal'    
IF Isnull((Select Top 1 ProntoIni.Valor From ProntoIni   
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave  
			Where pic.Clave='Habilitar caja obra en OP'),'')='SI'  
	INSERT INTO #Auxiliar0 Select '01-11-18-04','OPagoEnCajaObra', 'En caja obra','01-11-18', 4,Null,Null,'OPago','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-18-05','OPagoAConfirmar', 'A Confirmar','01-11-18', 5,Null,'<a href="/' + @Directorio + '/OrdenPago/Index?bAConfirmar=true">A Confirmar</a>' ,'OPago','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-18-06','OPagoTodas', 'Todas','01-11-18', 6, Null,'<a href="/' + @Directorio + '/OrdenPago/Index">Todos</a>','OPago','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-11-19','DiferenciasCambio','Dif. de cambio (pagos)','01-11',19,Null,Null,'DiferenciasCambio_P','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-19-01','DiferenciasCambio_PP','Pendientes','01-11-19',1,Null,Null,'DiferenciasCambio_P','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-19-02','DiferenciasCambio_PG','Generadas - Anuladas','01-11-19',2,Null,Null,'DiferenciasCambio_P','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-20','CtasCtesA','Resumen Cta. Cte.','01-11',20,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores">Cta Cte Acreedores</a>','CtasCtesA','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-12','Contabilidad','Contabilidad','01',1,Null,Null,'Contabilidad','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-01','EjerciciosContables','Ejercicios contables','01-12',1,Null,'<a href="/' + @Directorio + '/EjerciciosContable/Index">Ejercicios contables</a>','EjerciciosContables','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-02','RubrosContables','Rubros contables','01-12',2,Null,Null,'RubrosContables','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-02-01','RubrosContablesGastosPorObra','Rubros contables p/cuentas de obra','01-12-02',1,Null,'<a href="/' + @Directorio + '/RubroContable/Index">Rubros contables</a>','RubrosContables','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-02-02','RubrosContablesFinancieros','Rubros contables financieros','01-12-02',2,Null,Null,'RubrosContables','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-12-03','PresupuestoFinanciero','Presupuesto financiero por rubro contable','01-12',3,Null,Null,'PresupuestoFinanciero','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-12-04','PresupuestoEconomico','Presupuesto economico por cuenta','01-12',4,Null,Null,'PresupuestoEconomico','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-12-05','CashFlow','Definicion de flujo de caja','01-12',5,Null,Null,'CashFlow','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-06','TiposCuentaGrupos','Grupos de cuenta','01-12',6,Null,'<a href="/' + @Directorio + '/TiposCuentaGrupos/Index">Grupos de cuenta</a>','TiposCuentaGrupos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-07','CuentasGastos','Cuentas para obras','01-12',7,Null,'<a href="/' + @Directorio + '/CuentaGasto/Index">Cuentas para obras</a>','CuentasGastos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-08','Cuentas','Cuentas','01-12',8,Null,Null,'Cuentas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-08-01','CuentasTodas','Cuentas (Todas)','01-12-08',1,Null,'<a href="/' + @Directorio + '/Cuenta/Index">Cuentas (Todas)</a>','Cuentas','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-12-09','Subdiarios','Subdiarios','01-12',9,Null,Null,'Subdiarios','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-09-01','SubdiariosAgrupados','Por Períodos','01-12-09',1,Null,Null,'Subdiarios','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-09-02','SubdiariosTodos','Todos','01-12-09',2,Null,'<a href="/' + @directorio + '/Subdiario/Index">Todos</a>','Subdiarios','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-12-10','Asientos','Asientos','01-12',10,Null,Null,'Asientos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-10-01','AsientosAgrupados','Por Períodos','01-12-10',1,Null,Null,'Asientos','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-12-10-02','AsientosSyJ','Asientos (Sueldos)','01-12-10',2,Null,Null,'Asientos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-12-10-03','AsientosTodos','Asientos (Todos)','01-12-10',3,Null,'<a href="/' + @directorio + '/Asiento/Index">Todos</a>','Asientos','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-13','ActivoFijo','Activo Fijo','01',1,Null,Null,'ActivoFijo','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-13-01','CoeficientesImpositivos','Coeficientes Impositivos','01-13',1,Null,Null,'CoeficientesImpositivos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-13-02','CoeficientesContables','Coeficientes Contables','01-13',2,Null,Null,'CoeficientesContables','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-13-03','GruposActivosFijos','Grupos de activos fijos','01-13',3,Null,Null,'GruposActivosFijos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-13-04','Revaluos','Revaluos','01-13',4,Null,Null,'Revaluos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-13-05','ModificacionActivoFijo','Modificaciones a activo fijo','01-13',5,Null,Null,'ModificacionActivoFijo','NO','Principal'  
  
INSERT INTO #Auxiliar0 Select '01-14','MovimientoBancos','Movim. de caja y bancos','01',1,Null,Null,'Bancos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-01','Cajas','Cajas','01-14',1,Null,'<a href="/' + @directorio + '/Caja/Index">Cajas</a>','Cajas','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-02','Bancos','Bancos','01-14',2,Null,'<a href="/' + @directorio + '/Banco/Index">Bancos</a>','Bancos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-03','CuentasBancarias','Cuentas bancarias','01-14',3,Null,'<a href="/' + @directorio + '/CuentaBancaria/Index">Cuentas bancarias</a>','CuentasBancarias','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-04','BancoChequeras','Chequeras','01-14',4,Null,'<a href="/' + @directorio + '/BancoChequera/Index">Chequeras</a>','BancoChequeras','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-05','TarjetasCredito','Tarjetas de credito','01-14',5,Null,'<a href="/' + @directorio + '/TarjetaCredito/Index">Tarjetas de credito</a>','TarjetasCredito','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-14-06','Valores','Valores','01-14',6,Null,Null,'Valores','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-14-06-01','ValoresRecibidos','Asientos (por períodos)','01-14-06',1,Null,Null,'Valores','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-14-06-02','ValoresEmitidos','Asientos (Sueldos)','01-14-06',2,Null,Null,'Valores','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-14-06-03','ValoresTodos','AValores (Todos)','01-14-06',3,Null,Null,'Valores','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-07','DepositosBancarios','Depositos bancarios','01-14',7,Null,Null,'DepositosBancarios','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-07-01','DepositosBancariosAgrupados','Depositos (por períodos)','01-14-07',1,Null,Null,'DepositosBancarios','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-07-02','DepositosBancariosTodos','Depositos (Todos)','01-14-07',2,Null,'<a href="/' + @directorio + '/DepositoBancario/Index">Todos</a>','DepositosBancarios','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-08','GastosBancarios','Debitos y creditos bancarios','01-14',8,Null,Null,'GastosBancarios','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-08-01','GastosBancariosAgrupados','Por Períodos','01-14-08',1,Null,Null,'GastosBancarios','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-08-02','GastosBancariosTodos','Todos','01-14-08',2,Null,'<a href="/' + @directorio + '/Valor/Index">Todos</a>','GastosBancarios','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-09','ConciliacionesCajas','Conciliacion de cajas','01-14',9,Null,Null,'ConciliacionesCajas','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-10','Conciliaciones','Conciliacion de bancos','01-14',10,Null,Null,'Conciliaciones','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-11','ConciliacionesTarjetas','Conciliacion de tarjetas de credito','01-14',11,Null,Null,'ConciliacionesTarjetas','SI','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-12','ChequesPendientes','Cheques pendientes','01-14',12,Null,'<a href="/' + @directorio + '/Valor/IndexChequesPendientes">Cheques pendientes</a>','ChequesPendientes','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-13','ChequesNoUsados','Cheques no utilizados','01-14',13,Null,Null,'ChequesPendientes','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-13-01','ChequesNoUsadosNoVistos','Cheques no utilizados','01-14-13',1,Null,'<a href="/' + @directorio + '/Valor/IndexChequesNoUtilizados?Visto=NO">Cheques no utilizados</a>','ChequesPendientes','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-13-02','ChequesNoUsadosVistos','Cheques no utilizados (vistos)','01-14-13',2,Null,'<a href="/' + @directorio + '/Valor/IndexChequesNoUtilizados?Visto=SI">Cheques no utilizados (vistos)</a>','ChequesPendientes','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-14','ResumenesParaConciliacion','Resumenes de Conciliacion','01-14',14,Null,Null,'ResumenesParaConciliacion','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-14-01','ResumenesParaConciliacionAgrupados','Resumenes de Conciliacion (por períodos)','01-14-14',1,Null,Null,'ResumenesParaConciliacion','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-14-02','ResumenesParaConciliacionTodos','Todos','01-14-14',2,Null,'<a href="/' + @directorio + '/ResumenConciliacion/Index">Todos</a>','ResumenesParaConciliacion','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-15','EmisionCheques','Emision de cheques','01-14',15,Null,Null,'EmisionCheques','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-15-01','EmisionChequesTodosEmitidos','Emision de cheques (Emitidos)','01-14-15',1,Null,Null,'EmisionCheques','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-15-02','EmisionChequesTodosNoEmitidos','Emision de cheques (No emitidos)','01-14-15',2,Null,Null,'EmisionCheques','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-15-03','EmisionChequesTodosNoEmitidosPorCuenta','Emision de cheques (No emitidos por cuenta)','01-14-15',3,Null,Null,'EmisionCheques','NO','Principal'  

INSERT INTO #Auxiliar0 Select '01-14-16','PlazosFijos','Plazos fijos','01-14',16,Null,Null,'PlazosFijos','SI','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-16-01','PlazosFijosAVencer','Plazos fijos (A vencer)','01-14-16',1,Null,'<a href="/' + @directorio + '/PlazoFijo/Index?Tipo=AVencer">Plazos fijos (A vencer)</a>','PlazosFijos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-16-02','PlazosFijosVencidos','Plazos fijos (Vencidos)','01-14-16',2,Null,'<a href="/' + @directorio + '/PlazoFijo/Index?Tipo=Vencidos">Plazos fijos (Vencidos)</a>','PlazosFijos','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-14-16-03','PlazosFijosTodos','Plazos fijos (Todos)','01-14-16',3,Null,'<a href="/' + @directorio + '/PlazoFijo/Index?Tipo=Todos">Plazos fijos (Todos)</a>','PlazosFijos','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-15','ModulosAdicionales','Modulos adicionales','01',1,Null,Null,'ModulosAdicionales','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-01','PolizasObras','Polizas obras','01-15',1,Null,Null,'PolizasObras','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-01-01','PolizasObrasActivas','Polizas obras (activas)','01-15-01',1,Null,Null,'PolizasObras','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-01-02','PolizasObrasInactivas','Polizas obras (inactivas)','01-15-01',2,Null,Null,'PolizasObras','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-01-03','PolizasObrasCalendarioPendiente','Polizas obras calendario (solo pendiente)','01-15-01',3,Null,Null,'PolizasObras','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-01-04','PolizasObrasCalendarioTodas','Polizas obras calendario (todas)','01-15-01',4,Null,Null,'PolizasObras','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-02','PolizasEquipos','Polizas equipos','01-15',1,Null,Null,'PolizasEquipos','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-02-01','PolizasEquiposActivas','Polizas equipos (activas)','01-15-02',1,Null,Null,'PolizasEquipos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-02-02','PolizasEquiposInactivas','Polizas equipos (inactivas)','01-15-02',2,Null,Null,'PolizasEquipos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-02-03','PolizasEquiposCalendarioPendiente','Polizas equipos calendario (solo pendiente)','01-15-02',3,Null,Null,'PolizasEquipos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-02-04','PolizasEquiposCalendarioTodas','Polizas equipos calendario (todas)','01-15-02',4,Null,Null,'PolizasEquipos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-03','Patentes','Patentes','01-15',1,Null,Null,'Patentes','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-03-01','PatentesActivas','Patentes (activas)','01-15-03',1,Null,Null,'Patentes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-03-02','PatentesInactivas','Patentes (inactivas)','01-15-03',2,Null,Null,'Patentes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-03-03','PatentesCalendarioPendiente','Patentes calendario (solo pendiente)','01-15-03',3,Null,Null,'Patentes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-03-04','PatentesCalendarioTodas','Patentes calendario (todas)','01-15-03',4,Null,Null,'Patentes','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-04','PlanesFacilidades','Planes de facilidades','01-15',1,Null,Null,'PlanesFacilidades','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-04-01','PlanesFacilidadesActivos','Planes de facilidades (activos)','01-15-04',1,Null,Null,'PlanesFacilidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-04-02','PlanesFacilidadesInactivos','Planes de facilidades (inactivos)','01-15-04',2,Null,Null,'PlanesFacilidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-04-03','PlanesFacilidadesCalendarioPendiente','Planes de facilidades calendario (solo pendiente)','01-15-04',3,Null,Null,'PlanesFacilidades','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-15-04-04','PlanesFacilidadesCalendarioTodos','Planes de facilidades calendario (todos)','01-15-04',4,Null,Null,'PlanesFacilidades','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-16','Historicos','Movim. historicos','01',1,Null,Null,'Historicos','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-01','HistObras','Obras inactivas','01-16',1,Null,Null,'HistObras','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-01-01','HistObras1','Obras','01-16-01',1,Null,Null,'HistObras','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-01-02','HistObras2','Obras (Detalladas)','01-16-01',2,Null,Null,'HistObras','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-02','HLMateriales','Lista de Materiales','01-16',2,Null,Null,'HLMateriales','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-03','HRequerimientos','Requerimientos de materiales','01-16',3,Null,Null,'HRequerimientos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-04','HPedidos','Notas de Pedido','01-16',4,Null,Null,'HPedidos','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-16-05','HChequeras','Chequeras','01-16',5,Null,Null,'HChequeras','NO','Principal'  
  
--INSERT INTO #Auxiliar0 Select '01-17','PpalSAT','Comprob Pronto SAT','01',1,Null,Null,'PpalSAT','SI','Principal'  
--INSERT INTO #Auxiliar0 Select '01-17-01','RecepcionesSAT','Recepciones','01-17',1,Null,Null,'RecepcionesSAT','NO','Principal'  
  
DECLARE @AñoAnt103 int, @Contador103 int, @Contador1030 int, @AñoAnt1 int, @Contador1 int, @AñoAnt104 int, @Contador104 int, @AñoAnt900 int ,@Contador900 int, @Contador9100 int, @Contador91002 int, 
		@TipoComprobanteAnt int, @IdEntidad int, @Entidad varchar(50), @Contador int, @IdEntidad2 int, @Entidad2 varchar(50), @Contador2 int, @Contador3 int

SET @AñoAnt103=-1  
SET @AñoAnt900=-1  
SET @TipoComprobanteAnt=-1  
SET @Contador103=0  
SET @Contador1=0  
SET @Contador1030=0  
SET @Contador900=0  
SET @Contador9100=0  
SET @AñoAnt104=-1  
SET @Contador104=0  

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT TipoComprobante, Obra, IdObra, Año, Mes FROM #Auxiliar1 ORDER BY TipoComprobante, Obra, IdObra, Año desc, Mes asc  
OPEN Cur  
FETCH NEXT FROM Cur INTO @TipoComprobante, @Obra, @IdObra, @Año, @Mes  
WHILE @@FETCH_STATUS = 0  
  BEGIN  
	IF @TipoComprobante<>@TipoComprobanteAnt
	  BEGIN
		SET @AñoAnt1=-1  
		SET @TipoComprobanteAnt=@TipoComprobante 
	  END

	SELECT @NombreMes = Case When @Mes=1 Then 'Enero' When @Mes=2 Then 'Febrero' When @Mes=3 Then 'Marzo' When @Mes=4 Then 'Abril'   
								When @Mes=5 Then 'Mayo' When @Mes=6 Then 'Junio' When @Mes=7 Then 'Julio' When @Mes=8 Then 'Agosto'  
								When @Mes=9 Then 'Septiembre' When @Mes=10 Then 'Octubre' When @Mes=11 Then 'Noviembre' When @Mes=12 Then 'Diciembre'  
						End  
	SET @FechaInicial='01/'+Substring('00',1,2-Len(Convert(varchar,@Mes)))+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año)  
	SET @Fecha=DateAdd(d,-1,DateAdd(m,1,Convert(datetime,@FechaInicial,103)))  
	SET @FechaFinal=Substring('00',1,2-Len(Convert(varchar,Day(@Fecha))))+Convert(varchar,Day(@Fecha))+'/'+  
					Substring('00',1,2-Len(Convert(varchar,Month(@Fecha))))+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha))  

	--REQUERIMIENTOS  
	IF @TipoComprobante=103  
	  BEGIN  
		IF @AñoAnt103<>@Año  
		  BEGIN  
			SET @AñoAnt103=@Año  
			SET @Contador103=@Contador103+1  
			SET @Parent='01-06-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador103)))+Convert(varchar,@Contador103)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'RequerimientosAgrupados'+Convert(varchar,@AñoAnt103),Convert(varchar,@AñoAnt103),'01-06-01', @Contador103, Null,  
					'<a href="/' + @directorio + '/Requerimiento/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt103)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt103)+'">'+Convert(varchar,@AñoAnt103)+'</a>', 'Requerimientos', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'RequerimientosAgrupados'+Convert(varchar,@AñoAnt103)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Requerimiento/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Requerimientos', 'NO','Principal'  
	  END  
  
	IF @TipoComprobante=1030  
	  BEGIN  
		SET @Contador1030=@Contador1030+1  
		SET @Clave='01-06-02-'+Substring('0000',1,4-Len(Convert(varchar,@Contador1030)))+Convert(varchar,@Contador1030)  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'RequerimientosPorObra'+Convert(varchar,@IdObra), @Obra, '01-06-02', @Contador1030, Null,   
				'<a href="/' + @directorio + '/Requerimiento/Index?idobra='+Convert(varchar,@IdObra)+'">'+@Obra+'</a>', 'Requerimientos', 'NO','Principal'  
	  END  
  
	--PRESUPUESTO (SOLICITUD DE COTIZACION)  
	IF @TipoComprobante=104  
	  BEGIN  
		IF @AñoAnt104<>@Año  
		  BEGIN  
			SET @AñoAnt104=@Año  
			SET @Contador104=@Contador104+1  
			SET @Parent='01-11-12-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador104)))+Convert(varchar,@Contador104)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'PresupuestosAgrupados'+Convert(varchar,@AñoAnt104),Convert(varchar,@AñoAnt104),'01-11-12-01', @Contador104, Null,  
					'<a href="/' + @directorio + '/Presupuesto/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt104)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt104)+'">'+Convert(varchar,@AñoAnt104)+'</a>', 'Presupuestos', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,@Mes)))+Convert(varchar,@Mes)  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'PresupuestosAgrupados'+Convert(varchar,@AñoAnt104)+Convert(varchar,@Mes), @NombreMes, @Parent, @Mes, Null,  
				'<a href="/' + @directorio + '/Presupuesto/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Presupuestos', 'NO','Principal'  
	  END  
  
	--ORDENES DE COMPRA
	IF @TipoComprobante=140
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-10-09-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'OrdenesCompraAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-10-09-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/OrdenCompra/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'OrdenesCompra', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'OrdenesCompraAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/OrdenCompra/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'OrdenesCompra', 'NO','Principal'  
	  END  
  
	--REMITOS
	IF @TipoComprobante=41
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-10-10-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'RemitosAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-10-10-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Remito/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Remitos', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'RemitosAgrupados'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Remito/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Remitos', 'NO','Principal'  
	  END  
  
	--FACTURAS DE VENTA   
	IF @TipoComprobante=1
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-10-11-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'FacturasAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-10-11-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Factura/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Facturas', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'FacturasAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Factura/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Facturas', 'NO','Principal'  
	  END  
  
	--RECIBOS
	IF @TipoComprobante=2
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-10-14-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'RecibosAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-10-14-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Recibo/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Recibos', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'RecibosAgrupados'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Recibo/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Recibos', 'NO','Principal'  
	  END  
  
	--NOTAS DE DEBITO
	IF @TipoComprobante=3
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-10-15-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'NotasDebitoAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-10-15-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/NotaDebito/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'NotasDebito', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'NotasDebitoAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/NotaDebito/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'NotasDebito', 'NO','Principal'  
	  END  

	--NOTAS DE CREDITO
	IF @TipoComprobante=4
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-10-16-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'NotasCreditoAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-10-16-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/NotaCredito/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'NotasCredito', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'NotasCreditoAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/NotaCredito/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'NotasCredito', 'NO','Principal'  
	  END  

	--ORDENES DE PAGO
	IF @TipoComprobante=17
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-11-18-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'OPagoPorMes'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-11-18-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/OrdenPago/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'OPago', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'OPagoPorMes'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/OrdenPago/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'OPago', 'NO','Principal'  
	  END  

	--PEDIDO   
	IF @TipoComprobante=51  
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-11-14-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'PedidosAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-11-14-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Pedido/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Pedidos', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'PedidosAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Pedido/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Pedidos', 'NO','Principal'  
	  END  
  
	--COMPROBANTES PROVEEDOR  
	IF @TipoComprobante=900   --and 1=0  
	  BEGIN  
		IF @AñoAnt900<>@Año  
		  BEGIN  
			SET @AñoAnt900=@Año  
			SET @Contador900=@Contador900+1  
			SET @Parent='01-11-17-01-'+ Substring('000',1,3-Len(Convert(varchar,@Contador900)))+Convert(varchar,@Contador900)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'ComprobanteProveedorAgrupadas'+Convert(varchar,@AñoAnt900), Convert(varchar,@AñoAnt900),'01-11-17-01', @Contador900, Null,  
					'<a href="/' + @directorio + '/ComprobanteProveedor/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt900)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt900)+'">'+Convert(varchar,@AñoAnt900)+'</a>', 'ComprobanteProveedor', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'ComprobanteProveedorAgrupadas'+Convert(varchar,@AñoAnt900)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/ComprobanteProveedor/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Pedidos', 'NO','Principal'  
	  END  
  
	--COMPROBANTES PROVEEDOR Fondo fijo  
	IF @TipoComprobante=910  
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-11-16-03-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'FondoFijoAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-11-16-03', @Contador1, Null,  
					'<a href="/' + @directorio + '/ComprobanteProveedor/IndexFF?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'FondoFijo', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'FondoFijoAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/ComprobanteProveedor/IndexFF?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'FondoFijo', 'NO','Principal'  
	  END  
  
	--por cuentaff/rendicion: 1 nivel  (cuentaff)  
	IF @TipoComprobante=9100  
	  BEGIN  
		SET @Contador9100=@Contador9100+1  
		SET @Clave='01-11-16-07-'+Substring('000',1,3-Len(Convert(varchar,@Contador9100)))+Convert(varchar,@Contador9100)  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'FondoFijoPorRendicion'+Convert(varchar,@Obra), @Obra, '01-11-16-07', @Contador9100, Null,   
				'<a href="/' + @directorio + '/ComprobanteProveedor/IndexFF?rendicion='+Convert(varchar,@Obra)+'">'+@Obra+'</a>', 'FondoFijo', 'SI','Principal'  
    
		--por cuentaff/rendicion: 2do nivel (rendicion)  
		--IF @TipoComprobante=91002 --and 1=0  
		--  BEGIN  
		-- SET @Contador91002=@Contador91002+1  
		-- DECLARE @IdCuentaFF int  
		-- set @IdCuentaFF=@Año  
		-- SET @Clave='01-11-16-07-'+Substring('0000',1,4-Len(Convert(varchar,@IdCuentaFF)))+Convert(varchar,@IdCuentaFF)  
  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave+'-'+Convert(varchar,#Auxiliar1.IdObra), 'FondoFijoPorRendicion'+Convert(varchar,#Auxiliar1.Obra)+'-'+Convert(varchar,#Auxiliar1.IdObra),   
				Convert(varchar,#Auxiliar1.IdObra)+' - ' + #Auxiliar1.Obra, @Clave, #Auxiliar1.IdObra, Null,   
				'<a href="/' + @directorio + '/ComprobanteProveedor/IndexFF?rendicion='+Convert(varchar,#Auxiliar1.IdObra)+ '&idcuenta=' + Convert(varchar,#auxiliar1.Año) + '">.' +Convert(varchar,#Auxiliar1.IdObra)+ '</a>', 'FondoFijo', 'NO','Principal'  
		 FROM #Auxiliar1  
		 WHERE #Auxiliar1.TipoComprobante=91002 and #auxiliar1.Año=@IdObra  
	  END  
  


	--COMPARATIVAS  
	IF @TipoComprobante=105  
	  BEGIN  
		IF @AñoAnt103<>@Año  
		  BEGIN  
			SET @AñoAnt103=@Año  
			SET @Contador103=@Contador103+1  
			SET @Parent='01-11-13-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador103)))+Convert(varchar,@Contador103)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'ComparativasAgrupados'+Convert(varchar,@AñoAnt103),Convert(varchar,@AñoAnt103),'01-11-13-01', @Contador103, Null,  
					'<a href="/' + @directorio + '/Comparativa/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt103)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt103)+'">'+Convert(varchar,@AñoAnt103)+'</a>', 'Comparativas', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
	
	   --en Niro, repite el id de los presupuestos. Se esta saltando el IF donde asigna @Parent, usa el anterior, y entonces se traba 
	
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'ComparativasAgrupados'+Convert(varchar,@AñoAnt103)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Comparativa/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Comparativas', 'NO','Principal'  
	  END  
      
	IF @TipoComprobante=1050  
	  BEGIN  
		SET @Contador1030=@Contador1030+1  
		SET @Clave='01-11-13-02-'+Substring('000',1,3-Len(Convert(varchar,@Contador1030)))+Convert(varchar,@Contador1030)  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'ComparativasPorObra'+Convert(varchar,@IdObra), @Obra, '01-11-13-02', @Contador1030, Null,   
				'<a href="/' + @directorio + '/Comparativa/Index?idobra='+Convert(varchar,@IdObra)+'">'+@Obra+'</a>', 'Comparativas', 'NO','Principal'  
	  END  

	--AJUSTES DE STOCK
	IF @TipoComprobante=106
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-07-02-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'AjustesStockAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-07-02-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/AjusteStock/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'AjustesStock', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'AjustesStockAgrupados'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/AjusteStock/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'AjustesStock', 'NO','Principal'  
	  END  

	--RECEPCIONES
	IF @TipoComprobante=60
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-07-03-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'RecepcionesAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-07-03-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Recepcion/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Recepciones', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'RecepcionesAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Recepcion/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Recepciones', 'NO','Principal'  
	  END  

	--SALIDA DE MATERIALES
	IF @TipoComprobante=50
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-07-06-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'SalidaMaterialesAgrupadas'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-07-06-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/SalidaMateriales/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'SalidaMateriales', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'SalidaMaterialesAgrupadas'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/SalidaMateriales/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'SalidaMateriales', 'NO','Principal'  
	  END  

	--OTROS INGRESOS A ALMACEN
	IF @TipoComprobante=108
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-07-07-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'OtrosIngresosAlmacenAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-07-07-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/OtroIngresoAlmacen/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'OtrosIngresosAlmacen', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'OtrosIngresosAlmacenAgrupados'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/OtroIngresoAlmacen/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'OtrosIngresosAlmacen', 'NO','Principal'  
	  END  

	--ASIENTOS
	IF @TipoComprobante=-101
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-12-10-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'AsientosAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-12-10-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Asiento/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Asientos', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'Asientos'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Asiento/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Asientos', 'NO','Principal'  
	  END  

	--SUBDIARIOS
	IF @TipoComprobante=-100
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-12-09-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'SubdiariosAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-12-09-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Subdiario/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Subdiarios', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'Subdiarios'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Subdiario/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Subdiarios', 'NO','Principal'  
	  END  

	--DEPOSITOS BANCARIOS
	IF @TipoComprobante=14
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-14-07-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'DepositosBancariosAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-14-07-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/DepositoBancario/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'DepositosBancarios', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'DepositosBancariosAgrupados'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/DepositoBancario/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'DepositosBancarios', 'NO','Principal'  
	  END  
  
	--GASTOS BANCARIOS
	IF @TipoComprobante=-102
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-14-08-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'GastosBancariosAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-14-08-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/Valor/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'GastosBancarios', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'GastosBancarios'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Valor/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'GastosBancarios', 'NO','Principal'  
	  END  


	--RESUMENES DE CONCILIACION
	IF @TipoComprobante=-106
	  BEGIN  
		IF @AñoAnt1<>@Año  
		  BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador1=@Contador1+1  
			SET @Parent='01-14-14-01-'+Substring('000',1,3-Len(Convert(varchar,@Contador1)))+Convert(varchar,@Contador1)  
			INSERT INTO #Auxiliar0   
			 SELECT @Parent, 'ResumenesParaConciliacionAgrupados'+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),'01-14-14-01', @Contador1, Null,  
					'<a href="/' + @directorio + '/ResumenConciliacion/Index?fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'ResumenesParaConciliacion', 'SI','Principal'  
		  END  
		SET @Clave=@Parent+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
		 SELECT @Clave, 'ResumenesParaConciliacionAgrupados'+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/ResumenConciliacion/Index?fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'ResumenesParaConciliacion', 'NO','Principal'  
	  END  


	FETCH NEXT FROM Cur INTO @TipoComprobante, @Obra, @IdObra, @Año, @Mes  
  END  
CLOSE Cur  
DEALLOCATE Cur  
  

/*   Articulos por rubros   */
TRUNCATE TABLE #Auxiliar2
INSERT INTO #Auxiliar2
 SELECT DISTINCT IsNull(Articulos.IdRubro,0), Rubros.Descripcion
 FROM Articulos
 LEFT OUTER JOIN Rubros ON Rubros.IdRubro=Articulos.IdRubro  
 ORDER BY Rubros.Descripcion

SET @Contador=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEntidad, Entidad FROM #Auxiliar2 ORDER BY Entidad
OPEN Cur  
FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
WHILE @@FETCH_STATUS = 0  
  BEGIN  
	SET @Contador=@Contador+1  
	SET @Parent='01-02-04-'+Substring('00',1,3-Len(Convert(varchar,@Contador)))+Convert(varchar,@Contador)  
	INSERT INTO #Auxiliar0   
	 SELECT @Parent, 'ArticulosRubros'+Convert(varchar,@IdEntidad),@Entidad,'01-02-04', @Contador, Null,  
			'<a href="/' + @directorio + '/Articulo/Index?IdRubro='+Convert(varchar,@IdEntidad)+'">'+@Entidad+'</a>', 'Articulos', 'NO','Principal'  
	FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
  END  
CLOSE Cur  
DEALLOCATE Cur  
  

/*   Conciliacion bancos por cuenta bancaria   */
TRUNCATE TABLE #Auxiliar2
INSERT INTO #Auxiliar2
 SELECT IdBanco, Nombre
 FROM Bancos 
 WHERE IdCuenta is not null and Exists(Select Top 1 CuentasBancarias.IdCuentaBancaria From CuentasBancarias Where CuentasBancarias.IdBanco=Bancos.IdBanco) 
 ORDER by Nombre

SET @Contador=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEntidad, Entidad FROM #Auxiliar2 ORDER BY Entidad
OPEN Cur  
FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
WHILE @@FETCH_STATUS = 0  
  BEGIN  
	SET @Contador=@Contador+1  
	SET @Parent='01-14-10-'+Substring('00',1,3-Len(Convert(varchar,@Contador)))+Convert(varchar,@Contador)  
	INSERT INTO #Auxiliar0   
	 SELECT @Parent, 'Conciliaciones'+Convert(varchar,@IdEntidad), @Entidad, '01-14-10', @Contador, Null, Null, 'Conciliaciones', 'SI','Principal'  

	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3
	 SELECT IdCuentaBancaria, Cuenta
	 FROM CuentasBancarias 
	 WHERE Cuenta is not null and IdBanco=@IdEntidad
	 ORDER by Cuenta

	SET @Contador2=0
	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEntidad2, Entidad2 FROM #Auxiliar3 ORDER BY Entidad2
	OPEN Cur1  
	FETCH NEXT FROM Cur1 INTO @IdEntidad2, @Entidad2
	WHILE @@FETCH_STATUS = 0  
	  BEGIN  
		SET @Contador2=@Contador2+1  
		SET @Parent2=@Parent+'-'+Substring('00',1,3-Len(Convert(varchar,@Contador2)))+Convert(varchar,@Contador2)  
		INSERT INTO #Auxiliar0   
		 SELECT @Parent2, 'ConciliacionesCuentaBancaria'+Convert(varchar,@IdEntidad2), @Entidad2, @Parent, @Contador2, Null,  
				'<a href="/' + @directorio + '/Valor/IndexValores?IdCuentaBancaria='+Convert(varchar,@IdEntidad2)+'&fechainicial=01/01/2000'+'&fechafinal=31/12/'+Convert(varchar,Year(GetDate()))+'">'+@Entidad2+'</a>', 'Conciliaciones', 'SI','Principal'  

		SET @Contador3=0
		SET @TipoComprobanteAnt=-1  
		SET @AñoAnt1=-1  
		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT TipoComprobante, Año, Mes FROM #Auxiliar1 WHERE TipoComprobante=-103 and IdObra=@IdEntidad2 ORDER BY TipoComprobante, Año desc, Mes asc  
		OPEN Cur2  
		FETCH NEXT FROM Cur2 INTO @TipoComprobante, @Año, @Mes  
		WHILE @@FETCH_STATUS = 0  
		  BEGIN  
			IF @TipoComprobante<>@TipoComprobanteAnt
			  BEGIN
				SET @AñoAnt1=-1  
				SET @TipoComprobanteAnt=@TipoComprobante 
			  END

			SELECT @NombreMes = Case When @Mes=1 Then 'Enero' When @Mes=2 Then 'Febrero' When @Mes=3 Then 'Marzo' When @Mes=4 Then 'Abril'   
										When @Mes=5 Then 'Mayo' When @Mes=6 Then 'Junio' When @Mes=7 Then 'Julio' When @Mes=8 Then 'Agosto'  
										When @Mes=9 Then 'Septiembre' When @Mes=10 Then 'Octubre' When @Mes=11 Then 'Noviembre' When @Mes=12 Then 'Diciembre'  
								End  
			SET @FechaInicial='01/'+Substring('00',1,2-Len(Convert(varchar,@Mes)))+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año)  
			SET @Fecha=DateAdd(d,-1,DateAdd(m,1,Convert(datetime,@FechaInicial,103)))  
			SET @FechaFinal=Substring('00',1,2-Len(Convert(varchar,Day(@Fecha))))+Convert(varchar,Day(@Fecha))+'/'+  
							Substring('00',1,2-Len(Convert(varchar,Month(@Fecha))))+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha))  

			IF @AñoAnt1<>@Año  
			  BEGIN  
				SET @AñoAnt1=@Año  
				SET @Contador3=@Contador3+1  
				SET @Parent3=@Parent2+'-'+Substring('00',1,3-Len(Convert(varchar,@Contador3)))+Convert(varchar,@Contador3)  
				INSERT INTO #Auxiliar0   
				 SELECT @Parent3, 'ConciliacionesCuentaBancaria'+Convert(varchar,@IdEntidad2)+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),@Parent2, @Contador3, Null,  
						'<a href="/' + @directorio + '/Valor/IndexValores?IdCuentaBancaria='+Convert(varchar,@IdEntidad2)+'&fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'Conciliaciones', 'SI','Principal'  
			  END  
			SET @Clave=@Parent3+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
			INSERT INTO #Auxiliar0   
			 SELECT @Clave, 'ConciliacionesCuentaBancaria'+Convert(varchar,@IdEntidad2)+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent3, abs(12-@Mes), Null,  
					'<a href="/' + @directorio + '/Valor/IndexValores?IdCuentaBancaria='+Convert(varchar,@IdEntidad2)+'&fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'Conciliaciones', 'NO','Principal'  

			FETCH NEXT FROM Cur2 INTO @TipoComprobante, @Año, @Mes  
		  END  
		CLOSE Cur2  
		DEALLOCATE Cur2  

		FETCH NEXT FROM Cur1 INTO @IdEntidad2, @Entidad2
	  END  
	CLOSE Cur1  
	DEALLOCATE Cur1  

	FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
  END  
CLOSE Cur  
DEALLOCATE Cur  


/*   Conciliacion cajas   */
TRUNCATE TABLE #Auxiliar2
INSERT INTO #Auxiliar2
 SELECT IdCaja, Descripcion
 FROM Cajas 
 WHERE Exists(Select Top 1 a1.TipoComprobante From #Auxiliar1 a1 Where a1.TipoComprobante=-104 and a1.IdObra=Cajas.IdCaja) 
 ORDER by Descripcion

SET @Contador=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEntidad, Entidad FROM #Auxiliar2 ORDER BY Entidad
OPEN Cur  
FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
WHILE @@FETCH_STATUS = 0  
  BEGIN  
	SET @Contador=@Contador+1  
	SET @Parent='01-14-09-'+Substring('00',1,3-Len(Convert(varchar,@Contador)))+Convert(varchar,@Contador)  
	INSERT INTO #Auxiliar0   
	 SELECT @Parent, 'ConciliacionesCajas'+Convert(varchar,@IdEntidad), @Entidad, '01-14-09', @Contador, Null, Null, 'ConciliacionesCajas', 'SI','Principal'  

	SET @Contador2=0
	SET @TipoComprobanteAnt=-1  
	SET @AñoAnt1=-1  
	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT TipoComprobante, Año, Mes FROM #Auxiliar1 WHERE TipoComprobante=-104 and IdObra=@IdEntidad ORDER BY TipoComprobante, Año desc, Mes asc  
	OPEN Cur2  
	FETCH NEXT FROM Cur2 INTO @TipoComprobante, @Año, @Mes  
	WHILE @@FETCH_STATUS = 0  
		BEGIN  
		IF @TipoComprobante<>@TipoComprobanteAnt
			BEGIN
			SET @AñoAnt1=-1  
			SET @TipoComprobanteAnt=@TipoComprobante 
			END

		SELECT @NombreMes = Case When @Mes=1 Then 'Enero' When @Mes=2 Then 'Febrero' When @Mes=3 Then 'Marzo' When @Mes=4 Then 'Abril'   
									When @Mes=5 Then 'Mayo' When @Mes=6 Then 'Junio' When @Mes=7 Then 'Julio' When @Mes=8 Then 'Agosto'  
									When @Mes=9 Then 'Septiembre' When @Mes=10 Then 'Octubre' When @Mes=11 Then 'Noviembre' When @Mes=12 Then 'Diciembre'  
							End  
		SET @FechaInicial='01/'+Substring('00',1,2-Len(Convert(varchar,@Mes)))+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año)  
		SET @Fecha=DateAdd(d,-1,DateAdd(m,1,Convert(datetime,@FechaInicial,103)))  
		SET @FechaFinal=Substring('00',1,2-Len(Convert(varchar,Day(@Fecha))))+Convert(varchar,Day(@Fecha))+'/'+  
						Substring('00',1,2-Len(Convert(varchar,Month(@Fecha))))+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha))  

		IF @AñoAnt1<>@Año  
			BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador2=@Contador2+1  
			SET @Parent2=@Parent+'-'+Substring('00',1,3-Len(Convert(varchar,@Contador2)))+Convert(varchar,@Contador2)  
			INSERT INTO #Auxiliar0   
				SELECT @Parent2, 'ConciliacionesCajas'+Convert(varchar,@IdEntidad)+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),@Parent, @Contador2, Null,  
					'<a href="/' + @directorio + '/Valor/IndexMovimientosCaja?IdCaja='+Convert(varchar,@IdEntidad)+'&fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'ConciliacionesCajas', 'SI','Principal'  
			END  
		SET @Clave=@Parent2+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
			SELECT @Clave, 'ConciliacionesCajas'+Convert(varchar,@IdEntidad)+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent2, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Valor/IndexMovimientosCaja?IdCaja='+Convert(varchar,@IdEntidad)+'&fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'ConciliacionesCajas', 'NO','Principal'  

		FETCH NEXT FROM Cur2 INTO @TipoComprobante, @Año, @Mes  
		END  
	CLOSE Cur2  
	DEALLOCATE Cur2  

	FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
  END  
CLOSE Cur  
DEALLOCATE Cur  


/*   Conciliacion tarjetas   */
TRUNCATE TABLE #Auxiliar2
INSERT INTO #Auxiliar2
 SELECT IdTarjetaCredito, Nombre
 FROM TarjetasCredito 
 WHERE Exists(Select Top 1 a1.TipoComprobante From #Auxiliar1 a1 Where a1.TipoComprobante=-105 and a1.IdObra=TarjetasCredito.IdTarjetaCredito) 
 ORDER by Nombre

SET @Contador=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEntidad, Entidad FROM #Auxiliar2 ORDER BY Entidad
OPEN Cur  
FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
WHILE @@FETCH_STATUS = 0  
  BEGIN  
	SET @Contador=@Contador+1  
	SET @Parent='01-14-11-'+Substring('00',1,3-Len(Convert(varchar,@Contador)))+Convert(varchar,@Contador)  
	INSERT INTO #Auxiliar0   
	 SELECT @Parent, 'ConciliacionesTarjetas'+Convert(varchar,@IdEntidad), @Entidad, '01-14-11', @Contador, Null, Null, 'ConciliacionesTarjetas', 'SI','Principal'  

	SET @Contador2=0
	SET @TipoComprobanteAnt=-1  
	SET @AñoAnt1=-1  
	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT TipoComprobante, Año, Mes FROM #Auxiliar1 WHERE TipoComprobante=-105 and IdObra=@IdEntidad ORDER BY TipoComprobante, Año desc, Mes asc  
	OPEN Cur2  
	FETCH NEXT FROM Cur2 INTO @TipoComprobante, @Año, @Mes  
	WHILE @@FETCH_STATUS = 0  
		BEGIN  
		IF @TipoComprobante<>@TipoComprobanteAnt
			BEGIN
			SET @AñoAnt1=-1  
			SET @TipoComprobanteAnt=@TipoComprobante 
			END

		SELECT @NombreMes = Case When @Mes=1 Then 'Enero' When @Mes=2 Then 'Febrero' When @Mes=3 Then 'Marzo' When @Mes=4 Then 'Abril'   
									When @Mes=5 Then 'Mayo' When @Mes=6 Then 'Junio' When @Mes=7 Then 'Julio' When @Mes=8 Then 'Agosto'  
									When @Mes=9 Then 'Septiembre' When @Mes=10 Then 'Octubre' When @Mes=11 Then 'Noviembre' When @Mes=12 Then 'Diciembre'  
							End  
		SET @FechaInicial='01/'+Substring('00',1,2-Len(Convert(varchar,@Mes)))+Convert(varchar,@Mes)+'/'+Convert(varchar,@Año)  
		SET @Fecha=DateAdd(d,-1,DateAdd(m,1,Convert(datetime,@FechaInicial,103)))  
		SET @FechaFinal=Substring('00',1,2-Len(Convert(varchar,Day(@Fecha))))+Convert(varchar,Day(@Fecha))+'/'+  
						Substring('00',1,2-Len(Convert(varchar,Month(@Fecha))))+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha))  

		IF @AñoAnt1<>@Año  
			BEGIN  
			SET @AñoAnt1=@Año  
			SET @Contador2=@Contador2+1  
			SET @Parent2=@Parent+'-'+Substring('00',1,3-Len(Convert(varchar,@Contador2)))+Convert(varchar,@Contador2)  
			INSERT INTO #Auxiliar0   
				SELECT @Parent2, 'ConciliacionesTarjetas'+Convert(varchar,@IdEntidad)+Convert(varchar,@AñoAnt1), Convert(varchar,@AñoAnt1),@Parent, @Contador2, Null,  
					'<a href="/' + @directorio + '/Valor/IndexMovimientosTarjeta?IdTarjetaCredito='+Convert(varchar,@IdEntidad)+'&fechainicial=01/01/'+Convert(varchar,@AñoAnt1)+'&fechafinal=31/12/'+Convert(varchar,@AñoAnt1)+'">'+Convert(varchar,@AñoAnt1)+'</a>', 'ConciliacionesTarjetas', 'SI','Principal'  
			END  
		SET @Clave=@Parent2+'-'+Substring('00',1,2-Len(Convert(varchar,abs(12-@Mes))))+Convert(varchar,abs(12-@Mes))  
		INSERT INTO #Auxiliar0   
			SELECT @Clave, 'ConciliacionesTarjetas'+Convert(varchar,@IdEntidad)+Convert(varchar,@AñoAnt1)+Convert(varchar,abs(12-@Mes)), @NombreMes, @Parent2, abs(12-@Mes), Null,  
				'<a href="/' + @directorio + '/Valor/IndexMovimientosTarjeta?IdTarjetaCredito='+Convert(varchar,@IdEntidad)+'&fechainicial='+@FechaInicial+'&fechafinal='+@FechaFinal+'">'+@NombreMes+'</a>', 'ConciliacionesTarjetas', 'NO','Principal'  

		FETCH NEXT FROM Cur2 INTO @TipoComprobante, @Año, @Mes  
		END  
	CLOSE Cur2  
	DEALLOCATE Cur2  

	FETCH NEXT FROM Cur INTO @IdEntidad, @Entidad
  END  
CLOSE Cur  
DEALLOCATE Cur  


INSERT INTO #Auxiliar0 Select '01-11-12-01-99','PresupuestosAgrupados','','01-11-12-01',1,Null,Null,'','NO','Principal'  
INSERT INTO #Auxiliar0 Select '01-11-13-01-00','ComparativasAgrupadas','','01-11-13-01',1,Null,Null,'','NO','Principal'  
--INSERT INTO #Auxiliar0 Select '01-11-14-01-00','PedidosAgrupados','','01-11-14-01',1,Null,Null,'','NO','Principal'  
  
--MENU HORIZONTAL  
INSERT INTO #Auxiliar0 Select '80-01','mnuMaster2','Consultas',Null,1,Null,Null,Null,'SI','Horizontal'  
  
INSERT INTO #Auxiliar0 Select '80-01-01','mnuSub0','Almacenes','80-01',1,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-01-01','mnuSubA0','Requerimientos pendientes de asignacion','80-01-01',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Requerimientos pendientes de asignacion">Requerimientos pendientes de asignacion</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-01','mnuSubA0','Requerimientos pendientes de asignacion','80-01-01',1,Null,'<a href="/' + @directorio + '/Requerimiento/RMsPendientesDeAsignar">Requerimientos pendientes de asignacion</a>',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-01-02','mnuSubA0','Pedidos pendientes de recibir','80-01-01',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Pedidos pendientes de recibir">Pedidos pendientes de recibir</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-03','mnuSubA3','Vales emitidos no retirados','80-01-01',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Vales emitidos no retirados">Vales emitidos no retirados</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-04','mnuSubA4','Cardex','80-01-01',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cardex">Cardex</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-05','mnuSubA5','Transporte de mercaderia','80-01-01',5,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Transporte de mercaderia">Transporte de mercaderia</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-01-06','mnuSubA6','Informe de remitos de proveedores','80-01-01',6,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-01-07','mnuSubA7','Informe de vales de consumo','80-01-01',7,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-08','mnuSubA8','Informe de salida de materiales','80-01-01',8,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Salidas de materiales">Informe de salida de materiales</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-09','mnuSubA9','Estadistica de ventas por rubro-articulo','80-01-01',9,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Estadistica de ventas por rubro - articulo">Estadistica de ventas por rubro-articulo</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-01-10','mnuSubA10','Ordenes de trabajo','80-01-01',10,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-11','mnuSubA11','Desarrollo y seguimiento por item de ordenes de compra','80-01-01',11,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Desarrollo y seguimiento por item de ordenes de compra">Desarrollo y seguimiento por item de ordenes de compra</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-01-12','mnuSubA12','Detalle de comprobantes por partida','80-01-01',12,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Movimientos por partida">Detalle de comprobantes por partida</a>',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-02','mnuSub1','Compras','80-01',1,Null,Null,Null,'SI','Horizontal' --tiene la misma clave que el del arbol  
INSERT INTO #Auxiliar0 Select '80-01-02-01','mnuSubC1','Requerimientos y listas de acopio pendientes sin nota de pedido','80-01-02',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Requerimientos pendientes sin pedido">Requerimientos pendientes sin nota de pedido</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-02-02','mnuSubC2','Pedidos pendientes de recibir','80-01-02',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Pedidos pendientes de recibir">Pedidos pendientes de recibir</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-03','mnuSubC3','Estado general de entregas por obra - equipo','80-01-02',3,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-04','mnuSubC4','Activacion de compras de materiales','80-01-02',4,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-05','mnuSubC5','Listas de precios segun pedidos','80-01-02',5,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-06','mnuSubC6','Informe de compras efectuadas por terceros','80-01-02',6,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-07','mnuSubC7','Informe de registro de notas de pedido','80-01-02',7,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-08','mnuSubC8','Asignacion de costos de importacion a pedidos','80-01-02',8,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-09','mnuSubC9','Comparativas (Cubo)','80-01-02',9,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-10','mnuSubC10','Requerimientos dados por cumplidos y/o anulados','80-01-02',10,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-11','mnuSubC11','Listado de costos por obra','80-01-02',11,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-12','mnuSubC12','Recepciones pendientes de ingreso de comprobante','80-01-02',12,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-13','mnuSubC13','Estado de pedidos abiertos','80-01-02',13,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-14','mnuSubC14','Pedidos pendientes por fecha de vencimiento','80-01-02',14,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-15','mnuSubC15','Notas de pedido y materiales recibidos','80-01-02',15,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-02-16','mnuSubC16','Seguimiento de compras','80-01-02',16,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Seguimiento Compras">Seguimiento de compras</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-02-17','mnuSubC17','Nota de pedido con items dados por cumplido','80-01-02',17,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Notas de pedidos con items dados por cumplido">Notas de pedidos con items dados por cumplido</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-18','mnuSubC18','Modificacion de costos','80-01-02',18,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-02-19','mnuSubC19','Listado de pedidos','80-01-02',19,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Listado de pedidos">Listado de pedidos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-20','mnuSubC20','Pedidos pendientes de facturar','80-01-02',20,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-21','mnuSubC21','Subcontratos - Certificaciones','80-01-02',21,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-22','mnuSubC22','Subcontratos - Resumen','80-01-02',22,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-02-23','mnuSubC23','Certificados de subcontratos pendientes de facturar','80-01-02',23,Null,'',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-03','mnuSub2','Proveedores','80-01',1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01','MnuSubPrv0','Retenciones y Percepciones','80-01-03',1,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-01-01','MnuSubPrvRet1','SICORE - Retenciones de impuesto a las ganancias (Control)','80-01-03-01',1,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-02','MnuSubPrvRet2','SICORE - Retenciones Ganancias','80-01-03-01',2,Null,'<a href="/' + @Directorio + '/Reporte/SICORE_RetencionesGanancias_Proveedores">SICORE - Retenciones Ganancias</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-03','MnuSubPrvRet3','SICORE - Retenciones de IVA','80-01-03-01',3,Null,'<a href="/' + @Directorio + '/Reporte/SICORE_RetencionesIVA_Proveedores">SICORE - Retenciones de IVA</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-04','MnuSubPrvRet4','SICORE - Percepciones de IVA','80-01-03-01',4,Null,'<a href="/' + @Directorio + '/Reporte/SICORE_PercepcionesIva_Proveedores">SICORE - Percepciones de IVA</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-05','MnuSubPrvRet5','SIFERE - Percepciones IIBB (Compras) - Convenio multilateral','80-01-03-01',5,Null,'<a href="/' + @Directorio + '/Reporte/SIFERE_PercepcionesIIBB_Convenio_Proveedores">SIFERE - Percepciones IIBB (Compras) - Convenio multilateral</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-06','MnuSubPrvRet6','SIFERE - Percepciones IIBB (Compras) - Jurisdiccion local','80-01-03-01',6,Null,'<a href="/' + @Directorio + '/Reporte/SIFERE_PercepcionesIIBB_JurisdiccionLocal_Proveedores">SIFERE - Percepciones IIBB (Compras) - Jurisdiccion local</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-07','MnuSubPrvRet7','SIFERE - Retenciones IIBB (Pagos)','80-01-03-01',7,Null,'<a href="/' + @Directorio + '/Reporte/SIFERE_RetencionesIIBBPagos_Proveedores">SIFERE - Retenciones IIBB (Pagos)</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-08','MnuSubPrvRet8','SIFERE - SIRCREB','80-01-03-01',8,Null,'<a href="/' + @Directorio + '/Reporte/SIFERE_SIRCREB_Proveedores">SIFERE - SIRCREB</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-01-09','MnuSubPrvRet9','CITI','80-01-03-01',9,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-10','MnuSubPrvRet10','SUSS','80-01-03-01',10,Null,'<a href="/' + @Directorio + '/Reporte/SUSS_Proveedores">SUSS</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-01-11','MnuSubPrvRet11','SIRE','80-01-03-01',11,Null,'<a href="/' + @Directorio + '/Reporte/SIRE_Proveedores">SIRE</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-02','mnuSubPrv1','Resumen de compras por proveedor','80-01-03',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Proveedores - Resumen de compras">Resumen de compras por proveedor</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-03','mnuSubPrv2','Ranking de compras por proveedor','80-01-03',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Ranking proveedores">Ranking de compras por proveedor</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-04','mnuSubPrv3','Listado de comprobantes ingresados','80-01-03',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Proveedores - Listado de comprobantes detallado">Listado de comprobantes ingresados</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-05','mnuSubPrv4','Listado de saldos de proveedores','80-01-03',5,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Saldos Proveedores">Listado de saldos de proveedores</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-06','mnuSubPrv5','Comprobantes pendientes de imputacion','80-01-03',6,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-07','mnuSubPrv6','Detalle de saldos por tipo de proveedor','80-01-03',7,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-08','mnuSubPrv7','OPs de fondo fijo pendientes de control (dif. cambio)','80-01-03',8,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-09','mnuSubPrv8','Deuda vencida a fecha','80-01-03',9,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Deuda Vencida a Fecha">Deuda vencida a fecha</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-10','mnuSubPrv9','Listado de ordenes de pago','80-01-03',10,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Listado de ordenes de pago">Listado de ordenes de pago</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-11','mnuSubPrv10','Listado de proveedores - rubros provistos','80-01-03',11,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-12','mnuSubPrv11','Listado de saldos de proveedores entre fechas','80-01-03',12,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-13','mnuSubPrv12','Listado resumen de fondos fijos Por Rendicion','80-01-03',13,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-14','mnuSubPrv13','Anticipos a proveedores','80-01-03',14,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-15','mnuSubPrv14','Caja egresos','80-01-03',15,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-16','mnuSubPrv15','Listado de saldos de fondos fijos (todos)','80-01-03',16,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-03-16','mnuSubPrv16','Informe de proyeccion de egresos','80-01-03',17,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-03-16','mnuSubPrv17','Reporte de seguimiento por IP','80-01-03',18,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Reporte de seguimiento por IP">Reporte de seguimiento por IP</a>',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-04','mnuSub3','Clientes','80-01',1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01','MnuSubCli0','Retenciones y Percepciones','80-01-04',1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01-01','MnuSubCliRet0','SICORE - Retenciones Ganancias','80-01-04-01',1,Null,'<a href="/' + @Directorio + '/Reporte/SICORE_RetencionesGanancias_Clientes">SICORE - Retenciones Ganancias</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01-02','MnuSubCliRet1','SICORE - Retenciones de IVA','80-01-04-01',2,Null,'<a href="/' + @Directorio + '/Reporte/SICORE_RetencionesIVA_Clientes">SICORE - Retenciones de IVA</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01-03','MnuSubCliRet2','SICORE - Percepciones de IVA','80-01-04-01',3,Null,'<a href="/' + @Directorio + '/Reporte/SICORE_PercepcionesIVA_Clientes">SICORE - Percepciones de IVA</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01-04','MnuSubCliRet3','SIFERE - Percepciones IIBB (Ventas)','80-01-04-01',4,Null,'<a href="/' + @Directorio + '/Reporte/SIFERE_PercepcionesIIBB_Clientes">SIFERE - Percepciones IIBB (Ventas)</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01-05','MnuSubCliRet4','SIFERE - Retenciones IIBB (Cobranzas)','80-01-04-01',5,Null,'<a href="/' + @Directorio + '/Reporte/SIFERE_RetencionesIIBB_Clientes">SIFERE - Retenciones IIBB (Cobranzas)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-01-06','MnuSubCliRet5','CITI','80-01-04-01',6,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-01-07','MnuSubCliRet6','SUSS','80-01-04-01',7,Null,'<a href="/' + @Directorio + '/Reporte/SUSS_Clientes">SUSS</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-02','MnuSubCli1','Resumen de ventas por cliente','80-01-04',2,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-03','MnuSubCli2','Ranking de ventas por cliente','80-01-04',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Ranking de ventas por cliente">Ranking de ventas por cliente</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-04','MnuSubCli3','Listado de comprobantes ingresados','80-01-04',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Listado de comprobantes de venta ingresados">Listado de comprobantes de venta ingresados</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-05','MnuSubCli4','Listado de saldos de clientes','80-01-04',5,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Saldos Clientes">Listado de saldos de clientes</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-06','MnuSubCli5','Remitos pendientes de facturar','80-01-04',6,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Remitos de venta pendientes de facturar">Remitos de venta pendientes de facturar</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-07','MnuSubCli6','Desarrollo de items de ordenes de compra','80-01-04',7,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Desarrollo y seguimiento por item de ordenes de compra">Desarrollo de items de ordenes de compra</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-08','MnuSubCli7','Creditos vencidos a fecha','80-01-04',8,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Creditos Vencidos a Fecha">Creditos vencidos a fecha</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-09','MnuSubCli8','Caja ingresos','80-01-04',9,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Caja ingresos">Caja ingresos</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-10','MnuSubCli9','Analisis de cobranzas','80-01-04',10,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Analisis de cobranzas">Analisis de cobranzas</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-04-11','MnuSubCli10','Listado de ordenes de compra','80-01-04',11,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Listado de ordenes de compra">Listado de ordenes de compra</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-12','MnuSubCli11','Cobranzas por cobrador','80-01-04',12,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-13','MnuSubCli12','Ranking de ventas por vendedor','80-01-04',13,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-14','MnuSubCli13','Entregas / Devoluciones','80-01-04',14,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-15','MnuSubCli14','Analisis de cobranzas / facturacion','80-01-04',15,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-16','MnuSubCli15','Control de facturacion electronica','80-01-04',16,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-17','MnuSubCli16','Remitos - Movimiento de materiales por cliente','80-01-04',17,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Remitos por cliente">Remitos - Movimiento de materiales por cliente</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-04-18','MnuSubCli17','Resumen por certificaciones de obra','80-01-04',18,Null,'',Null,'NO','Horizontal'  
  
INSERT INTO #Auxiliar0 Select '80-01-05','mnuSub4','Fabrica','80-01',1,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-01','MnuSubF0','Disponibilidad de materiales (segun lista de materiales)','80-01-05',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-02','MnuSubF1','Consulta de revisiones','80-01-05',2,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-03','MnuSubF2','Informe general de controles de calidad','80-01-05',3,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-05-04','MnuSubF3','Informe de materiales recibidos','80-01-05',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Informe de materiales recibidos">Informe de materiales recibidos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-05','MnuSubF4','Informe de materiales recibidos y aprobados','80-01-05',5,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-06','MnuSubF5','Materiales controlados - remitos de rechazo','80-01-05',6,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-07','MnuSubF6','Informe de materiales recibidos con datos de transporte','80-01-05',7,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-08','MnuSubF7','Informe de salida de materiales con datos de transporte','80-01-05',8,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-05-09','MnuSubF8','Informe de materiales recibidos para obras','80-01-05',9,Null,'',Null,'NO','Horizontal'  

--INSERT INTO #Auxiliar0 Select '80-01-06','mnuSub5','Obras','80-01',1,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-06-01','MnuSubO0','Obras, equipos y planos','80-01-06',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-06-02','MnuSubO1','Estado de polizas','80-01-06',2,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-06-03','MnuSubO2','Detalle de equipos instalados por fecha','80-01-06',3,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-06-04','MnuSubO3','Estado de equipos','80-01-06',4,Null,'',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-07','mnuSub6','Planeamiento','80-01',1,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-01','MnuSubP0','Listados de acopio sumarizados por obra','80-01-07',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-02','MnuSubP1','Listados de materiales sumarizados por obra','80-01-07',2,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-03','MnuSubP2','Requerimientos de materiales sumarizados por obra','80-01-07',3,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-04','MnuSubP3','LM - LA - RM - RS','80-01-07',4,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-05','MnuSubP4','Reservas de stock sumarizados por obra','80-01-07',5,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-06','MnuSubP5','Requerimientos y listas de acopio pendientes sin nota de pedido','80-01-07',6,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-07','MnuSubP6','Activacion de compras de materiales','80-01-07',7,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-08','MnuSubP7','Costos de materiales por equipo','80-01-07',8,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-09','MnuSubP8','Historico de equipos instalados','80-01-07',9,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-07-10','MnuSubP9','Salidas de materiales','80-01-07',10,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Salidas de materiales">Salidas de materiales</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-11','MnuSubP10','Informe de gastos por OT','80-01-07',11,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-12','MnuSubP11','Control lista de materiales salidas por destino','80-01-07',12,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-07-13','MnuSubP12','Desarrollo de items de RMs','80-01-07',13,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Desarrollo y seguimiento por item de requerimiento">Desarrollo y seguimiento por item de requerimiento</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-14','MnuSubP13','Analisis de materiales en obra y desvios','80-01-07',14,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-15','MnuSubP14','Asignacion de salidas y comprobantes a presupuesto de obra','80-01-07',15,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-16','MnuSubP15','Salida de materiales - control de transportistas','80-01-07',16,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-17','MnuSubP16','Requerimientos con desliberaciones y/o eliminacion de firmas','80-01-07',17,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-07-18','MnuSubP17','Control de facturas y recepciones','80-01-07',18,Null,'',Null,'NO','Horizontal'  
  
INSERT INTO #Auxiliar0 Select '80-01-08','mnuSub7','Stock','80-01',1,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-08-01','MnuSubS0','Stock actual','80-01-08',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-08-02','MnuSubS1','Costos promedios ponderados','80-01-08',2,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-08-03','MnuSubS2','Stock de articulos a fecha','80-01-08',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Stock a fecha">Stock a fecha</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-08-04','MnuSubS3','Stock de articulos a fecha (Cubo)','80-01-08',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Stock 2">Stock a fecha (Cubo)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-08-05','MnuSubS4','Control stock reposicion - minimo','80-01-08',5,Null,'',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-09','mnuSub8','Contabilidad','80-01',1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-01','mnuSubCo0','Diario','80-01-09',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Diario">Diario</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-02','mnuSubCo1','Mayor de cuentas detallado','80-01-09',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Mayor">Mayor de cuentas detallado</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-03','mnuSubCo2','Balance de sumas y saldos','80-01-09',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Balance2">Balance de sumas y saldos</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-04','mnuSubCo3','Balance de sumas y saldos (con apertura)','80-01-09',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Balance">Balance de sumas y saldos (con apertura)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-05','mnuSubCo4','Resumen por rubros contables','80-01-09',5,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-06','mnuSubCo5','IVA Ventas','80-01-09',6,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=IVA Ventas">IVA Ventas</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-07','mnuSubCo6','IVA Compras','80-01-09',7,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=IVA Compras">IVA Compras</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-08','mnuSubCo7','IVA Compras detallado','80-01-09',8,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-09','mnuSubCo8','Resolucion 1361','80-01-09',9,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-10','mnuSubCo9','Resolucion 1547','80-01-09',10,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-11','mnuSubCo9','Activo fijo','80-01-09',11,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-11-01','mnuDetAF0','Amortizaciones activo fijo (contable)','80-01-09-11',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-11-02','mnuDetAF1','Revaluo activo fijo','80-01-09-11',2,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-11-03','mnuDetAF2','Amortizaciones activo fijo (impositivo)','80-01-09-11',3,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-12','mnuSubCo10','Cierre de ejercicio','80-01-09',12,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-13','mnuSubCo11','Apertura de ejercicio','80-01-09',13,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-14','mnuSubCo12','Detalle imputaciones por rubro p/presupuesto financiero','80-01-09',14,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-15','mnuSubCo13','Cuadro de ingresos y egresos','80-01-09',15,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-15-01','80-01-09-15-01','Defincion de cuadro','80-01-09-15',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-15-02','80-01-09-15-02','Emision de cuadro','80-01-09-15',2,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16','mnuSubCo14','Cuadro de flujo de caja y estado de resultados','80-01-09',16,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-01','mnuSubCoB0','Definicion de cuadros','80-01-09-16',1,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-02','mnuSubCoB1','Emision de flujo de caja','80-01-09-16',2,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-03','mnuSubCoB2','Emision de flujo de caja (x Mes + Proyectado) Modelo 1','80-01-09-16',3,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-04','mnuSubCoB3','Emision de flujo de caja (Mes + Acumulado)','80-01-09-16',4,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-05','mnuSubCoB4','Emision de flujo de caja (x Mes + Proyectado) Modelo 2','80-01-09-16',5,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-06','mnuSubCoB5','Emision de flujo de caja (x Mes + Desvios)','80-01-09-16',6,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-07','mnuSubCoB6','Emision de estado de resultados (x Mes + Desvios) Modelo 1','80-01-09-16',7,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-08','mnuSubCoB7','Emision de estado de resultados (x Mes + Desvios) Modelo 2','80-01-09-16',8,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-09','mnuSubCoB8','Emision de estado de resultados (x Mes + Proyectado)','80-01-09-16',9,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-10','mnuSubCoB9','Emision de estado de resultados (x Mes + Acumulado) Modelo 1','80-01-09-16',10,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-16-11','mnuSubCoB10','Emision de estado de resultados (x Mes + Acumulado) Modelo 2','80-01-09-16',11,Null,'',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-17','mnuSubCo15','IVA Compras detallado','80-01-09',17,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=IVA Compras detallado">IVA Compras detallado</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18','mnuSubCo16','Subdiarios','80-01-09',18,Null,Null,Null,'SI','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-01','MnuSubCoC0','Subdiario de proveedores','80-01-09-18',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de proveedores">Subdiario de proveedores</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-02','MnuSubCoC1','Subdiario de pagos','80-01-09-18',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de pagos">Subdiario de pagos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-03','MnuSubCoC2','Subdiario de clientes','80-01-09-18',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de clientes">Subdiario de clientes</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-04','MnuSubCoC3','Subdiario de caja y bancos','80-01-09-18',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de caja y bancos">Subdiario de caja y bancos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-05','MnuSubCoC4','Subdiario de cobranzas','80-01-09-18',5,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de cobranzas">Subdiario de cobranzas</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-06','MnuSubCoC5','Subdiario de iva ventas','80-01-09-18',6,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de iva ventas">Subdiario de iva ventas</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-18-07','MnuSubCoC6','Subdiario de iva compras','80-01-09-18',7,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Subdiario de iva compras">Subdiario de iva compras</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-09-19','mnuSubCo17','Diario IGJ','80-01-09',19,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Diario IGJ">Diario IGJ</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-09-20','mnuSubCo18','Regimen de informacion de compras y ventas','80-01-09',20,Null,'<a href="/' + @Directorio + '/Reporte/RegimenDeInformacionDeComprasYVentas">Regimen de informacion de compras y ventas</a>',Null,'NO','Horizontal'  
 
INSERT INTO #Auxiliar0 Select '80-01-10','mnuSub9','Informes gerenciales','80-01',1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-01','mnuSubCom0','Ordenes de compra pendientes de facturar','80-01-10',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Ordenes de compra pendientes de facturar">Ordenes de compra pendientes de facturar</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-02','mnuSubCom1','Proyeccion de egresos','80-01-10',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Proyeccion de egresos">Proyeccion de egresos</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-03','mnuSubCom2','Proyeccion de egresos (detallados)','80-01-10',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Egresos Proyectados 2">Proyeccion de egresos (detallados)</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-04','mnuSubCom3','Cuadro de gastos (detallados)','80-01-10',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Gastos Detallados 2">Cuadro de gastos (detallados)</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-05','mnuSubCom4','Ventas (detalladas)','80-01-10',5,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Ventas (detalladas)">Ventas (detalladas)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-06','mnuSubCom5','Resumen posicion financiera','80-01-10',6,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Resumen posicion financiera">Resumen posicion financiera</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-07','mnuSubCom6','Cuadro de Ingresos - Egresos por Obra','80-01-10',7,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Ingresos Egresos Por Obra 3">Cubo ingresos - egresos por obra</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-08','mnuSubCom7','Analisis de comprobantes para presupuesto financiero','80-01-10',8,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Analisis de comprobantes para presupuesto financiero">Analisis de comprobantes para presupuesto financiero</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-09','mnuSubCom8','Presupuesto financiero por rubro contable','80-01-10',9,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Presupuesto Financiero">Presupuesto financiero por rubro contable</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-10','mnuSubCom9','Presupuesto economico por cuenta','80-01-10',10,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Presupuesto economico por cuenta">Presupuesto economico por cuenta</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-11','mnuSubCom10','Saldos de comprobantes por proveedor - obra','80-01-10',11,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Saldos de comprobantes por proveedor - obra">Saldos de comprobantes por proveedor - obra</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-12','mnuSubCom11','IVA ventas - compras por obra','80-01-10',12,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=IVA ventas - compras por obra">IVA ventas - compras por obra</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-13','mnuSubCom12','Costos de importacion','80-01-10',13,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Costos de importacion">Costos de importacion</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-14','mnuSubCom13','Ventas en cuotas','80-01-10',14,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Ventas en cuotas">Ventas en cuotas</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-15','mnuSubCom14','Reserva presupuestaria','80-01-10',15,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Reserva presupuestaria">Reserva presupuestaria</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-16','mnuSubCom15','AVL','80-01-10',16,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=AVL">AVL</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-17','mnuSubCom16','Reintegros (ComEx)','80-01-10',17,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Reintegros (ComEx)">Reintegros (ComEx)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-18','mnuSubCom17','Comprobantes comercio exterior','80-01-10',18,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Comprobantes comercio exterior">Comprobantes comercio exterior</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-19','mnuSubCom18','Analisis Pedidos - Entregas','80-01-10',19,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Analisis Pedidos - Entregas">Analisis Pedidos - Entregas</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-10-20','mnuSubCom19','Resumen posicion financiera (Cubo)','80-01-10',20,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cubo Posicion Financiera">Resumen posicion financiera (Cubo)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-21','mnuSubCom20','Cuadro de Egresos (detallados por obra)','80-01-10',21,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cuadro de Egresos (detallados por obra)">Cuadro de Egresos (detallados por obra)</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-22','mnuSubCom21','Resumen posicion financiera 2','80-01-10',22,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Resumen posicion financiera 2">Resumen posicion financiera 2</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-23','mnuSubCom22','Informe Dominio - Equipo - Sim','80-01-10',23,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Informe Dominio - Equipo - Sim">Informe Dominio - Equipo - Sim</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-24','mnuSubCom23','Resumen de gastos por rubros contables','80-01-10',24,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Resumen de gastos por rubros contables">Resumen de gastos por rubros contables</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-10-25','mnuSubCom24','Analisis de contribucion por obra','80-01-10',25,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Analisis de contribucion por obra">Analisis de contribucion por obra</a>',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-01-11','mnuSub10','Bancos','80-01',1,Null,Null,Null,'SI','Horizontal'
INSERT INTO #Auxiliar0 Select '80-01-11-01','MnuSubBco0','Valores a depositar','80-01-11',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Valores a depositar">Valores a depositar</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-11-02','MnuSubBco1','Saldos a fecha','80-01-11',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Saldos a fecha">Saldos a fecha</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-11-03','MnuSubBco2','Retenciones','80-01-11',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Retenciones">Retenciones</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-11-04','MnuSubBco3','Valores diferidos pendientes','80-01-11',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Valores diferidos pendientes">Valores diferidos pendientes</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-01-11-05','MnuSubBco4','Cheques anulados','80-01-11',5,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Cheques anulados">Cheques anulados</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-11-06','MnuSubBco5','Posicion bancos','80-01-11',6,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Posicion bancos">Posicion bancos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-11-07','MnuSubBco6','Reporte financiero por rubro','80-01-11',7,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Reporte financiero por rubro">Reporte financiero por rubro</a>',Null,'NO','Horizontal'  

--INSERT INTO #Auxiliar0 Select '80-01-12','mnuSub11','Personal','80-01',1,Null,Null,Null,'SI','Horizontal'
--INSERT INTO #Auxiliar0 Select '80-01-12-01','MnuSubPer0','Estado anticipos al personal','80-01-12',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Estado anticipos al personal">Estado anticipos al personal</a>',Null,'NO','Horizontal'  

--INSERT INTO #Auxiliar0 Select '80-01-13','mnuSub12','ProntoSat','80-01',1,Null,Null,Null,'SI','Horizontal'
--INSERT INTO #Auxiliar0 Select '80-01-13-01','MnuSubSAT0','Control de remitos a SAT','80-01-13',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Control de remitos a SAT">Control de remitos a SAT</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-13-02','MnuSubSAT0','Recepciones en SAT','80-01-13',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Recepciones en SAT">Recepciones en SAT</a>',Null,'NO','Horizontal'  

--INSERT INTO #Auxiliar0 Select '80-01-14','mnuSub13','Transportes','80-01',1,Null,Null,Null,'SI','Horizontal'
--INSERT INTO #Auxiliar0 Select '80-01-14-01','MnuSubT0','Asignacion de tarifas de fletes','80-01-14',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Asignacion de tarifas de fletes">Asignacion de tarifas de fletes</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-14-02','MnuSubT1','Informe de viajes y gastos','80-01-14',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Informe de viajes y gastos">Informe de viajes y gastos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-14-03','MnuSubT2','Liquidacion de fletes','80-01-14',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Liquidacion de fletes">Liquidacion de fletes</a>',Null,'NO','Horizontal'  

--INSERT INTO #Auxiliar0 Select '80-01-15','mnuSub14','Modulos especiales','80-01',1,Null,Null,Null,'SI','Horizontal'
--INSERT INTO #Auxiliar0 Select '80-01-15-01','MnuSubMod0','Polizas de obras','80-01-15',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Polizas de obras">Polizas de obras</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-15-02','MnuSubMod1','Polizas de equipos','80-01-15',2,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Polizas de equipos">Polizas de equipos</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-15-03','MnuSubMod2','Planes','80-01-15',3,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Planes">Planes</a>',Null,'NO','Horizontal'  
--INSERT INTO #Auxiliar0 Select '80-01-15-04','MnuSubMod3','Planes a vencer a fecha','80-01-15',4,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Planes a vencer a fecha">Planes a vencer a fecha</a>',Null,'NO','Horizontal'  

--INSERT INTO #Auxiliar0 Select '80-01-16','mnuSub15','Presupuesto de obras','80-01',1,Null,Null,Null,'SI','Horizontal'
--INSERT INTO #Auxiliar0 Select '80-01-16-01','MnuSubPre0','Control de consumos (Hs.Hombre - Hs.Equipos)','80-01-16',1,Null,'<a href="/' + @directorio + '/Reporte.aspx?ReportName=Control de consumos (Hs.Hombre - Hs.Equipos)">Control de consumos (Hs.Hombre - Hs.Equipos)</a>',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-02','mnuMaster4','Seguridad',Null,1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-20','mnuSeg0','Usuarios Web','80-02',1,Null,'<a href="/' + @directorio + '/MvcMembership/UserAdministration">Usuarios Web</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-01','mnuSeg0','Definicion de accesos','80-02',2,Null,'<a href="/' + @directorio + '/Acceso/Edit/-1">Definicion de accesos</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-02','mnuSeg1','Definicion de autorizaciones','80-02',3,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-03','mnuSeg2','Autorizacion de documentos','80-02',4,Null,'<a href="/' + @directorio + '/Autorizacion">Autorizacion de documentos</a>',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-04','mnuSeg3','Control del circuito de firmas','80-02',5,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-05','mnuSeg4','Control de lotes transmitidos','80-02',6,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-06','mnuSeg5','Destinatarios de mensajes por eventos','80-02',7,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-07','mnuSeg6','Ver mensajes para usuario actual','80-02',8,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-08','mnuSeg7','Definicion de anulacion de comprobantes','80-02',9,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-09','mnuSeg8','Log de movimientos','80-02',10,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-10','mnuSeg9','Configuracion de usuarios (Pronto Ini)','80-02',11,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-02-11','mnuSeg10','Control facturacion electronica','80-02',12,Null,'',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-03','mnuMaster5','Utilidades',Null,1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01','MnuUti0','Importacion de comprobantes','80-03',1,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-01','MnuUtiImp0','Imp. de datos desde DataNet','80-03-01',1,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-02','MnuUtiImp1','Imp. de conjuntos ( Excel )','80-03-01',2,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-03','MnuUtiImp2','Imp. de cobranzas ( valores )','80-03-01',3,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-04','MnuUtiImp3','Imp. de cobranzas ( efectivo )','80-03-01',4,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-05','MnuUtiImp4','Imp. de cobranzas ( TXT )','80-03-01',5,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-06','MnuUtiImp5','Imp. de cobranzas ( Pago Facil )','80-03-01',6,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-07','MnuUtiImp6','Imp. de comprobantes de proveedores desde obra','80-03-01',7,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-08','MnuUtiImp7','Imp. de comprobantes de fondo fijo desde obra','80-03-01',8,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-09','MnuUtiImp8','Imp. de ordenes de pago ( Excel )','80-03-01',9,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-10','MnuUtiImp9','Imp. de requerimientos ( Excel )','80-03-01',10,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-11','MnuUtiImp10','Imp. de articulos ( Excel )','80-03-01',11,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-12','MnuUtiImp11','Imp. de comprobantes de proveedores desde obra (Tipo FF)','80-03-01',12,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-13','MnuUtiImp12','Imp. de asientos contables','80-03-01',13,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-14','MnuUtiImp13','Imp. de notas de debito ( Excel )','80-03-01',14,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-15','MnuUtiImp14','Imp. de cobranzas ( x Debitos bancarios )','80-03-01',15,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-16','MnuUtiImp15','Imp. de proveedores','80-03-01',16,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-17','MnuUtiImp16','Imp. de comprobantes de venta (FA - ND - NC)','80-03-01',17,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-18','MnuUtiImp17','Imp. de ajustes de stock','80-03-01',18,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-19','MnuUtiImp18','Imp. de salida de materiales (con equipo destino)','80-03-01',19,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-01-20','MnuUtiImp19','Imp. de presupuesto economico','80-03-01',20,Null,'',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-03-02','MnuUti1','Utilidades PRONTO','80-03',2,Null,Null,Null,'SI','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-01','MnuUtiPRONTO0','Enviar novedades a PRONTO SAT','80-03-02',1,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-02','MnuUtiPRONTO1','Enviar tablas completas a PRONTO SAT','80-03-02',2,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-03','MnuUtiPRONTO2','Importar novedades desde PRONTO SAT','80-03-02',3,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-04','MnuUtiPRONTO3','Importar novedades desde PRONTO SAT','80-03-02',4,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-05','MnuUtiPRONTO4','Exportar comprobantes (XML)','80-03-02',5,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-06','MnuUtiPRONTO5','Enviar tablas completas a PRONTO','80-03-02',6,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-07','MnuUtiPRONTO6','Importar novedades desde PRONTO','80-03-02',7,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-08','MnuUtiPRONTO7','Enviar novedades a PRONTO BALANZA','80-03-02',8,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-02-09','MnuUtiPRONTO8','Importar novedades desde PRONTO BALANZA','80-03-02',9,Null,'',Null,'NO','Horizontal'  

INSERT INTO #Auxiliar0 Select '80-03-03','MnuUti2','Gen. autom. de fact. de venta anuladas','80-03',3,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-04','MnuUti3','Anulacion masiva de fact. generadas (ya existentes)','80-03',4,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-05','MnuUti4','Prefacturacion (desde ordenes de compra autom.)','80-03',5,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-06','MnuUti5','Gen. de fact. (desde ordenes de compra autom.)','80-03',6,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-07','MnuUti6','Registro de ingreso de bienes de uso','80-03',7,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-08','MnuUti7','Generar/Importar informacion impositiva','80-03',8,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-09','MnuUti8','Definicion de bases para consolidacion','80-03',9,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-10','MnuUti9','Consolidacion contable','80-03',10,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-11','MnuUti10','Cierre Z','80-03',11,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-12','MnuUti11','Definir grupos de cuentas para ajustes','80-03',12,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-13','MnuUti12','Gen. archivo de debitos por fact. para bancos','80-03',13,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-14','MnuUti13','Cambios de ubicacion de materiales','80-03',14,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-15','MnuUti14','Gen. de pagos por lote de deuda','80-03',15,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-16','MnuUti15','Gen. de asiento de sueldos desde distrib. de horas','80-03',16,Null,'',Null,'NO','Horizontal'  
INSERT INTO #Auxiliar0 Select '80-03-17','MnuUti16','Gen. de asiento de cheques de pago diferido','80-03',17,Null,'',Null,'NO','Horizontal'  
    
-- la descripcion del nodo pudo haber cambiado, sin que haya cambiado la del IdItem (el cambio de un mes a otro de una rm, o un Nuevo mes, porque el orden es descendente).   
-- No es suficiente con verificar el EXISTS. ver cómo solucionar    
-- LO MISMO PASA SI UN NODO DEJA DE TENER PERMISO, y ES CORRIDO PARA ARRIBA!!!!!! (usando el IdItem anterior) -Cómo? si esos son fijos!  
  
DELETE Tree WHERE Imagen='ComprobantesPrv'    
DELETE Tree WHERE Imagen='Requerimientos'    
DELETE Tree WHERE Imagen='Pedidos'    
DELETE Tree WHERE Imagen='FondoFijo'    
  
INSERT INTO Tree    
 SELECT * FROM #Auxiliar0    
 WHERE Not Exists(Select Top 1 Tree.IdItem From Tree Where Tree.IdItem=#Auxiliar0.IdItem) and not IdItem is null   
   
SELECT * FROM #Auxiliar0 ORDER BY IdItem, Orden    
    
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3

go



