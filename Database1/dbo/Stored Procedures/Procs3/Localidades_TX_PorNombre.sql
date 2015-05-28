CREATE Procedure [dbo].[Localidades_TX_PorNombre]

@Nombre varchar(50),
@IdProvincia int,
@IdLocalidad int

AS 

SELECT *
FROM Localidades
WHERE (@IdLocalidad<=0 or IdLocalidad<>@IdLocalidad) And Nombre=@Nombre And IdProvincia=@IdProvincia