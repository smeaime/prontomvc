CREATE Procedure [dbo].[ListasPrecios_ModificarPrecios]

@IdListaPrecios int,
@Porcentaje numeric(18,2),
@IncrementoDecremento varchar(1)

AS 

SET NOCOUNT ON

IF @IncrementoDecremento='+'
	UPDATE ListasPreciosDetalle
	SET Precio=Round(Precio*(1+(@Porcentaje/100)),2), 
		Precio2=Round(Precio2*(1+(@Porcentaje/100)),2), 
		Precio3=Round(Precio3*(1+(@Porcentaje/100)),2), 
		Precio4=Round(Precio4*(1+(@Porcentaje/100)),2), 
		Precio5=Round(Precio5*(1+(@Porcentaje/100)),2), 
		Precio6=Round(Precio6*(1+(@Porcentaje/100)),2), 
		Precio7=Round(Precio7*(1+(@Porcentaje/100)),2), 
		Precio8=Round(Precio8*(1+(@Porcentaje/100)),2), 
		Precio9=Round(Precio9*(1+(@Porcentaje/100)),2)
	WHERE IdListaPrecios=@IdListaPrecios

IF @IncrementoDecremento='-'
	UPDATE ListasPreciosDetalle
	SET Precio=Round(Precio/(1+(@Porcentaje/100)),2), 
		Precio2=Round(Precio2/(1+(@Porcentaje/100)),2), 
		Precio3=Round(Precio3/(1+(@Porcentaje/100)),2), 
		Precio4=Round(Precio4/(1+(@Porcentaje/100)),2), 
		Precio5=Round(Precio5/(1+(@Porcentaje/100)),2), 
		Precio6=Round(Precio6/(1+(@Porcentaje/100)),2), 
		Precio7=Round(Precio7/(1+(@Porcentaje/100)),2), 
		Precio8=Round(Precio8/(1+(@Porcentaje/100)),2), 
		Precio9=Round(Precio9/(1+(@Porcentaje/100)),2)
	WHERE IdListaPrecios=@IdListaPrecios

SET NOCOUNT OFF
