﻿

































CREATE Procedure [dbo].[OrdenesPago_T]
@IdOrdenPago int
AS 
SELECT *
FROM OrdenesPago
WHERE (IdOrdenPago=@IdOrdenPago)


































