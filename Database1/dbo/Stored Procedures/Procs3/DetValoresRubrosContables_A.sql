
CREATE Procedure [dbo].[DetValoresRubrosContables_A]
@IdDetalleValorRubrosContables int  output,
@IdValor int,
@IdRubroContable int,
@Importe numeric(18,2)
As 
Insert into [DetalleValoresRubrosContables]
(
 IdValor,
 IdRubroContable,
 Importe
)
Values
(
 @IdValor,
 @IdRubroContable,
 @Importe
)
Select @IdDetalleValorRubrosContables=@@identity
Return(@IdDetalleValorRubrosContables)
