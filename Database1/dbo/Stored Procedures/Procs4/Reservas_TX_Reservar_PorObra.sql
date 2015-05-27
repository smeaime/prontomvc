





























CREATE  Procedure [dbo].[Reservas_TX_Reservar_PorObra]
@IdObra int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111111111111111111133'
set @vector_T='021103111122220849999900'
SELECT
IdComprobante,
Tipo as [Comp.],
Numero,
Nombre,
Item,
Obra,
Equipo,
Articulo,
Cantidad as [Cant.],
Unidad as [En],
Stock,
Reservado,
Case 	When Stock is not null and Reservado is not null Then 
		Case 	When Stock>=Reservado Then Stock-Reservado
			Else Null
		End
	When Stock is null and Reservado is not null Then Null
	Else Stock
End as [Disponible],
Reserva,
Genero as [Generado por],
Observaciones,
FechaNecesidad as [Fec.nec.],
IdAcopio,
IdRequerimiento,
IdObra,
IdArticulo,
IdUnidad,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM _TempReservasStock
WHERE IdObra=@IdObra
ORDER By Articulo,Tipo,Numero,Item






























