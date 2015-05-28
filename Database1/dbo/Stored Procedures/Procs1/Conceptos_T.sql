





























CREATE Procedure [dbo].[Conceptos_T]
@IdConcepto int  
AS 
SELECT * 
FROM Conceptos
where (IdConcepto=@IdConcepto)






























