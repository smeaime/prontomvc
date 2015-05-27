





























CREATE Procedure [dbo].[ViasPago_TL]
AS 
SELECT 
IdViaPago,
Codigo+' - '+Descripcion as [Titulo]
FROM ViasPago
ORDER by Codigo,Descripcion






























