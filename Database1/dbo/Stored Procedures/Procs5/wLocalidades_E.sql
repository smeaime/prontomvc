
CREATE Procedure [dbo].[wLocalidades_E]

@IdLocalidad int  

AS 

DELETE Localidades
WHERE (IdLocalidad=@IdLocalidad)

