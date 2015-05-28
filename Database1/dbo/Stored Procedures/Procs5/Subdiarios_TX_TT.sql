






























CREATE PROCEDURE [dbo].[Subdiarios_TX_TT]
@Mes int,
@Anio int,
@IdSubdiario int
AS
SELECT 
 min(Subdiarios.IdSubdiario) AS Id,
 Titulos.Titulo as [Subdiario],
 Year(FechaComprobante) as [Año],
 Month(FechaComprobante) as [Mes],
 Sum(Subdiarios.Debe) as [Total debe],
 Sum(Subdiarios.Haber) as [Total haber],
 Sum(Subdiarios.Debe) - Sum(Subdiarios.Haber) as [Diferencia]
FROM Subdiarios
LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
WHERE MONTH(Subdiarios.FechaComprobante)=@Mes and YEAR(Subdiarios.FechaComprobante)=@Anio and 
	Subdiarios.IdSubdiario=@IdSubdiario
GROUP BY Titulos.Titulo,Year(FechaComprobante),Month(FechaComprobante)






























