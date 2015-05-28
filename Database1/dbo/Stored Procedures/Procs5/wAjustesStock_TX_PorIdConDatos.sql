CREATE  Procedure [dbo].[wAjustesStock_TX_PorIdConDatos]

@IdAjusteStock int

AS 

SELECT 
 AjustesStock.*,
 Case When AjustesStock.TipoAjuste='I' Then 'Inventario' Else 'Ajuste normal' End as [TipoAjuste1],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 E1.Nombre as [Realizo],
 E2.Nombre as [Libero],
 E3.Nombre as [Ingreso],
 E4.Nombre as [Modifico]
FROM AjustesStock
LEFT OUTER JOIN ArchivosATransmitirDestinos ON AjustesStock.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Empleados E1 ON AjustesStock.IdRealizo = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON AjustesStock.IdAprobo = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON AjustesStock.IdUsuarioIngreso = E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON AjustesStock.IdUsuarioModifico = E4.IdEmpleado
WHERE (IdAjusteStock=@IdAjusteStock)