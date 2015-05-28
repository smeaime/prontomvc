

CREATE PROCEDURE ProduccionOrdenes_TX_DetalleProcesosDeFicha
@IdProduccionFicha int
as

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='11110011111133'
Set @vector_T='9D110011119E00'


SELECT 
null,
 '    ' as [*],
null as [Inicio],
null as [Final],
 Det.IdProduccionProceso,
 null,
 ProduccionProcesos.Descripcion,
 Det.Horas,
null as [Avance],
 ' ' as [%],
null as IdMaquina,
 null as Maquina,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionFichaProcesos Det
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
where IdProduccionFicha=@IdProduccionFicha

