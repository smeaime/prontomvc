





























CREATE Procedure [dbo].[DetLMaterialesRevisiones_T]
@IdDetalleLMaterialesRevisiones int
AS 
SELECT *
FROM DetalleLMaterialesRevisiones
where (IdDetalleLMaterialesRevisiones=@IdDetalleLMaterialesRevisiones)






























