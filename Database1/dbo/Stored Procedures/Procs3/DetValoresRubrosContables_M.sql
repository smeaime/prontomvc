
CREATE Procedure [dbo].[DetValoresRubrosContables_M]
@IdDetalleValorRubrosContables int,
@IdValor int,
@IdRubroContable int,
@Importe numeric(18,2)
As
Update DetalleValoresRubrosContables
Set 
 IdValor=@IdValor,
 IdRubroContable=@IdRubroContable,
 Importe=@Importe
Where (IdDetalleValorRubrosContables=@IdDetalleValorRubrosContables)
Return(@IdDetalleValorRubrosContables)
