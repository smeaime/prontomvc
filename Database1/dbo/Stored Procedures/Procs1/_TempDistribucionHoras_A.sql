
CREATE Procedure [dbo].[_TempDistribucionHoras_A]

@Legajo int,
@Obra varchar(13),
@Porcentaje numeric(18,4),
@IdEmpleado int,
@IdObra int

AS 

INSERT INTO [_TempDistribucionHoras]
(
 Legajo,
 Obra,
 Porcentaje,
 IdEmpleado,
 IdObra
)
VALUES
(
 @Legajo,
 @Obra,
 @Porcentaje,
 @IdEmpleado,
 @IdObra
)

RETURN(1)
