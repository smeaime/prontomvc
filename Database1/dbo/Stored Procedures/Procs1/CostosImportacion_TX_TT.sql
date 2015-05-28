





CREATE Procedure [dbo].[CostosImportacion_TX_TT]

@IdCostoImportacion int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0011111111111111111111133'
Set @vector_T='0041471111115111110101000'

SELECT
 IdCostoImportacion,
 Cs.IdArticulo,
 Articulos.Codigo as [Codigo impor.],
 Articulos.Descripcion as [Articulo],
 FechaCostoImportacion as [Fecha],
 PosicionesImportacion.CodigoPosicion as [Cod.Posicion],
 PosicionesImportacion.Descripcion as [Posicion],
 Case When Cs.PrecioCF=0 Then Null Else Cs.PrecioCF End as [Pr.C&F],
 Case When Cs.PorcGastosDespacho=0 Then Null Else Cs.PorcGastosDespacho End as [% Desp.],
 Case When Cs.TotalGastosDespacho=0 Then Null Else Cs.TotalGastosDespacho End as [Gs.Desp.],
 Case When Cs.PorcTotalGastos=0 Then Null Else Cs.PorcTotalGastos End as [% Gastos],
 Case When Cs.TotalGastos=0 Then Null Else Cs.TotalGastos End as [Gastos],
 Case When Cs.PrecioTotal=0 Then Null Else Cs.PrecioTotal End as [Precio Total ( $ )],
 Case When Cs.Derechos=0 Then Null Else Cs.Derechos End as [% Der.],
 Case When Cs.GastosEstadisticas=0 Then Null Else Cs.GastosEstadisticas End as [% Gs.Est.],
 Case When Cs.OtrosGastos1=0 Then Null Else Cs.OtrosGastos1 End as [% Otros 1],
 Case When Cs.OtrosGastos2=0 Then Null Else Cs.OtrosGastos2 End as [% Otros 2],
 Case When Cs.PrecioFOB=0 Then Null Else Cs.PrecioFOB End as [Pr.Com.],
 Case When Cs.PrecioFOB=0 Then Null 
	Else ( SELECT Monedas.Abreviatura
		FROM Monedas
		WHERE Monedas.IdMoneda=Cs.IdMoneda1) 
 End as  [Mon.],
 Case When Cs.FleteMaritimo=0 Then Null Else Cs.FleteMaritimo End as [Fl.Mar.],
 Case When Cs.FleteMaritimo=0 Then Null 
	Else ( SELECT Monedas.Abreviatura
		FROM Monedas
		WHERE Monedas.IdMoneda=Cs.IdMoneda2) 
 End as  [Mon.],
 Case When Cs.OtrosFletes=0 Then Null Else Cs.OtrosFletes End as [Otr.Fl.],
 Case When Cs.OtrosFletes=0 Then Null 
	Else ( SELECT Monedas.Abreviatura
		FROM Monedas
		WHERE Monedas.IdMoneda=Cs.IdMoneda3) 
 End as  [Mon.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CostosImportacion Cs
LEFT OUTER JOIN Articulos ON Cs.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN PosicionesImportacion ON Cs.IdPosicionImportacion = PosicionesImportacion.IdPosicionImportacion
WHERE (IdCostoImportacion=@IdCostoImportacion)





