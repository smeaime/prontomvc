































CREATE Procedure [dbo].[Acopios_A]
@IdAcopio int  output,
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
AS 
Insert into Acopios
(
 NumeroAcopio,
 IdObra,
 IdCliente,
 Fecha,
 Realizo,
 Aprobo,
 Nombre,
 Observaciones,
 IdAutorizacion1,
 FechaAutorizacion1,
 IdAutorizacion2,
 FechaAutorizacion2,
 IdAutorizacion3,
 FechaAutorizacion3,
 MontoPrevisto,
 FechaAprobacion,
 Estado,
 UsuarioAnulacion,
 FechaAnulacion,
 MotivoAnulacion,
 IdComprador,
 IdAutorizoCumplido,
 IdDioPorCumplido,
 FechaDadoPorCumplido,
 ObservacionesCumplido,
 EnviarEmail,
 IdAcopioOriginal,
 IdOrigenTransmision
)
Values
(
 @NumeroAcopio,
 @IdObra,
 @IdCliente,
 @Fecha,
 @Realizo,
 @Aprobo,
 @Nombre,
 @Observaciones,
 @IdAutorizacion1,
 @FechaAutorizacion1,
 @IdAutorizacion2,
 @FechaAutorizacion2,
 @IdAutorizacion3,
 @FechaAutorizacion3,
 @MontoPrevisto,
 @FechaAprobacion,
 @Estado,
 @UsuarioAnulacion,
 @FechaAnulacion,
 @MotivoAnulacion,
 @IdComprador,
 @IdAutorizoCumplido,
 @IdDioPorCumplido,
 @FechaDadoPorCumplido,
 @ObservacionesCumplido,
 @EnviarEmail,
 @IdAcopioOriginal,
 @IdOrigenTransmision
)
Select @IdAcopio=@@identity
Return(@IdAcopio)
































