
CREATE Procedure [dbo].[wRequerimientos_E]

@IdRequerimiento int  

AS 

DELETE Requerimientos
WHERE (IdRequerimiento=@IdRequerimiento)

