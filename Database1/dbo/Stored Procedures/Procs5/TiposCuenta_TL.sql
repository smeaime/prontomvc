
CREATE Procedure [dbo].[TiposCuenta_TL]
AS 
SELECT IdTipoCuenta, Descripcion as [Titulo]
FROM TiposCuenta
ORDER BY Descripcion
