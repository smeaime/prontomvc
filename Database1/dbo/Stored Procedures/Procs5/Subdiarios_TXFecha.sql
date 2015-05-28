






























CREATE PROCEDURE [dbo].[Subdiarios_TXFecha]
@Desde datetime,
@Hasta datetime
AS
SELECT 
 Min(Subdiarios.IdSubdiario) as [Id],
 Titulos.Titulo as [Subdiario],
 Sum(Subdiarios.Debe) as [Total debe],
 Sum(Subdiarios.Haber) as [Total haber],
 Sum(Subdiarios.Debe) - Sum(Subdiarios.Haber) as [Diferencia]
FROM Subdiarios
LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
WHERE Subdiarios.FechaComprobante between @Desde and @hasta
GROUP BY Titulos.Titulo






























