﻿





























CREATE Procedure [dbo].[AutorizacionesPorComprobante_E]
@IdAutorizacionPorComprobante int 
AS 
Delete AutorizacionesPorComprobante
where (IdAutorizacionPorComprobante=@IdAutorizacionPorComprobante)






























