
CREATE Procedure UnidadesEmpaque_TX_NetoPorPartidaConsolidada
@Partida varchar(20)
AS 

SELECT sum(isnull(PesoNeto,0)) as PesoNetoTotal
FROM UnidadesEmpaque
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
WHERE (Partida=@Partida)
	and IsNull(EsDevolucion,'NO')='NO'
