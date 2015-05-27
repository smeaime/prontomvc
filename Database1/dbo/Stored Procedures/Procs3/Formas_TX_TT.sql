





























CREATE Procedure [dbo].[Formas_TX_TT]
@IdForma smallint
AS 
Select 
IdForma,
Descripcion,
Abreviatura
FROM Formas
where (IdForma=@IdForma)
order by Descripcion






























