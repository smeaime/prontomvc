


CREATE PROCEDURE [dbo].[OrdenesCompra_MarcarParaFacturacionAutomatica]

@IdOrdenCompra int,
@Marca varchar(2)

AS 

UPDATE OrdenesCompra
SET SeleccionadaParaFacturacion=Case When @Marca='SI' Then @Marca Else Null End
WHERE IdOrdenCompra=@IdOrdenCompra


