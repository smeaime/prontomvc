CREATE Procedure [dbo].[Facturas_ActualizarDatosCAE]

@IdFactura int,
@CAE varchar(14) = Null,
@RechazoCAE varchar(8) = Null,
@FechaVencimientoORechazoCAE datetime = Null

AS

UPDATE Facturas
SET 
 CAE=@CAE,
 RechazoCAE=@RechazoCAE,
 FechaVencimientoORechazoCAE=@FechaVencimientoORechazoCAE
WHERE (IdFactura=@IdFactura)

RETURN(@IdFactura)
