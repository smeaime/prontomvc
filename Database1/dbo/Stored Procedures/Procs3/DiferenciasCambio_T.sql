﻿
































CREATE Procedure [dbo].[DiferenciasCambio_T]
@IdDiferenciaCambio int
AS 
SELECT *
FROM DiferenciasCambio
WHERE (IdDiferenciaCambio=@IdDiferenciaCambio)
































