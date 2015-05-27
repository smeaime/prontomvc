CREATE  Procedure [dbo].[Impuestos_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111133'
SET @vector_T='0295E5222225500'

SELECT 
 Impuestos.IdImpuesto,
 TiposComprobante.Descripcion as [Tipo impuesto],
 Impuestos.IdImpuesto as [IdAux],
 Impuestos.Fecha as [Fecha],
 Articulos.Descripcion as [Equipo imputado],
 Articulos.NumeroPatente as [Patente],
 Modelos.Descripcion as [Modelo],
 Impuestos.NumeroTramite as [Nro. tramite],
 Impuestos.CodigoPlan as [Plan],
 Impuestos.Agencia as [Agencia],
 Cuentas.Codigo as [Codigo],
 Cuentas.Descripcion as [Cuenta contable],
 Impuestos.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Impuestos
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
ORDER BY TiposComprobante.Descripcion, Impuestos.NumeroTramite, Impuestos.Fecha