
CREATE Procedure [dbo].[DetSubcontratosDatosPedidos_M]

@IdDetalleSubcontratoDatosPedido int,
@IdSubcontratoDatos int,
@IdPedido int,
@ArchivoAdjunto1 varchar(100)

AS

UPDATE [DetalleSubcontratosDatosPedidos]
SET 
 IdSubcontratoDatos=@IdSubcontratoDatos,
 IdPedido=@IdPedido,
 ArchivoAdjunto1=@ArchivoAdjunto1
WHERE (IdDetalleSubcontratoDatosPedido=@IdDetalleSubcontratoDatosPedido)

DECLARE @NumeroSubcontrato int
SET @NumeroSubcontrato=IsNull((Select Top 1 NumeroSubcontrato From SubcontratosDatos Where IdSubcontratoDatos=@IdSubcontratoDatos),0)
UPDATE Pedidos
SET NumeroSubcontrato=@NumeroSubcontrato, ArchivoAdjunto1=@ArchivoAdjunto1
WHERE IdPedido=@IdPedido

RETURN(@IdDetalleSubcontratoDatosPedido)
