
CREATE Procedure [dbo].[UnidadesEmpaque_TXFecha]

@Desde datetime,
@Hasta datetime

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111133'
SET @vector_T='025E3122215444400'

SELECT 
 UnidadesEmpaque.IdUnidadEmpaque,
 UnidadesEmpaque.NumeroUnidad as [Numero],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 UnidadesEmpaque.Partida as [Partida],
 Unidades.Descripcion as [Empaque],
 UnidadesEmpaque.PesoBruto as [Peso bruto],
 UnidadesEmpaque.Tara as [Tara],
 UnidadesEmpaque.PesoNeto as [Peso neto],
 Empleados.Nombre as [Usuario ingreso],
 UnidadesEmpaque.FechaAlta as [Fecha ingreso],
 UnidadesEmpaque.Metros as [Metros],
 Case When IsNull(UnidadesEmpaque.TipoRollo,'')='C' Then 'CRUDA' When IsNull(UnidadesEmpaque.TipoRollo,'')='T' Then 'TERMINADA' Else '' End as [Tipo rollo],
 UnidadesEmpaque.PartidasOrigen as [Partidas origen],
 UnidadesEmpaque.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM UnidadesEmpaque
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=UnidadesEmpaque.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=UnidadesEmpaque.IdUnidad
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=UnidadesEmpaque.IdUsuarioAlta
WHERE UnidadesEmpaque.FechaAlta between @Desde and @hasta 
ORDER BY UnidadesEmpaque.NumeroUnidad
