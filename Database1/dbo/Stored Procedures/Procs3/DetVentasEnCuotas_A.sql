




CREATE Procedure [dbo].[DetVentasEnCuotas_A]
@IdDetalleVentaEnCuotas int  output,
@IdVentaEnCuotas int,
@Cuota int,
@FechaCobranza datetime,
@ImporteCobrado numeric(18,2),
@Intereses numeric(18,2),
@IdRecibo int,
@NumeroGeneracion int,
@FechaGeneracion datetime,
@FechaPrimerVencimiento datetime,
@FechaSegundoVencimiento datetime,
@FechaTercerVencimiento datetime,
@InteresPrimerVencimiento numeric(6,2),
@InteresSegundoVencimiento numeric(6,2),
@IdBanco int,
@IdNotaDebito int,
@TipoGeneracion varchar(1),
@ModalidadDeGeneracion varchar(1),
@FechaRegistroParaND datetime
As 
Insert into [DetalleVentasEnCuotas]
(
 IdVentaEnCuotas,
 Cuota,
 FechaCobranza,
 ImporteCobrado,
 Intereses,
 IdRecibo,
 NumeroGeneracion,
 FechaGeneracion,
 FechaPrimerVencimiento,
 FechaSegundoVencimiento,
 FechaTercerVencimiento,
 InteresPrimerVencimiento,
 InteresSegundoVencimiento,
 IdBanco,
 IdNotaDebito,
 TipoGeneracion,
 ModalidadDeGeneracion,
 FechaRegistroParaND
)
Values
(
 @IdVentaEnCuotas,
 @Cuota,
 @FechaCobranza,
 @ImporteCobrado,
 @Intereses,
 @IdRecibo,
 @NumeroGeneracion,
 @FechaGeneracion,
 @FechaPrimerVencimiento,
 @FechaSegundoVencimiento,
 @FechaTercerVencimiento,
 @InteresPrimerVencimiento,
 @InteresSegundoVencimiento,
 @IdBanco,
 @IdNotaDebito,
 @TipoGeneracion,
 @ModalidadDeGeneracion,
 @FechaRegistroParaND
)
Select @IdDetalleVentaEnCuotas=@@identity
Return(@IdDetalleVentaEnCuotas)




