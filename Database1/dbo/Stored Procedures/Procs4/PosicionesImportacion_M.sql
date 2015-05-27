








CREATE  Procedure [dbo].[PosicionesImportacion_M]
 @IdPosicionImportacion int,
 @CodigoPosicion varchar(50),
 @Descripcion varchar(50),
 @IdTipoPosicion int,
 @Derechos numeric(12,2),
 @GastosEstadisticas numeric(12,2),
 @OtrosGastos1 numeric(12,2),
 @OtrosGastos2 numeric(12,2)
AS
Update PosicionesImportacion
SET 
 CodigoPosicion=@CodigoPosicion,
 Descripcion=@Descripcion,
 IdTipoPosicion=@IdTipoPosicion,
 Derechos=@Derechos,
 GastosEstadisticas=@GastosEstadisticas,
 OtrosGastos1=@OtrosGastos1,
 OtrosGastos2=@OtrosGastos2
where (IdPosicionImportacion=@IdPosicionImportacion)
Return(@IdPosicionImportacion)









