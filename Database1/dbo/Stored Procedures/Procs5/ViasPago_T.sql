





























CREATE Procedure [dbo].[ViasPago_T]
@IdViaPago int
AS 
SELECT *
FROM ViasPago
WHERE (IdViaPago=@IdViaPago)






























