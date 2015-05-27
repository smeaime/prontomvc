CREATE Procedure [dbo].[CertificacionesObras_TX_DatosParaCombo]

AS 

SELECT c.NumeroProyecto, Obras.Descripcion + ' [' + Convert(varchar,c.NumeroProyecto)+ '] ' as [Titulo]
FROM CertificacionesObras c
LEFT OUTER JOIN Obras ON Obras.IdObra=c.IdObra
GROUP BY c.NumeroProyecto, Obras.Descripcion
ORDER by c.NumeroProyecto