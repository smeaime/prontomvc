





























CREATE Procedure [dbo].[Equipos_A]
@IdEquipo smallint  output,
@Descripcion varchar(60),
@Tag varchar(40),
@IdObra int,
@HorasEstimadas int,
@FechaTerminacion datetime,
@IdGrupoTareaHH int,
@IdItemDocumentacion1 int,
@ItemDocumentacion1 datetime,
@IdItemDocumentacion2 int,
@ItemDocumentacion2 datetime,
@IdItemDocumentacion3 int,
@ItemDocumentacion3 datetime,
@IdItemDocumentacion4 int,
@ItemDocumentacion4 datetime,
@IdItemDocumentacion5 int,
@ItemDocumentacion5 datetime,
@IdItemDocumentacion6 int,
@ItemDocumentacion6 datetime,
@EnviarEmail tinyint,
@ActivoHH varchar(2)
AS 
Insert into [Equipos]
(
Descripcion,
Tag,
IdObra,
HorasEstimadas,
FechaTerminacion,
IdGrupoTareaHH,
IdItemDocumentacion1,
ItemDocumentacion1,
IdItemDocumentacion2,
ItemDocumentacion2,
IdItemDocumentacion3,
ItemDocumentacion3,
IdItemDocumentacion4,
ItemDocumentacion4,
IdItemDocumentacion5,
ItemDocumentacion5,
IdItemDocumentacion6,
ItemDocumentacion6,
EnviarEmail,
ActivoHH
)
Values
(
@Descripcion,
@Tag,
@IdObra,
@HorasEstimadas,
@FechaTerminacion,
@IdGrupoTareaHH,
@IdItemDocumentacion1,
@ItemDocumentacion1,
@IdItemDocumentacion2,
@ItemDocumentacion2,
@IdItemDocumentacion3,
@ItemDocumentacion3,
@IdItemDocumentacion4,
@ItemDocumentacion4,
@IdItemDocumentacion5,
@ItemDocumentacion5,
@IdItemDocumentacion6,
@ItemDocumentacion6,
@EnviarEmail,
@ActivoHH
)
Select @IdEquipo=@@identity
Return(@IdEquipo)






























