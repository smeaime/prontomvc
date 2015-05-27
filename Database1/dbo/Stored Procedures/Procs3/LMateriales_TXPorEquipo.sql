





























CREATE  Procedure [dbo].[LMateriales_TXPorEquipo]
@IdEquipo int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111111133'
set @vector_T='04025215555555900'
SELECT 
	LMateriales.IdLMateriales,
	LMateriales.NumeroLMateriales as [L.Materiales],
	Equipos.Tag as [Equipo],
	LMateriales.Nombre as [Nombre lista],
	Planos.Descripcion as [Plano],
	Planos.NumeroPlano as [Nro. de plano],
	Clientes.RazonSocial as [Cliente], 
	Obras.NumeroObra as [Nro. obra],
	Obras.FechaInicio as [Fecha.inicio],
	LMateriales.Fecha as [Fecha lista], 
	(Select Top 1 Empleados.Nombre
	 from Empleados
	 Where Empleados.IdEmpleado=LMateriales.Realizo) as [Emitido por],
	(Select Top 1 Empleados.Nombre
	 from Empleados
	 Where Empleados.IdEmpleado=LMateriales.Aprobo) as [Liberado por],
	ArchivosATransmitirDestinos.Descripcion as [Origen],
	(Select Count(*) From DetalleLMateriales 
	 Where DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales) as [Cant.Items],
	LMateriales.IdLMateriales,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM LMateriales
LEFT OUTER JOIN Clientes ON LMateriales.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Obras ON LMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Planos ON LMateriales.IdPlano = Planos.IdPlano
LEFT OUTER JOIN ArchivosATransmitirDestinos ON LMateriales.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
WHERE (LMateriales.IdEquipo=@IdEquipo)
ORDER BY LMateriales.NumeroLMateriales






























