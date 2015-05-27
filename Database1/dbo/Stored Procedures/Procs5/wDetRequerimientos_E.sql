
CREATE Procedure [dbo].[wDetRequerimientos_E]

@IdDetalleRequerimiento int  

AS 

DELETE [DetalleRequerimientos]
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)

