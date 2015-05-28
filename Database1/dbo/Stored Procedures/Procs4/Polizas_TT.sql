CREATE  Procedure [dbo].[Polizas_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111133'
SET @vector_T='059555555555555555500'

SELECT 
 Polizas.IdPoliza,
 Polizas.Tipo as [Tipo],
 Polizas.IdPoliza as [IdAux],
 Proveedores.RazonSocial as [Aseguradora],
 Polizas.Numero as [Numero],
 Polizas.FechaVigencia as [Fecha vigencia],
 Polizas.FechaFinalizacionCobertura as [Fecha finalizacion cobertura],
 Polizas.FechaVencimientoPrimerCuota as [Fecha vto. 1qr. cuota],
 Polizas.NumeroEndoso as [Endoso],
 Polizas.CantidadCuotas as [Cuotas],
 Polizas.ImporteAsegurado as [Importe asegurado],
 Polizas.ImportePrima as [Importe prima],
 Polizas.ImportePremio as [Importe premio],
 Monedas.Abreviatura as [Mon.],
 Polizas.MotivoContratacion as [Motivo contratacion],
 Polizas.Observaciones as [Observaciones],
 Case When Polizas.TipoFacturacion=1 Then 'Mensual' When Polizas.TipoFacturacion=2 Then 'Trimestral' When Polizas.TipoFacturacion=3 Then 'Semestral' When Polizas.TipoFacturacion=4 Then 'Anual' End as [Tipo facturacion],
 Polizas.Certificado as [Certificado],
 TiposPoliza.Descripcion as [Tipo de poliza],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Polizas
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Polizas.IdProveedor
LEFT OUTER JOIN TiposPoliza ON TiposPoliza.IdTipoPoliza = Polizas.IdTipoPoliza
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Polizas.IdMoneda
ORDER BY Polizas.FechaVigencia, Polizas.Numero