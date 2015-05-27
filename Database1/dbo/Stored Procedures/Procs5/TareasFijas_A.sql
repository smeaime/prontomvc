





























CREATE Procedure [dbo].[TareasFijas_A]
@IdTareaFija int  output,
@IdEmpleado int,
@FechaInicial datetime,
@FechaFinal datetime,
@IdItemProduccion int,
@HoraInicial numeric(12,2),
@HorasJornada numeric(12,2),
@IdObra int,
@IdEquipo int,
@IdTarea int,
@LunesAViernes varchar(2),
@Sabados varchar(2),
@HorasJornada1 numeric(12,2),
@Domingos varchar(2),
@HorasJornada2 numeric(12,2)
AS 
Insert into [TareasFijas]
(
 IdEmpleado,
 FechaInicial,
 FechaFinal,
 IdItemProduccion,
 HoraInicial,
 HorasJornada,
 IdObra,
 IdEquipo,
 IdTarea,
 LunesAViernes,
 Sabados,
 HorasJornada1,
 Domingos,
 HorasJornada2
)
Values
(
 @IdEmpleado,
 @FechaInicial,
 @FechaFinal,
 @IdItemProduccion,
 @HoraInicial,
 @HorasJornada,
 @IdObra,
 @IdEquipo,
 @IdTarea,
 @LunesAViernes,
 @Sabados,
 @HorasJornada1,
 @Domingos,
 @HorasJornada2
)
Select @IdTareaFija=@@identity
Return(@IdTareaFija)






























