﻿





























CREATE Procedure [dbo].[DetEmpleados_E]
@IdDetalleEmpleado int  
AS 
Delete [DetalleEmpleados]
where (IdDetalleEmpleado=@IdDetalleEmpleado)






























