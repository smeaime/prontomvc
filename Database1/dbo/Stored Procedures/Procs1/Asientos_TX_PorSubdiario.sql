


































CREATE Procedure [dbo].[Asientos_TX_PorSubdiario]
@IdCuentaSubdiario int,
@Fecha datetime
AS 
SELECT *
FROM Asientos
where 	IdCuentaSubdiario=@IdCuentaSubdiario and 
	month(FechaAsiento)=month(@Fecha) and
	year(FechaAsiento)=year(@Fecha)



































