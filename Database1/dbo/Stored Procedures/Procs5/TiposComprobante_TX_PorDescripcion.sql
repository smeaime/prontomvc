CREATE Procedure [dbo].[TiposComprobante_TX_PorDescripcion]

@Descripcion varchar(50)

AS 

SELECT TOP 1 *
FROM TiposComprobante
WHERE (Upper(Descripcion)=Upper(@Descripcion))