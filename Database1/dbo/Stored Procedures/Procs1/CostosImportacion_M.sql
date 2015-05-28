





CREATE  Procedure [dbo].[CostosImportacion_M]

@IdCostoImportacion int,
@IdArticulo int,
@IdProveedor int,
@PosicionNCE varchar(15),
@IdPosicionImportacion int,
@Derechos numeric(12,2),
@GastosEstadisticas numeric(12,2),
@OtrosGastos1 numeric(12,2),
@OtrosGastos2 numeric(12,2),
@FechaCostoImportacion datetime,
@Observaciones ntext,
@PrecioFOB numeric(12,2),
@IdMoneda1 int,
@Conversion1 numeric(12,2),
@FleteMaritimo numeric(12,2),
@IdMoneda2 int,
@Conversion2 numeric(12,2),
@OtrosFletes numeric(12,2),
@IdMoneda3 int,
@Conversion3 numeric(12,2),
@PrecioCF numeric(12,2),
@PorcGastosDespacho numeric(12,2),
@TotalGastosDespacho numeric(12,2),
@PorcTotalGastos numeric(12,2),
@TotalGastos numeric(12,2),
@PrecioTotal numeric(12,2)
AS
UPDATE CostosImportacion
SET 
 IdArticulo=@IdArticulo,
 IdProveedor=@IdProveedor,
 PosicionNCE=@PosicionNCE,
 IdPosicionImportacion=@IdPosicionImportacion,
 Derechos=@Derechos,
 GastosEstadisticas=@GastosEstadisticas,
 OtrosGastos1=@OtrosGastos1,
 OtrosGastos2=@OtrosGastos2,
 FechaCostoImportacion=@FechaCostoImportacion,
 Observaciones=@Observaciones,
 PrecioFOB=@PrecioFOB,
 IdMoneda1=@IdMoneda1,
 Conversion1=@Conversion1,
 FleteMaritimo=@FleteMaritimo,
 IdMoneda2=@IdMoneda2,
 Conversion2=@Conversion2,
 OtrosFletes=@OtrosFletes,
 IdMoneda3=@IdMoneda3,
 Conversion3=@Conversion3,
 PrecioCF=@PrecioCF,
 PorcGastosDespacho=@PorcGastosDespacho,
 TotalGastosDespacho=@TotalGastosDespacho,
 PorcTotalGastos=@PorcTotalGastos,
 TotalGastos=@TotalGastos,
 PrecioTotal=@PrecioTotal
WHERE (IdCostoImportacion=@IdCostoImportacion)
RETURN(@IdCostoImportacion)





