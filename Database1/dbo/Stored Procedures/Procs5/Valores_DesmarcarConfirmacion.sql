
CREATE Procedure [dbo].[Valores_DesmarcarConfirmacion]
@IdValor int
AS 
UPDATE Valores
SET 	MovimientoConfirmadoBanco=Null,
	FechaConfirmacionBanco=Null,
	IdUsuarioConfirmacionBanco=Null
WHERE (IdValor=@IdValor)
