﻿





























CREATE Procedure [dbo].[DetAcoAcabados_E]
@IdDetalleAcoAcabado int  AS 
Delete DetalleAcoAcabados
where (IdDetalleAcoAcabado=@IdDetalleAcoAcabado)






























