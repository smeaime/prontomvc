































CREATE Procedure [dbo].[Acopios_M]
@IdAcopio int,
@NumeroAcopio int,
@IdObra int,
@IdCliente int,
@Fecha datetime,
@Realizo int,
@Aprobo int,
@Nombre varchar(30),
@Observaciones ntext,
@IdAutorizacion1 int,
@FechaAutorizacion1 datetime,
@IdAutorizacion2 int,
@FechaAutorizacion2 datetime,
@IdAutorizacion3 int,
@FechaAutorizacion3 datetime,
@MontoPrevisto numeric(12,2),
@FechaAprobacion datetime,
@Estado varchar(2),
@UsuarioAnulacion varchar(6),
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@IdComprador int,
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@EnviarEmail tinyint,
@IdAcopioOriginal int,
@IdOrigenTransmision int
As
Update Acopios
SET 
 NumeroAcopio=@NumeroAcopio,
 IdObra=@IdObra,
 IdCliente=@IdCliente,
 Fecha=@Fecha,
 Realizo=@Realizo,
 Aprobo=@Aprobo,
 Nombre=@Nombre,
 Observaciones=@Observaciones,
 IdAutorizacion1=@IdAutorizacion1,
 FechaAutorizacion1=@FechaAutorizacion1,
 IdAutorizacion2=@IdAutorizacion2,
 FechaAutorizacion2=@FechaAutorizacion2,
 IdAutorizacion3=@IdAutorizacion3,
 FechaAutorizacion3=@FechaAutorizacion3,
 MontoPrevisto=@MontoPrevisto,
 FechaAprobacion=@FechaAprobacion,
 Estado=@Estado,
 UsuarioAnulacion=@UsuarioAnulacion,
 FechaAnulacion=@FechaAnulacion,
 MotivoAnulacion=@MotivoAnulacion,
 IdComprador=@IdComprador,
 IdAutorizoCumplido=@IdAutorizoCumplido,
 IdDioPorCumplido=@IdDioPorCumplido,
 FechaDadoPorCumplido=@FechaDadoPorCumplido,
 ObservacionesCumplido=@ObservacionesCumplido,
 EnviarEmail=@EnviarEmail,
 IdAcopioOriginal=@IdAcopioOriginal,
 IdOrigenTransmision=@IdOrigenTransmision
Where (IdAcopio=@IdAcopio)
Return(@IdAcopio)
































