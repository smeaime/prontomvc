CREATE Procedure [dbo].[OrdenesPago_TX_ValidarNumero]

@NumeroOrdenPago int,
@IdOrdenPago int,
@Tipo varchar(2),
@Exterior varchar(2)

AS 

DECLARE @NumeracionIndependienteDeOrdenesDePagoFFyCTACTE varchar(2), @IdEjercicioContableControlNumeracion int, @FechaInicioControl datetime
SET @NumeracionIndependienteDeOrdenesDePagoFFyCTACTE=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NumeracionIndependienteDeOrdenesDePagoFFyCTACTE'),'NO')
SET @IdEjercicioContableControlNumeracion=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdEjercicioContableControlNumeracion'),0)
IF @IdEjercicioContableControlNumeracion<>0
	SET @FechaInicioControl=IsNull((Select Top 1 FechaInicio From EjerciciosContables Where IdEjercicioContable=@IdEjercicioContableControlNumeracion),Convert(datetime,'01/01/2000'))
ELSE
	SET @FechaInicioControl=Convert(datetime,'01/01/2000')

SELECT * 
FROM OrdenesPago
WHERE (@IdOrdenPago<=0 or OrdenesPago.IdOrdenPago<>@IdOrdenPago) and 
	NumeroOrdenPago=@NumeroOrdenPago and 
	FechaOrdenPago>=@FechaInicioControl and 
	((@Exterior='NO' and 
		((@Tipo='OT' and Tipo='OT') or 
		 (@NumeracionIndependienteDeOrdenesDePagoFFyCTACTE='NO' and @Tipo<>'OT' and Tipo<>'OT') or 
		 (@NumeracionIndependienteDeOrdenesDePagoFFyCTACTE='SI' and @Tipo='CC' and Tipo='CC') or 
		 (@NumeracionIndependienteDeOrdenesDePagoFFyCTACTE='SI' and @Tipo='FF' and Tipo='FF')))
	or 
	(@Exterior='SI' and Exterior='SI'))
