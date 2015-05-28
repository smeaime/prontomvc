




CREATE PROCEDURE [dbo].[OrdenesPago_TXOrdenesPagoxAnio]
@Anio int
AS
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111111111111133'
set @vector_T='05555555555555555555500'
SELECT 
 op.IdOrdenPago, 
 op.NumeroOrdenPago as [Numero], 
 op.FechaOrdenPago as [Fecha Pago], 
 Proveedores.RazonSocial as [Proveedor],
 Cuentas.Descripcion as [Cuenta],
 op.Efectivo,
 op.Descuentos,
 op.Valores,
 op.Documentos,
 op.Otros1 as [Otros 1],
 (Select Cuentas.Descripcion 
	From Cuentas 
	Where op.IdCuenta1=Cuentas.IdCuenta) as [Cuenta 1],
 op.Otros2 as [Otros 2],
 (Select Cuentas.Descripcion 
	From Cuentas 
	Where op.IdCuenta2=Cuentas.IdCuenta) as [Cuenta 2],
 op.Otros3 as [Otros 3],
 (Select Cuentas.Descripcion 
	From Cuentas 
	Where op.IdCuenta3=Cuentas.IdCuenta) as [Cuenta 3],
 op.Acreedores,
 op.RetencionIVA as [Ret.IVA],
 op.RetencionGanancias as [Ret.gan.],
 op.RetencionIBrutos as [Ret.ing.b.],
 op.RetencionSUSS as [Ret.SUSS],
 op.GastosGenerales as [Gs.grales.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
WHERE YEAR(op.FechaOrdenPago)=@anio and 
	(op.Confirmado is null or op.Confirmado<>'NO')
ORDER BY op.FechaOrdenPago,op.NumeroOrdenPago




