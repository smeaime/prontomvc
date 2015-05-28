




CREATE PROCEDURE [dbo].[Obras_TX_EstadoObrasPorObra]
@IdObra int

AS 

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='0111111111111111111111111411133'
set @vector_T='0920142430114224420112221934500'

SELECT
 IdTemp,
 Id,
 Obra,
 Equipo,
 CentroCosto as [Centro de costo],
 Comprobante,
 Numero,
 Fecha,
 Null as [Nombre de LA],
 Item,
 Emisor,
 Sector,
 FechaNecesidad as [Fecha nec.],
 CantidadItems as [Tot.items],
 Cumplido,
 FechaUltimaFirma as [Fecha ult.firma],
 Articulo,
 Cantidad,
 substring(UnidadEn,1,25) as [Unidad en],
 Cantidad1 as [Med.1],
 Cantidad2 as [Med.2],
 CantidadPedida as [Cant.Ped.],
 CantidadRecibida as [Cant.Rec.],
 CASE 	WHEN CantidadFacturasAsignadas=0 THEN Null
	ELSE CantidadFacturasAsignadas
 END as [Cant.Fac.],
 CuentaContable as [Cuenta contable],
 Observaciones,
 ProveedorAsignado as [Proveedor asignado],
 CompradoPor as [Comprado por],
 FechaLlamadoAProveedor as [Fecha llamado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM _TempEstadoDeObras
WHERE IdObra=@IdObra
ORDER By Equipo,Articulo




