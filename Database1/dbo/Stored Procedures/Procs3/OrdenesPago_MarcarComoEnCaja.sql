
CREATE Procedure [dbo].[OrdenesPago_MarcarComoEnCaja]

@IdOrdenPago int,
@Estado varchar(2) = Null

AS 

SET @Estado=IsNull(@Estado,'CA')

UPDATE OrdenesPago
SET Estado=@Estado
WHERE IdOrdenPago=@IdOrdenPago
