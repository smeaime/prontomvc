CREATE  Procedure [dbo].[Valores_TX_GastosEntreFechas]

@FechaDesde datetime,
@FechaHasta datetime,
@Todos int, 
@Estado varchar(1) = Null

AS

SET @Estado=IsNull(@Estado,'G')

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111111133'
SET @vector_T='039434022121340245040400'

SELECT 
 Valores.IdValor,
 TiposComprobante.DescripcionAb as [Tipo Comp.], Valores.IdValor as [IdVal],
 Case When @Estado='G' Then Bancos.Nombre Else TarjetasCredito.Nombre COLLATE Modern_Spanish_CI_AS End as [Banco],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Monedas.Abreviatura as [Mon.],
 Valores.Iva as [Iva],
 Valores.Importe * TiposComprobante.Coeficiente as [Importe],
 Valores.CotizacionMoneda as [Conv.a $],
 Valores.Importe * TiposComprobante.Coeficiente * Isnull(Valores.CotizacionMoneda,1) as [Importe $],
 IsNull(Valores.Conciliado,'NO') as [Conc.],
 IsNull(Valores.MovimientoConfirmadoBanco,'NO') as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.Numero as [Nro.Extracto],
 Conciliaciones.FechaIngreso as [Fec.Extracto],
 Valores.Detalle as [Detalle],
 e1.Nombre as [Confecciono],
 Valores.FechaIngreso as [Fecha ing.],
 e2.Nombre as [Modifico],
 Valores.FechaModifico as [Fecha modif.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON CuentasBancarias.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TarjetasCredito ON Valores.IdTarjetaCredito=TarjetasCredito.IdTarjetaCredito
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Empleados e1 ON e1.IdEmpleado=Valores.IdUsuarioIngreso
LEFT OUTER JOIN Empleados e2 ON e2.IdEmpleado=Valores.IdUsuarioModifico
WHERE Valores.Estado=@Estado and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(@Todos=-1 or (Valores.FechaComprobante between @FechaDesde and @FechaHasta))
ORDER BY Bancos.Nombre, TarjetasCredito.Nombre, Valores.FechaComprobante, Valores.NumeroComprobante
