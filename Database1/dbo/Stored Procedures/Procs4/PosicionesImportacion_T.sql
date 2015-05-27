








CREATE Procedure [dbo].[PosicionesImportacion_T]
@IdPosicionImportacion int
AS 
SELECT *
FROM PosicionesImportacion
where (IdPosicionImportacion=@IdPosicionImportacion)








