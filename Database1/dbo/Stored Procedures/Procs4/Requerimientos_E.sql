



CREATE Procedure [dbo].[Requerimientos_E]
@IdRequerimiento int  
AS 
DELETE Requerimientos
WHERE (IdRequerimiento=@IdRequerimiento)



