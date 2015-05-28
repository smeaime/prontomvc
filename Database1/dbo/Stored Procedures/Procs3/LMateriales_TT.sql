CREATE  Procedure [dbo].[LMateriales_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111133'
SET @vector_T='04065F1555555595200'

SELECT 
	LMateriales.IdLMateriales,
	LMateriales.NumeroLMateriales as [L.Materiales],
	Equipos.Tag as [Equipo],
	LMateriales.Nombre as [Nombre lista],
	Planos.Descripcion as [Plano],
	Articulos.Descripcion as [Unidad funcional],
	Clientes.RazonSocial as [Cliente], 
	Obras.NumeroObra as [Nro. obra],
	Obras.FechaInicio as [Fecha.inicio],
	LMateriales.Fecha as [Fecha lista], 
	E1.Nombre as [Emitido por],
	E2.Nombre as [Liberado por],
	ArchivosATransmitirDestinos.Descripcion as [Origen],
	(Select Count(*) From DetalleLMateriales Where DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales) as [Cant.Items],
	LMateriales.IdLMateriales as [IdAux],
	LMateriales.Embalo as [Embalo], 
	Planos.NumeroPlano as [Nro. de plano],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM LMateriales
LEFT OUTER JOIN Clientes ON LMateriales.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Obras ON LMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Planos ON LMateriales.IdPlano = Planos.IdPlano
LEFT OUTER JOIN ArchivosATransmitirDestinos ON LMateriales.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = LMateriales.IdUnidadFuncional
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = LMateriales.Realizo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = LMateriales.Aprobo
ORDER BY LMateriales.NumeroLMateriales