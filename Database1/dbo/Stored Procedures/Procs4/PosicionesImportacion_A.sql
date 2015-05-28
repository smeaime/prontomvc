








CREATE Procedure [dbo].[PosicionesImportacion_A]
@IdPosicionImportacion int  output,
@CodigoPosicion varchar(15),
@Descripcion varchar(50),
@IdTipoPosicion int,
@Derechos numeric(12,2),
@GastosEstadisticas numeric(12,2),
@OtrosGastos1 numeric(12,2),
@OtrosGastos2 numeric(12,2)
AS 
Insert into [PosicionesImportacion]
(
 Descripcion,
 CodigoPosicion,
 IdTipoPosicion,
 Derechos,
 GastosEstadisticas,
 OtrosGastos1,
 OtrosGastos2
)
Values
(
 @Descripcion,
 @CodigoPosicion,
 @IdTipoPosicion,
 @Derechos,
 @GastosEstadisticas,
 @OtrosGastos1,
 @OtrosGastos2
)
Select @IdPosicionImportacion=@@identity
Return(@IdPosicionImportacion)









