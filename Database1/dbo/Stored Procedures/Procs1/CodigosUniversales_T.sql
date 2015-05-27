





























CREATE Procedure [dbo].[CodigosUniversales_T]
@IdCodigoUniversal smallint
AS 
SELECT *
FROM CodigosUniversales
where (IdCodigoUniversal=@IdCodigoUniversal)






























