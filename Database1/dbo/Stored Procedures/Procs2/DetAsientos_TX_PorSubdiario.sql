






























CREATE Procedure [dbo].[DetAsientos_TX_PorSubdiario]
@IdAsiento int,
@IdCuenta int
AS 
SELECT TOP 1 *
FROM DetalleAsientos
where 	IdAsiento=@IdAsiento and IdCuenta=@IdCuenta































