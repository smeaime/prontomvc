﻿































CREATE Procedure [dbo].[Acopios_BorrarAutorizaciones]
@IdFormulario int,
@IdComprobante int
AS 
Delete AutorizacionesPorComprobante
where IdFormulario=@IdFormulario and IdComprobante=@IdComprobante
































