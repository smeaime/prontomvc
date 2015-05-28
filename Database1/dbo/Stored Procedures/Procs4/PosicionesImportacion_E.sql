








CREATE Procedure [dbo].[PosicionesImportacion_E]
@IdPosicionImportacion int
AS 
Delete PosicionesImportacion
where (IdPosicionImportacion=@IdPosicionImportacion)








