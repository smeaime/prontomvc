CREATE Procedure [dbo].[NotasCredito_ActualizarDatosCAE]

@IdNotaCredito int,
@CAE varchar(14) = Null,
@RechazoCAE varchar(8) = Null,
@FechaVencimientoORechazoCAE datetime = Null

AS

UPDATE NotasCredito
SET 
 CAE=@CAE,
 RechazoCAE=@RechazoCAE,
 FechaVencimientoORechazoCAE=@FechaVencimientoORechazoCAE
WHERE (IdNotaCredito=@IdNotaCredito)

RETURN(@IdNotaCredito)
