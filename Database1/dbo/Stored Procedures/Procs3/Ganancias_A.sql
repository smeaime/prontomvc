




























CREATE Procedure [dbo].[Ganancias_A]

@IdGanancia int  output,
@Desde numeric(12,2),
@Hasta numeric(12,2),
@SumaFija numeric(12,2),
@PorcentajeAdicional numeric(6,2),
@IdTipoRetencionGanancia int,
@MinimoNoImponible numeric(18,2),
@MinimoARetener numeric(18,2)

As 
Insert into [Ganancias]
(
 Desde,
 Hasta,
 SumaFija,
 PorcentajeAdicional,
 IdTipoRetencionGanancia,
 MinimoNoImponible,
 MinimoARetener
)
Values
(
 @Desde,
 @Hasta,
 @SumaFija,
 @PorcentajeAdicional,
 @IdTipoRetencionGanancia,
 @MinimoNoImponible,
 @MinimoARetener
)
Select @IdGanancia=@@identity

Return(@IdGanancia)




























