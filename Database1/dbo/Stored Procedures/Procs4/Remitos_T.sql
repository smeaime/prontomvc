﻿

































CREATE Procedure [dbo].[Remitos_T]
@IdRemito int
AS 
SELECT * 
FROM Remitos
WHERE (IdRemito=@IdRemito)


































