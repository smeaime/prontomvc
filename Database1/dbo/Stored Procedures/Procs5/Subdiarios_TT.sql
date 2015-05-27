



CREATE PROCEDURE [dbo].[Subdiarios_TT]

AS

SELECT 
 min(Subdiarios.IdSubdiario) as Id,
 Titulos.Titulo as [Subdiario],
 Year(FechaComprobante) as [Año],
 Month(FechaComprobante) as [Mes],
 Sum(Subdiarios.Debe) as [Total debe],
 Sum(Subdiarios.Haber) as [Total haber],
 Sum(Subdiarios.Debe) - Sum(Subdiarios.Haber) as [Diferencia]
FROM Subdiarios
LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
GROUP BY  Titulos.Titulo,Year(FechaComprobante),Month(FechaComprobante)



