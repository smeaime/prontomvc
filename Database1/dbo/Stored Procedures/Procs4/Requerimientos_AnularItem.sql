CREATE Procedure [dbo].[Requerimientos_AnularItem]

@IdDetalleRequerimiento int  

AS 

UPDATE DetalleRequerimientos
SET Cumplido='AN', EnviarEmail=1
WHERE IdDetalleRequerimiento=@IdDetalleRequerimiento