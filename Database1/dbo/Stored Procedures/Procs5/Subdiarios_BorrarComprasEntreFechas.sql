



























CREATE PROCEDURE [dbo].[Subdiarios_BorrarComprasEntreFechas]
@Desde datetime,
@Hasta datetime
AS
DELETE FROM Subdiarios
WHERE Subdiarios.FechaComprobante between @Desde and DATEADD(n,1439,@hasta) and 
	Subdiarios.IdCuentaSubdiario=(Select Top 1 Parametros.IdCuentaCompras From Parametros
					Where Parametros.IdParametro=1)




























