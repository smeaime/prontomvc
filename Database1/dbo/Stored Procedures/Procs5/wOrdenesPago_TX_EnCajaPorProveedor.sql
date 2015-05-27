
CREATE PROCEDURE [dbo].[wOrdenesPago_TX_EnCajaPorProveedor]

@IdProveedor int

AS

declare @Estado varchar(2)
SET @Estado= Null

DECLARE @vector_X varchar(50),@vector_T varchar(50)

SELECT 
 op.IdOrdenPago, 
 op.FechaOrdenPago as [Fecha Pago], 
 op.Documentos,
 op.Acreedores,
 op.RetencionIVA as [RetIVA],
 op.RetencionGanancias as [RetGan],
 op.RetencionIBrutos as [RetIngB],
 op.RetencionSUSS as [RetSUSS],
 op.GastosGenerales as [Dev.F.F.]
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Obras ON op.IdObra = Obras.IdObra
WHERE --op.Estado=@Estado and 
(op.Anulada is null or op.Anulada<>'SI') and  (op.Confirmado is null or op.Confirmado<>'NO')
		and op.IdProveedor=@IdProveedor
ORDER BY op.FechaOrdenPago desc ,op.NumeroOrdenPago desc

