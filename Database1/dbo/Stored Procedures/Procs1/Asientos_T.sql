﻿


































CREATE Procedure [dbo].[Asientos_T]
@IdAsiento int
AS 
SELECT *
FROM Asientos
where (IdAsiento=@IdAsiento)


































