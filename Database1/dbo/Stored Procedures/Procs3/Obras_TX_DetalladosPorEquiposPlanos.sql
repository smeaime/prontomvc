































CREATE PROCEDURE [dbo].[Obras_TX_DetalladosPorEquiposPlanos]
AS 
declare @vector_X varchar(30),@vector_T varchar(30),@Fechas Datetime,@str1 varchar(60),@str2 varchar(40),@str3 varchar(30),@str4 varchar(50),@Entero int
set @vector_X='001111111133'
set @vector_T='003444211000'
SELECT
IdObra,
@Entero as [IdEquipo],
NumeroObra as [Nro. obra],
FechaInicio as [Fecha inicio],
FechaFinalizacion as [Fecha fin.],
FechaEntrega as [Fecha entr.],
substring(@str1,1,40) as [Equipo],
substring(@str2,1,20) as [Tag],
@str3 as [Nro.plano],
@str4 as [Plano],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Obras
UNION ALL
SELECT
IdObra,
IdEquipo,
Null,
Null,
Null,
Null,
substring(Descripcion,1,40) as [Equipo],
substring(Tag,1,20) as [Tag],
Null,
Null,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Equipos
UNION ALL
SELECT
Equipos.IdObra,
Equipos.IdEquipo,
Null,
Null,
Null,
Null,
Null,
Null,
Planos.NumeroPlano as [Nro.plano],
Planos.Descripcion as [Plano],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleEquipos DetEqu
INNER JOIN Equipos ON DetEqu.IdEquipo=Equipos.IdEquipo
INNER JOIN Planos ON DetEqu.IdPlano=Planos.IdPlano
ORDER BY IdObra,IdEquipo
































