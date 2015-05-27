





























CREATE Procedure [dbo].[Planos_TT]
AS 
Select 
IdPlano,
NumeroPlano as [Numero de plano],
Descripcion,
Revision
FROM Planos
ORDER By Descripcion






























