﻿
































CREATE Procedure [dbo].[Recibos_T]
@IdRecibo int
AS 
SELECT *
FROM Recibos
where (IdRecibo=@IdRecibo)

































