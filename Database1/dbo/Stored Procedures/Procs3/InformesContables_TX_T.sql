﻿

































CREATE  Procedure [dbo].[InformesContables_TX_T]
@IdInforme int
AS 
SELECT *
FROM Informes
where IdInforme=@IdInforme


































