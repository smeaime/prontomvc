





























CREATE Procedure [dbo].[CodigosUniversales_TX_TT]
@IdCodigoUniversal smallint
AS 
Select 
IdCodigoUniversal,
Descripcion,
Abreviatura
FROM CodigosUniversales
where (IdCodigoUniversal=@IdCodigoUniversal)
order by Descripcion






























