CREATE Procedure [dbo].[Parametros_RegistrarParametros2]

@Campo varchar(50),
@Valor varchar(500)

AS 

IF EXISTS(Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo=@Campo)
	UPDATE Parametros2 SET Valor=@Valor WHERE Campo=@Campo
ELSE
	INSERT INTO Parametros2 (Campo,Valor) VALUES (@Campo,@Valor)
