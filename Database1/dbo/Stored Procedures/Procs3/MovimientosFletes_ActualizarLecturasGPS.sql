
CREATE Procedure [dbo].[MovimientosFletes_ActualizarLecturasGPS]

@IdMovimientoFlete int,
@IdLecturaGPS int,
@DistanciaRecorridaKm numeric(18,8),
@IdPatronGPS int 

AS 

DECLARE @IdFlete int, @IdTarifaFlete int, @ModalidadFacturacion tinyint, @ValorUnitario numeric(18,2)

SET @IdFlete=IsNull((Select Top 1 IdFlete From MovimientosFletes Where IdMovimientoFlete=@IdMovimientoFlete),0)
SET @IdTarifaFlete=IsNull((Select Top 1 IdTarifaFlete From Fletes Where IdFlete=@IdFlete),0)
SET @ModalidadFacturacion=IsNull((Select Top 1 ModalidadFacturacion From Fletes Where IdFlete=@IdFlete),0)
SET @ValorUnitario=IsNull((Select Top 1 ValorUnitario From TarifasFletes Where IdTarifaFlete=@IdTarifaFlete),0)

UPDATE MovimientosFletes
SET IdLecturaGPS=@IdLecturaGPS, IdPatronGPS=@IdPatronGPS, FechaUltimaModificacionManual=Null, 
	ModalidadFacturacion=@ModalidadFacturacion, ValorUnitario=@ValorUnitario, 
	DistanciaRecorridaKm=	Case When @DistanciaRecorridaKm>0 Then @DistanciaRecorridaKm 
					When @DistanciaRecorridaKm=0 Then Null
					Else DistanciaRecorridaKm 
				End
WHERE IdMovimientoFlete=@IdMovimientoFlete
