﻿
































CREATE Procedure [dbo].[Bancos_T]
@IdBanco int
AS 
SELECT *
FROM Bancos
where (IdBanco=@IdBanco)

































