





CREATE Procedure [dbo].[CostosImportacion_A]

@IdCostoImportacion int  output,
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
Insert into [CostosImportacion]
(
 IdArticulo,
 IdProveedor,
 PosicionNCE,
 IdPosicionImportacion,
 Derechos,
 GastosEstadisticas,
 OtrosGastos1,
 OtrosGastos2,
 FechaCostoImportacion,
 Observaciones,
 PrecioFOB,
 IdMoneda1,
 Conversion1,
 FleteMaritimo,
 IdMoneda2,
 Conversion2,
 OtrosFletes,
 IdMoneda3,
 Conversion3,
 PrecioCF,
 PorcGastosDespacho,
 TotalGastosDespacho,
 PorcTotalGastos,
 TotalGastos,
 PrecioTotal
)
Values
(
 @IdArticulo,
 @IdProveedor,
 @PosicionNCE,
 @IdPosicionImportacion,
 @Derechos,
 @GastosEstadisticas,
 @OtrosGastos1,
 @OtrosGastos2,
 @FechaCostoImportacion,
 @Observaciones,
 @PrecioFOB,
 @IdMoneda1,
 @Conversion1,
 @FleteMaritimo,
 @IdMoneda2,
 @Conversion2,
 @OtrosFletes,
 @IdMoneda3,
 @Conversion3,
 @PrecioCF,
 @PorcGastosDespacho,
 @TotalGastosDespacho,
 @PorcTotalGastos,
 @TotalGastos,
 @PrecioTotal
)
Select @IdCostoImportacion=@@identity
Return(@IdCostoImportacion)





