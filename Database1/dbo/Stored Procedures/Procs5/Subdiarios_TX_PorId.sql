﻿
































CREATE PROCEDURE [dbo].[Subdiarios_TX_PorId]
@IdSubdiario int
AS
SELECT *
FROM Subdiarios
WHERE IdSubdiario=@IdSubdiario

































