CREATE Procedure [dbo].[Articulos_TX_AVL]

@IdTipoEquipo int,
@FechaDesde datetime, 
@IdAbonos varchar(100), 
@IdSeguros varchar(100), 
@IdGastos varchar(100), 
@IdVoiceAccess varchar(100), 
@IdGeolocalizador varchar(100)

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	
			(
			 IdArticulo INTEGER,
			 IdArticuloDominio INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  IdArticulo,
  Null,
  Null
 FROM Articulos 
 WHERE IsNull(Articulos.IdTipo,0)=@IdTipoEquipo

UPDATE #Auxiliar1
SET IdArticuloDominio=(Select Top 1 Obras.IdArticuloAsociado
			From DetalleObrasEquiposInstalados doei
			Left Outer Join Obras On doei.IdObra=Obras.IdObra
			Where doei.IdArticulo=#Auxiliar1.IdArticulo and doei.FechaDesinstalacion is null
			Order by doei.FechaInstalacion Desc)
UPDATE #Auxiliar1
SET IdObra=(Select Top 1 Obras.IdObra
		From DetalleObrasEquiposInstalados doei
		Left Outer Join Obras On doei.IdObra=Obras.IdObra
		Where doei.IdArticulo=#Auxiliar1.IdArticulo and doei.FechaDesinstalacion is null
		Order by doei.FechaInstalacion Desc)

CREATE TABLE #Auxiliar10	
			(
			 IdArticulo INTEGER,
			 IdArticuloAsociado INTEGER,
			 FechaOrdenCompra DATETIME,
			 Precio1 NUMERIC(18,2),
			 Precio2 NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (IdArticuloAsociado,FechaOrdenCompra DESC) ON [PRIMARY]
INSERT INTO #Auxiliar10 
 SELECT doc.IdArticulo, Obras.IdArticuloAsociado, OrdenesCompra.FechaOrdenCompra, 
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=1 Then doc.Precio Else 0 End,
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)>1 Then doc.Precio Else 0 End
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @IdAbonos)<>0 and 
	(IsNull(doc.CantidadMesesAFacturar,0)=0 or Dateadd(m,IsNull(doc.CantidadMesesAFacturar,0),IsNull(doc.FechaComienzoFacturacion,0))>=@FechaDesde) and 
	Not (IsNull(doc.FacturacionAutomatica,'')='NO' and IsNull(doc.Cumplido,'')='SI')

CREATE TABLE #Auxiliar11	
			(
			 IdArticulo INTEGER,
			 IdArticuloAsociado INTEGER,
			 FechaOrdenCompra DATETIME,
			 Precio1 NUMERIC(18,2),
			 Precio2 NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (IdArticuloAsociado,FechaOrdenCompra DESC) ON [PRIMARY]
INSERT INTO #Auxiliar11 
 SELECT doc.IdArticulo, Obras.IdArticuloAsociado, OrdenesCompra.FechaOrdenCompra, 
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=1 Then doc.Precio Else 0 End,
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)>1 Then doc.Precio Else 0 End
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @IdSeguros)<>0 and 
	Not (IsNull(doc.FacturacionAutomatica,'')='NO' and IsNull(doc.Cumplido,'')='SI')

CREATE TABLE #Auxiliar12	
			(
			 IdArticulo INTEGER,
			 IdArticuloAsociado INTEGER,
			 FechaOrdenCompra DATETIME,
			 Precio1 NUMERIC(18,2),
			 Precio2 NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar12 ON #Auxiliar12 (IdArticuloAsociado,FechaOrdenCompra DESC) ON [PRIMARY]
INSERT INTO #Auxiliar12 
 SELECT doc.IdArticulo, Obras.IdArticuloAsociado, OrdenesCompra.FechaOrdenCompra, 
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=1 Then doc.Precio Else 0 End,
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)>1 Then doc.Precio Else 0 End
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @IdGastos)<>0 and 
	Not (IsNull(doc.FacturacionAutomatica,'')='NO' and IsNull(doc.Cumplido,'')='SI')

CREATE TABLE #Auxiliar13
			(
			 IdArticulo INTEGER,
			 IdArticuloAsociado INTEGER,
			 FechaOrdenCompra DATETIME,
			 Precio1 NUMERIC(18,2),
			 Precio2 NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar13 ON #Auxiliar13 (IdArticuloAsociado,FechaOrdenCompra DESC) ON [PRIMARY]
INSERT INTO #Auxiliar13
 SELECT doc.IdArticulo, Obras.IdArticuloAsociado, OrdenesCompra.FechaOrdenCompra, 
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=1 Then doc.Precio Else 0 End,
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)>1 Then doc.Precio Else 0 End
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @IdVoiceAccess)<>0 and 
	Not (IsNull(doc.FacturacionAutomatica,'')='NO' and IsNull(doc.Cumplido,'')='SI')

CREATE TABLE #Auxiliar14
			(
			 IdArticulo INTEGER,
			 IdArticuloAsociado INTEGER,
			 FechaOrdenCompra DATETIME,
			 Precio1 NUMERIC(18,2),
			 Precio2 NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar14 ON #Auxiliar14 (IdArticuloAsociado,FechaOrdenCompra DESC) ON [PRIMARY]
INSERT INTO #Auxiliar14
 SELECT doc.IdArticulo, Obras.IdArticuloAsociado, OrdenesCompra.FechaOrdenCompra, 
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=1 Then doc.Precio Else 0 End,
	Case When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)>1 Then doc.Precio Else 0 End
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @IdGeolocalizador)<>0 and 
	Not (IsNull(doc.FacturacionAutomatica,'')='NO' and IsNull(doc.Cumplido,'')='SI')

SET NOCOUNT OFF

SELECT 
 Articulos.IdArticulo, 
 Articulos.Datos1 as [Linea],
 Grados.Descripcion as [Tipo],
 Articulos.Descripcion as [ESN],
 Articulos.CodigoLoteo as [NAM1],
 Articulos.Adrema as [NAM2],
 Articulos.NumeroInventario as [Id],
 Articulos.ModeloEspecifico as [Propietario],
 Articulos.Autorizacion as [C/A],
 Clientes.RazonSocial as [Empresa],
 (Select Top 1 doei.FechaInstalacion From DetalleObrasEquiposInstalados doei Where doei.IdArticulo=#Auxiliar1.IdArticulo Order by doei.FechaInstalacion Desc) as [FechaInstalacion],
 (Select Top 1 doei.FechaInstalacion From DetalleObrasEquiposInstalados doei Where doei.IdArticulo=#Auxiliar1.IdArticulo Order by doei.FechaInstalacion) as [FechaPrimerInstalacion],
 (Select Top 1 doei.FechaDesinstalacion From DetalleObrasEquiposInstalados doei Where doei.IdArticulo=#Auxiliar1.IdArticulo Order by doei.FechaInstalacion Desc) as [FechaDesinstalacion],
 Ob.FechaInicio as [FechaContrato],
 Ob.FechaEntrega as [FechaInstalacion1],
 Ob.FechaFinalizacion as [FechaReinstalacion],
 Articulos.Serie as [CausaReinstalacion],
 Articulos.Observaciones as [Observaciones equipo],
 Art.Observaciones as [Observaciones dominio],
 Ob.Observaciones as [Observaciones1],
 Ob.Observaciones2 as [Observaciones2],
 Ob.Observaciones3 as [Observaciones3],
 Ob.Activa as [ObraActiva],
 Art.Codigo as [Dominio],
 Marcas.Descripcion as [Marca],
 Modelos.Descripcion as [Modelo],
 Colores.Descripcion as [Color],
 Art.Direccion as [Tecnico],
 Art.Caracteristicas as [Lugar de instalacion],
 Relaciones.Descripcion as [Servicio],
 Art.DocumentoAlta as [Vendedor],
 Vendedores.Nombre as [Vendedor1],
 Art.Unidad1 as [DesengancheTrailer],
 Art.Unidad2 as [PuertaCabina],
 Art.Unidad3 as [PuertaFurgon],
 Art.Unidad4 as [Electrovalvula],
 Art.Unidad5 as [ReguladorVoltaje],
 Art.CondicionActual as [Estado],
 Art.AuxiliarString10 as [Plataforma],
 (Select Top 1 #Auxiliar10.Precio1 
	From #Auxiliar10 
	Where #Auxiliar10.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar10.Precio1,0)<>0
	Order By #Auxiliar10.FechaOrdenCompra Desc) as [Abono1],
 (Select Top 1 #Auxiliar11.Precio1 
	From #Auxiliar11 
	Where #Auxiliar11.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar11.Precio1,0)<>0
	Order By #Auxiliar11.FechaOrdenCompra Desc) as [Seguro1],
 (Select Top 1 #Auxiliar12.Precio1 
	From #Auxiliar12 
	Where #Auxiliar12.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar12.Precio1,0)<>0
	Order By #Auxiliar12.FechaOrdenCompra Desc) as [Gastos1],
 (Select Top 1 #Auxiliar13.Precio1 
	From #Auxiliar13 
	Where #Auxiliar13.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar13.Precio1,0)<>0
	Order By #Auxiliar13.FechaOrdenCompra Desc) as [VoiceAccess1],
 (Select Top 1 #Auxiliar14.Precio1 
	From #Auxiliar14 
	Where #Auxiliar14.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar14.Precio1,0)<>0
	Order By #Auxiliar14.FechaOrdenCompra Desc) as [Geolocalizador1],
 (Select Top 1 #Auxiliar10.Precio2 
	From #Auxiliar10 
	Where #Auxiliar10.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar10.Precio2,0)<>0
	Order By #Auxiliar10.FechaOrdenCompra Desc) as [Abono2],
 (Select Top 1 #Auxiliar11.Precio2 
	From #Auxiliar11 
	Where #Auxiliar11.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar11.Precio2,0)<>0
	Order By #Auxiliar11.FechaOrdenCompra Desc) as [Seguro2],
 (Select Top 1 #Auxiliar12.Precio2 
	From #Auxiliar12 
	Where #Auxiliar12.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar12.Precio2,0)<>0
	Order By #Auxiliar12.FechaOrdenCompra Desc) as [Gastos2],
 (Select Top 1 #Auxiliar13.Precio2 
	From #Auxiliar13 
	Where #Auxiliar13.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar13.Precio2,0)<>0
	Order By #Auxiliar13.FechaOrdenCompra Desc) as [VoiceAccess2],
 (Select Top 1 #Auxiliar14.Precio2 
	From #Auxiliar14 
	Where #Auxiliar14.IdArticuloAsociado=#Auxiliar1.IdArticuloDominio and IsNull(#Auxiliar14.Precio2,0)<>0
	Order By #Auxiliar14.FechaOrdenCompra Desc) as [Geolocalizador2]
FROM Articulos
LEFT OUTER JOIN Grados ON Articulos.IdGrado=Grados.IdGrado
LEFT OUTER JOIN #Auxiliar1 ON Articulos.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Articulos Art ON #Auxiliar1.IdArticuloDominio=Art.IdArticulo
LEFT OUTER JOIN Obras Ob ON #Auxiliar1.IdObra=Ob.IdObra
LEFT OUTER JOIN Clientes ON Ob.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Marcas ON Art.IdMarca=Marcas.IdMarca
LEFT OUTER JOIN Modelos ON Art.IdModelo=Modelos.IdModelo
LEFT OUTER JOIN Colores ON Art.IdColor=Colores.IdColor
LEFT OUTER JOIN Relaciones ON Art.IdRelacion=Relaciones.IdRelacion
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=Clientes.Vendedor1
WHERE IsNull(Articulos.IdTipo,0)=@IdTipoEquipo
ORDER BY Clientes.RazonSocial, Ob.FechaEntrega

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14