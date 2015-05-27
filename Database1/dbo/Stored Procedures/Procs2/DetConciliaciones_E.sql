


CREATE Procedure [dbo].[DetConciliaciones_E]

@IdDetalleConciliacion int 

As  

Declare @IdValor int
Set @IdValor=IsNull((Select Top 1 DetalleConciliaciones.IdValor
			From DetalleConciliaciones
			Where IdDetalleConciliacion=@IdDetalleConciliacion),0)

Delete [DetalleConciliaciones]
Where (IdDetalleConciliacion=@IdDetalleConciliacion)

Update Valores
Set 	MovimientoConfirmadoBanco='NO',
	FechaConfirmacionBanco=Null,
	Conciliado='NO'
Where IdValor=@IdValor and 
	Not Exists(Select Top 1 DetConc.IdDetalleConciliacion
			From DetalleConciliaciones DetConc
			Where DetConc.IdValor=@IdValor and 
				IsNull(DetConc.Conciliado,'SI')='SI')


