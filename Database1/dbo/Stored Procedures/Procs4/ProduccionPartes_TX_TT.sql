CREATE Procedure ProduccionPartes_TX_TT
@IdProduccionParte int

AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='011111111011111133'
Set @vector_T='01113111105E911100'

SELECT 
ProduccionPartes.idProduccionParte,
ProduccionPartes.idProduccionParte AS [Parte],
Empleados.Nombre as Empleado,
CASE 
	WHEN not ProduccionPartes.Anulada is null THEN 'ANULADO'
	WHEN ProduccionPartes.IdUsuarioCerro is null 
		AND dbo.fproduccionordenestado(produccionordenes.IdProduccionOrden)<>'ANULADA' 
		AND dbo.fproduccionordenestado(produccionordenes.IdProduccionOrden)<>'CERRADA' 
		THEN 'ABIERTO'
	ELSE 'CERRADO'
END as Estado,
FechaDia as [Fecha],
ltrim(str(datepart(hh,FechaInicio))) + ':' +right('00'+ltrim(str(datepart(mi,FechaInicio))),2)     as [Inicio],
ltrim(str(datepart(hh,FechaFinal))) + ':'  +right('00'+ltrim(str( datepart(mi,FechaFinal) ) ),2)   as [Final],
ProduccionOrdenes.NumeroOrdenProduccion as [OP],
ProduccionProcesos.Descripcion,
isnull(Horas,0) as [Hs Prev.] , 
isnull(HorasReales,0) as [Hs Reales] ,
Articulos.Descripcion as [Artículo],
Partida,
ProduccionPartes.Cantidad,
Unidades.descripcion as [Uni.],
Maquinas.Descripcion as [Maquina],

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionPartes 
LEFT OUTER JOIN ProduccionOrdenes ON  ProduccionPartes.IdProduccionOrden = ProduccionOrdenes.IdProduccionOrden
LEFT OUTER JOIN ProduccionProcesos ON  ProduccionPartes.IdProduccionProceso = ProduccionProcesos.IdProduccionProceso
LEFT OUTER JOIN Empleados ON  ProduccionPartes.IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN Unidades ON ProduccionPartes.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Articulos ON ProduccionPartes.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Articulos Maquinas ON ProduccionPartes.IdMaquina = Maquinas.IdArticulo
WHERE (IdProduccionParte=@IdProduccionParte)
ORDER BY ProduccionPartes.idProduccionParte

