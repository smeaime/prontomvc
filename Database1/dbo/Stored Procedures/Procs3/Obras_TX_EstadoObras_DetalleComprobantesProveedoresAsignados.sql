
CREATE Procedure [dbo].[Obras_TX_EstadoObras_DetalleComprobantesProveedoresAsignados]

@IdDetalleRequerimiento int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdDetalleRecepcion INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleRecepcion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT IdDetalleRecepcion
 FROM DetalleRecepciones
 WHERE IsNull(IdDetalleRequerimiento,0)>0 and (@IdDetalleRequerimiento=-1 or IdDetalleRequerimiento=@IdDetalleRequerimiento)

CREATE TABLE #Auxiliar2 (IdDetallePedido INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetallePedido) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT IdDetallePedido
 FROM DetallePedidos
 WHERE IsNull(IdDetalleRequerimiento,0)>0 and (@IdDetalleRequerimiento=-1 or IdDetalleRequerimiento=@IdDetalleRequerimiento)

CREATE TABLE #Auxiliar (
			 IdDetalleComprobante INTEGER,
			 TipoComprobante VARCHAR(10),
			 IdComprobante INTEGER,
			 NumeroReferencia INTEGER,
			 NumeroComprobante VARCHAR(20),
			 Item INTEGER,
			 Proveedor VARCHAR(50),
			 FechaComprobante DATETIME,
			 TotalBruto NUMERIC(18,2),
			 Moneda VARCHAR(15)
			)
INSERT INTO #Auxiliar 
 SELECT DISTINCT 
  DetCom.IdDetalleComprobanteProveedor,
  TiposComprobante.DescripcionAb,
  cp.IdComprobanteProveedor,
  cp.NumeroReferencia,
  cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
  Null,
  Proveedores.RazonSocial,
  cp.FechaComprobante,
  DetCom.Importe * TiposComprobante.Coeficiente,
  Monedas.Abreviatura
 FROM DetalleComprobantesProveedores DetCom
 LEFT OUTER JOIN ComprobantesProveedores cp ON DetCom.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
 LEFT OUTER JOIN #Auxiliar1 ON DetCom.IdDetalleRecepcion = #Auxiliar1.IdDetalleRecepcion
 LEFT OUTER JOIN #Auxiliar2 ON DetCom.IdDetallePedido = #Auxiliar2.IdDetallePedido
 WHERE #Auxiliar1.IdDetalleRecepcion is not null or #Auxiliar2.IdDetallePedido is not null

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111116133'
SET @vector_T='059350245000'

SELECT
 #Auxiliar.IdDetalleComprobante,
 #Auxiliar.TipoComprobante as [Tipo comp.],
 #Auxiliar.IdComprobante as [IdAux ], 
 #Auxiliar.NumeroReferencia as [Nro.interno],
 #Auxiliar.NumeroComprobante as [Numero],
 #Auxiliar.Item as [Item],
 #Auxiliar.Proveedor as [Proveedor], 
 #Auxiliar.FechaComprobante as [Fecha comp.], 
 #Auxiliar.TotalBruto as [Importe s/iva],
 #Auxiliar.Moneda as [Mon.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
ORDER BY #Auxiliar.FechaComprobante, #Auxiliar.NumeroComprobante

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
