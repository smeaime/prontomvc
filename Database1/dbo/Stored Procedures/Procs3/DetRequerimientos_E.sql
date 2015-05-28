



CREATE Procedure [dbo].[DetRequerimientos_E]
@IdDetalleRequerimiento int  
AS 
DELETE [DetalleRequerimientos]
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)



