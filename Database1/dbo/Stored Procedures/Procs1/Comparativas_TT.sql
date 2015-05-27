CREATE  Procedure [dbo].[Comparativas_TT]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 IdComparativa INTEGER,
			 IdPresupuesto INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT DISTINCT IdComparativa, IdPresupuesto
 FROM DetalleComparativas

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111661111111133'
SET @vector_T='027700443223525B00'

SELECT 
 Cmp.IdComparativa,
 Cmp.Numero,
 Cmp.Fecha as [Fecha Comparativa],
 Case When IsNull(Cmp.PresupuestoSeleccionado,0)<>-1 Then 'Monopresupuesto' Else 'Multipresupuesto' End as [Tipo seleccion],
 E1.Nombre as [Confecciono],
 E2.Nombre as [Aprobo],
 Cmp.MontoPrevisto as [Monto previsto],
 Cmp.MontoParaCompra as [Monto p/cpra],
 (Select Count(*) From #Auxiliar0 Where #Auxiliar0.IdComparativa=Cmp.IdComparativa) as [Cant.Sol.],
 Cmp.ArchivoAdjunto1 as [Archivo adjunto 1],
 Cmp.ArchivoAdjunto2 as [Archivo adjunto 2],
 Cmp.Anulada as [Anulada],
 Cmp.FechaAnulacion as [Fecha anulacion],
 E3.Nombre as [Anulo],
 Cmp.MotivoAnulacion as [Motivo anulacion],
 'Firmas: '+dbo.Autorizaciones_CantidadFirmas(5,0)+' = '+dbo.Autorizaciones_Firmas(5,Cmp.IdComparativa) as [Firmas],
 @Vector_T as [Vector_T],
 @Vector_X as [Vector_X]
FROM Comparativas Cmp
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Cmp.IdConfecciono
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Cmp.IdAprobo
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado=Cmp.IdUsuarioAnulo
ORDER BY Cmp.Fecha Desc, Cmp.Numero Desc

DROP TABLE #Auxiliar0