
CREATE Procedure [dbo].[wFondosFijos_T]

@IdFondoFijo int = Null,
@IdUsuarioIngreso int = Null,
@NivelDetalles varchar(10) = Null

AS 

SET NOCOUNT ON

SET @IdFondoFijo=IsNull(@IdFondoFijo,-1)
SET @IdUsuarioIngreso=IsNull(@IdUsuarioIngreso,-1)
SET @NivelDetalles=IsNull(@NivelDetalles,'Detallado')

IF @NivelDetalles='Resumen'
    BEGIN
	DECLARE @rowcount int
	SELECT @rowcount=IsNull((SELECT Count(*) 
					FROM FondosFijos 
					WHERE (@IdFondoFijo=-1 or FondosFijos.IdFondoFijo=@IdFondoFijo) and 
						(@IdUsuarioIngreso=-1 or FondosFijos.IdUsuarioIngreso=@IdUsuarioIngreso)),0)
	SET NOCOUNT OFF
	RETURN @rowcount
    END

SET NOCOUNT OFF

SELECT 
 FondosFijos.*,
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 E1.Nombre as [UsuarioIngreso],
 Proveedores.RazonSocial as [Proveedor],
 TiposComprobante.Descripcion as [TipoComprobante],
 Cuentas.Codigo as [CodigoCuenta],
 Cuentas.Descripcion as [Cuenta],
 DescripcionIva.Descripcion as [CondicionIva]
FROM FondosFijos
LEFT OUTER JOIN Obras ON FondosFijos.IdObra=Obras.IdObra
LEFT OUTER JOIN Proveedores ON FondosFijos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Empleados E1 ON FondosFijos.IdUsuarioIngreso=E1.IdEmpleado
LEFT OUTER JOIN TiposComprobante ON FondosFijos.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Cuentas ON FondosFijos.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN DescripcionIva ON FondosFijos.IdCodigoIva = DescripcionIva.IdCodigoIva
WHERE (@IdFondoFijo=-1 or FondosFijos.IdFondoFijo=@IdFondoFijo) and 
	(@IdUsuarioIngreso=-1 or FondosFijos.IdUsuarioIngreso=@IdUsuarioIngreso) 
ORDER BY FondosFijos.FechaComprobante Desc

