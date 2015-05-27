





























CREATE Procedure [dbo].[ViasPago_TX_TT]
@IdViaPago int
AS 
SELECT *
FROM ViasPago
WHERE (IdViaPago=@IdViaPago)






























