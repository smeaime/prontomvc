CREATE Procedure [dbo].[PuntosVenta_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111133'
SET @vector_T='015263555282200'

SELECT 
 PuntosVenta.IdPuntoVenta,
 PuntosVenta.Letra,
 PuntosVenta.PuntoVenta as [Punto de venta],
 TiposComprobante.Descripcion as [Comprobante],
 PuntosVenta.ProximoNumero as [Proximo Numero],
 PuntosVenta.Descripcion as [Descripcion],
 PuntosVenta.WebService as [Fact.Electronica],
 PuntosVenta.WebServiceModoTest as [Fact.Elect. (modo test)],
 PuntosVenta.CAEManual as [Ing.manual CAE],
 IsNull(PuntosVenta.Activo,'SI') as [Activo],
 PuntosVenta.AgentePercepcionIIBB as [Es agente de percep.IIBB?],
 PuntosVenta.CodigoAuxiliar as [Cod.Aux.],
 Depositos.Descripcion as [Dep.asoc.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PuntosVenta
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=PuntosVenta.IdTipoComprobante
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito=PuntosVenta.IdDeposito
ORDER by TiposComprobante.Descripcion, PuntosVenta.Letra, PuntosVenta.PuntoVenta