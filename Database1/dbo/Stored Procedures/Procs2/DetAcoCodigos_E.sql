﻿





























CREATE Procedure [dbo].[DetAcoCodigos_E]
@IdDetalleAcoCodigo int  AS 
Delete DetalleAcoCodigos
where (IdDetalleAcoCodigo=@IdDetalleAcoCodigo)






























