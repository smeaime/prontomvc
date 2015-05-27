





























CREATE Procedure [dbo].[Planos_TX_TT]
@IdPlano int 
AS 
Select 
IdPlano,
NumeroPlano as [Numero de plano],
Descripcion,
Revision
FROM Planos
WHERE (IdPlano=@IdPlano)






























