CREATE Procedure [dbo].[NotasDebito_ActualizarDatosCAE]

@IdNotaDebito int,
@CAE varchar(14) = Null,
@RechazoCAE varchar(8) = Null,
@FechaVencimientoORechazoCAE datetime = Null

AS

UPDATE NotasDebito
SET 
 CAE=@CAE,
 RechazoCAE=@RechazoCAE,
 FechaVencimientoORechazoCAE=@FechaVencimientoORechazoCAE
WHERE (IdNotaDebito=@IdNotaDebito)

RETURN(@IdNotaDebito)
