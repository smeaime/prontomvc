
CREATE Procedure [dbo].[MovimientosFletes_TX_MovimientoAnteriorCarga]

@IdMovimientoFlete int

AS 

SET NOCOUNT ON

DECLARE @IdFlete int, @Fecha datetime

SET @IdFlete=(Select Top 1 IdFlete From MovimientosFletes Where IdMovimientoFlete=@IdMovimientoFlete)
SET @Fecha=(Select Top 1 Fecha From MovimientosFletes Where IdMovimientoFlete=@IdMovimientoFlete)

SET NOCOUNT OFF

SELECT TOP 2 
 mf.*, 
 LecturasGPS.Latitud as [Latitud],
 LecturasGPS.Longitud as [Longitud],
 LecturasGPS.Altura as [Altura],
 Fletes.Patente as [Patente],
 Convert(varchar,mf.Fecha,108) as [Hora],
 Case When mf.Tipo='C' Then 'Carga' 
	When mf.Tipo='D' Then 'Descarga' 
	When mf.Tipo='V' Then 'Viaje' 
	Else Null 
 End as [Operacion],
 Fletes.NumeroInterno as [Nro.Int.],
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 IsNull(Fletes.PathImagen1,'') as [Imagen]
FROM MovimientosFletes mf
LEFT OUTER JOIN LecturasGPS ON LecturasGPS.IdLecturaGPS=mf.IdLecturaGPS
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=mf.IdFlete
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
WHERE mf.IdFlete=@IdFlete and mf.Fecha<=@Fecha
ORDER BY mf.Fecha Desc
