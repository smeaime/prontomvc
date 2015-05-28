CREATE Procedure [dbo].[ArchivosATransmitirDestinos_TT]

AS 

SELECT 
 ArchivosATransmitirDestinos.IdArchivoATransmitirDestino,
 ArchivosATransmitirDestinos.Descripcion as [Destino SAT],
 CASE 	WHEN ArchivosATransmitirDestinos.Tipo=1 THEN 'Obra' ELSE 'Tercerizado' END as [Tipo de destino],
 Obras.NumeroObra as [Obra],
 ArchivosATransmitirDestinos.Email,
 ArchivosATransmitirDestinos.Activo as [Activo ?],
 ArchivosATransmitirDestinos.Nombre,
 ArchivosATransmitirDestinos.Direccion,
 ArchivosATransmitirDestinos.Localidad,
 ArchivosATransmitirDestinos.Telefono,
 ArchivosATransmitirDestinos.Celular,
 ArchivosATransmitirDestinos.Horario,
 ArchivosATransmitirDestinos.Contacto,
 ArchivosATransmitirDestinos.IdArchivoATransmitirDestino as [Identificador],
 Case When IsNull(ArchivosATransmitirDestinos.Sistema,'SAT')='SAT' Then 'PRONTO SAT' 
	When IsNull(ArchivosATransmitirDestinos.Sistema,'SAT')='MANTENIMIENTO' Then 'PRONTO MANTENIMIENTO' 
	When IsNull(ArchivosATransmitirDestinos.Sistema,'SAT')='BALANZA' Then 'PRONTO BALANZA' 
	When IsNull(ArchivosATransmitirDestinos.Sistema,'SAT')='LOCALES' Then 'PRONTO LOCALES' 
	Else 'S/D' 
 End as [Sistema]
FROM ArchivosATransmitirDestinos
LEFT OUTER JOIN Obras ON ArchivosATransmitirDestinos.IdObra=Obras.IdObra
ORDER by ArchivosATransmitirDestinos.Descripcion