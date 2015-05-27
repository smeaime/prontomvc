





























CREATE Procedure [dbo].[DescripcionIva_T]
@IdCodigoIva tinyint 
AS 
Select *
FROM DescripcionIva
where (IdCodigoIva=@IdCodigoIva)






























