CREATE Procedure [dbo].[Fletes_ActualizarDatosRecepcionesYSalidas]

@IdOrigenTransmision int

AS

UPDATE Recepciones
SET IdFlete=(Select Top 1 Fletes.IdFlete From Fletes Where Fletes.Patente COLLATE Modern_Spanish_CI_AS=Recepciones.Patente)
WHERE IdOrigenTransmision=@IdOrigenTransmision and IdFlete is null

UPDATE SalidasMateriales
SET IdFlete=(Select Top 1 Fletes.IdFlete From Fletes Where Fletes.Patente=SalidasMateriales.Patente1 COLLATE Modern_Spanish_CI_AS)
WHERE IdOrigenTransmision=@IdOrigenTransmision and IdFlete is null

UPDATE DetalleFletes
SET IdFlete=IsNull((Select Top 1 Fletes.IdFlete From Fletes Where Fletes.Patente=DetalleFletes.Patente COLLATE Modern_Spanish_CI_AS),0)
WHERE IsNull(IdFlete,0)=0