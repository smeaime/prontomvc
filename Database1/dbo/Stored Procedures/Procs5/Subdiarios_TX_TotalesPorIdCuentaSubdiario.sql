



CREATE PROCEDURE [dbo].[Subdiarios_TX_TotalesPorIdCuentaSubdiario]
@Mes int,
@Anio int,
@IdCuentaSubdiario int
AS
SELECT 
 SUM(Subdiarios.Debe) as [Debe],
 SUM(Subdiarios.Haber) as [Haber]
FROM Subdiarios
WHERE MONTH(Subdiarios.FechaComprobante)=@Mes and YEAR(Subdiarios.FechaComprobante)=@Anio and 
	Subdiarios.IdCuentaSubdiario=@IdCuentaSubdiario



