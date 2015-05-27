




























CREATE  Procedure [dbo].[Ganancias_M]

@IdGanancia int,
@Desde numeric(12,2),
@Hasta numeric(12,2),
@SumaFija numeric(12,2),
@PorcentajeAdicional numeric(6,2),
@IdTipoRetencionGanancia int,
@MinimoNoImponible numeric(18,2),
@MinimoARetener numeric(18,2)

As

Update Ganancias
Set
 Desde=@Desde,
 Hasta=@Hasta,
 SumaFija=@SumaFija,
 PorcentajeAdicional=@PorcentajeAdicional,
 IdTipoRetencionGanancia=@IdTipoRetencionGanancia,
 MinimoNoImponible=@MinimoNoImponible,
 MinimoARetener=@MinimoARetener
Where (IdGanancia=@IdGanancia)

Return(@IdGanancia)




























