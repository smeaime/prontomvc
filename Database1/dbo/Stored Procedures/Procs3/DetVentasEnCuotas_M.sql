




CREATE Procedure [dbo].[DetVentasEnCuotas_M]
@IdDetalleVentaEnCuotas int,
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
Update [DetalleVentasEnCuotas]
Set 
 IdVentaEnCuotas=@IdVentaEnCuotas,
 FechaCobranza=@FechaCobranza,
 ImporteCobrado=@ImporteCobrado,
 Cuota=@Cuota,
 Intereses=@Intereses,
 IdRecibo=@IdRecibo,
 NumeroGeneracion=@NumeroGeneracion,
 FechaGeneracion=@FechaGeneracion,
 FechaPrimerVencimiento=@FechaPrimerVencimiento,
 FechaSegundoVencimiento=@FechaSegundoVencimiento,
 FechaTercerVencimiento=@FechaTercerVencimiento,
 InteresPrimerVencimiento=@InteresPrimerVencimiento,
 InteresSegundoVencimiento=@InteresSegundoVencimiento,
 IdBanco=@IdBanco,
 IdNotaDebito=@IdNotaDebito,
 TipoGeneracion=@TipoGeneracion,
 ModalidadDeGeneracion=@ModalidadDeGeneracion,
 FechaRegistroParaND=@FechaRegistroParaND
Where (IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas)
Return(@IdDetalleVentaEnCuotas)




