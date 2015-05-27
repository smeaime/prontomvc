
CREATE Procedure [dbo].[Valores_MarcarComoConfirmado]
@IdValor int,
@IdUsuario int,
@FechaConfirmacionBanco datetime
AS 
UPDATE Valores
SET 	MovimientoConfirmadoBanco='SI',
	FechaConfirmacionBanco=@FechaConfirmacionBanco,
	IdUsuarioConfirmacionBanco=@IdUsuario
WHERE (IdValor=@IdValor)
