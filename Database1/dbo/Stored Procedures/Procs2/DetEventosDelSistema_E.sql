﻿





























CREATE Procedure [dbo].[DetEventosDelSistema_E]
@IdDetalleEventoDelSistema int  
AS 
Delete [DetalleEventosDelSistema]
where (IdDetalleEventoDelSistema=@IdDetalleEventoDelSistema)






























