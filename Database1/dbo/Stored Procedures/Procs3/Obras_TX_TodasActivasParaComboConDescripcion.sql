CREATE Procedure [dbo].[Obras_TX_TodasActivasParaComboConDescripcion]

@ControlarFechas varchar(2) = Null,
@Fecha datetime = Null

AS 

SELECT 
 IdObra,
 Descripcion+' ['+NumeroObra+']' as Titulo
FROM Obras
WHERE IsNull(Obras.Activa,'SI')='SI' and 
	(IsNull(@ControlarFechas,'NO')<>'SI' or 
	 (IsNull(@ControlarFechas,'NO')='SI' and IsNull(Obras.FechaEntrega,@Fecha)>=@Fecha and 
	  IsNull(Obras.FechaInicio,@Fecha)<=@Fecha))
ORDER BY Descripcion,NumeroObra