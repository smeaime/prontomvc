





























CREATE Procedure [dbo].[SiNo_TX_TT]
@IdSiNo tinyint
AS 
Select IdSiNo,SiNo
FROM SiNo
where (IdSiNo=@IdSiNo)






























