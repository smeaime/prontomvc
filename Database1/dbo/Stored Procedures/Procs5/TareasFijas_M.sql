





























CREATE  Procedure [dbo].[TareasFijas_M]
@IdTareaFija int,
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
Update TareasFijas
SET
IdEmpleado=@IdEmpleado,
FechaInicial=@FechaInicial,
FechaFinal=@FechaFinal,
IdItemProduccion=@IdItemProduccion,
HoraInicial=@HoraInicial,
HorasJornada=@HorasJornada,
IdObra=@IdObra,
IdEquipo=@IdEquipo,
IdTarea=@IdTarea,
LunesAViernes=@LunesAViernes,
Sabados=@Sabados,
HorasJornada1=@HorasJornada1,
Domingos=@Domingos,
HorasJornada2=@HorasJornada2
Where (IdTareaFija=@IdTareaFija)
Return(@IdTareaFija)






























