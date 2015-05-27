
CREATE Procedure [dbo].[wRequerimientos_N]

@IdRequerimiento int  

AS 

UPDATE Requerimientos SET Cumplido = 'AN'  WHERE IdRequerimiento = @IdRequerimiento
UPDATE DetalleRequerimientos SET Cumplido = 'AN'  WHERE IdRequerimiento = @IdRequerimiento

