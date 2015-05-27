
CREATE Procedure [dbo].[DetSubcontratosDatosPedidos_A]

@IdDetalleSubcontratoDatosPedido int  output,
@IdSubcontratoDatos int,
@IdPedido int,
@ArchivoAdjunto1 varchar(100)

AS 

INSERT INTO [DetalleSubcontratosDatosPedidos]
(
 IdSubcontratoDatos,
 IdPedido,
 ArchivoAdjunto1
)
VALUES 
(
 @IdSubcontratoDatos,
 @IdPedido,
 @ArchivoAdjunto1
)

SELECT @IdDetalleSubcontratoDatosPedido=@@identity

DECLARE @NumeroSubcontrato int
SET @NumeroSubcontrato=IsNull((Select Top 1 NumeroSubcontrato From SubcontratosDatos Where IdSubcontratoDatos=@IdSubcontratoDatos),0)
UPDATE Pedidos
SET NumeroSubcontrato=@NumeroSubcontrato, ArchivoAdjunto1=@ArchivoAdjunto1
WHERE IdPedido=@IdPedido

RETURN(@IdDetalleSubcontratoDatosPedido)
