


CREATE Procedure [dbo].[RecepcionesSAT_T]
@IdRecepcion int
AS 
SELECT * 
FROM RecepcionesSAT
WHERE (IdRecepcion=@IdRecepcion)


