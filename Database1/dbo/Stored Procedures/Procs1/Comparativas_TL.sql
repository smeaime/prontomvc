CREATE Procedure [dbo].[Comparativas_TL]

AS 

SELECT Comparativas.Numero, Convert(varchar,Comparativas.Numero) + ' del ' + Convert(varchar,Comparativas.Fecha,103) as [Titulo]
FROM Comparativas 
WHERE Comparativas.PresupuestoSeleccionado is not null and IsNull(Comparativas.Anulada,'')<>'SI' and 
	(IsNull(Comparativas.CircuitoFirmasCompleto,'')='SI' or  Not Exists(Select Top 1 * From DetalleAutorizaciones da Left Outer Join Autorizaciones On Autorizaciones.IdAutorizacion=da.IdAutorizacion Where Autorizaciones.IdFormulario=5))
ORDER BY Comparativas.Numero DESC