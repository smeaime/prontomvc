































CREATE Procedure [dbo].[Acopios_TX_SinControl]
@IdAcopio int
AS 
Select
DetAco.IdDetalleAcopios
From DetalleAcopios DetAco
Where DetAco.IdAcopio=@IdAcopio and DetAco.IdControlCalidad is null
































