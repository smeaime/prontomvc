CREATE  Procedure [dbo].[Impuestos_TX_ParaImputar]

@IdTipoComprobante int = Null,
@Estado varchar(1) = Null,
@IdCuenta int = Null

AS 

SET @IdTipoComprobante=IsNull(@IdTipoComprobante,-1)
SET @Estado=IsNull(@Estado,'A')
SET @IdCuenta=IsNull(@IdCuenta,0)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111111133'
SET @vector_T='0F9994E5215555555500'

SELECT
 DetalleImpuestos.IdDetalleImpuesto,
 TiposComprobante.Descripcion as [Tipo impuesto],
 DetalleImpuestos.IdDetalleImpuesto as [IdAux1],
 dopi.IdDetalleOrdenPagoImpuestos as [IdAux2],
 Impuestos.IdTipoComprobante as [IdAux3],
 Impuestos.Fecha as [Fecha],
 Articulos.Descripcion as [Equipo imputado],
 Articulos.NumeroPatente as [Patente],
 DetalleImpuestos.Año as [Año],
 DetalleImpuestos.Cuota as [Cuota],
 DetalleImpuestos.Importe as [Importe],
 DetalleImpuestos.FechaVencimiento1 as [Fecha Vto.1],
 DetalleImpuestos.FechaVencimiento2 as [Fecha Vto.2],
 DetalleImpuestos.FechaVencimiento3 as [Fecha Vto.3],
 OrdenesPago.NumeroOrdenPago as [Numero OP], 
 OrdenesPago.FechaOrdenPago as [Fecha OP], 
 Cuentas.Codigo as [Codigo],
 Cuentas.Descripcion as [Cuenta contable],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleImpuestos
LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = DetalleImpuestos.IdImpuesto
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
LEFT OUTER JOIN DetalleOrdenesPagoImpuestos dopi ON dopi.IdDetalleImpuesto = DetalleImpuestos.IdDetalleImpuesto
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = dopi.IdOrdenPago
WHERE (@IdTipoComprobante<=0 or Impuestos.IdTipoComprobante=@IdTipoComprobante) and 
	(@Estado='*' or (@Estado='A' and dopi.IdDetalleImpuesto is null) or (@Estado='I' and dopi.IdDetalleImpuesto is not null)) and 
	(@IdCuenta<=0 or Impuestos.IdCuenta=@IdCuenta)
ORDER BY Articulos.NumeroPatente, TiposComprobante.Descripcion, DetalleImpuestos.Año, DetalleImpuestos.Cuota