





























CREATE Procedure [dbo].[ArticulosInformacionAdicional_T]
@IdArticuloInformacionAdicional int
AS 
SELECT *
FROM [ArticulosInformacionAdicional]
where (IdArticuloInformacionAdicional=@IdArticuloInformacionAdicional)






























