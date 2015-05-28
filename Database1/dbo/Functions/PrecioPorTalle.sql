CREATE FUNCTION PrecioPorTalle(@IdArticulo int,@Talle varchar(2))
RETURNS numeric(18,2)

AS

BEGIN

DECLARE @TalleCambioPrecio varchar(2), @TalleCambioPrecio2 varchar(2), @Precio numeric(18,2), @IdCurvaTalle int, @CurvaTallesReales varchar(50), @CurvaTallesCodigos varchar(50), @j int, @Pos int, @Tramo int, @IdListaPrecios int

SET @IdCurvaTalle=IsNull((Select Top 1 IdCurvaTalle From Articulos Where IdArticulo=@IdArticulo),0)
SET @TalleCambioPrecio=Rtrim(Ltrim(IsNull((Select Top 1 TalleCambioPrecio From Articulos Where IdArticulo=@IdArticulo),'')))
SET @TalleCambioPrecio2=Rtrim(Ltrim(IsNull((Select Top 1 TalleCambioPrecio2 From Articulos Where IdArticulo=@IdArticulo),'')))

SET @CurvaTallesReales=IsNull((Select Top 1 Curva From CurvasTalles Where IdCurvaTalle=@IdCurvaTalle),'')
SET @CurvaTallesCodigos=IsNull((Select Top 1 CurvaCodigos From CurvasTalles Where IdCurvaTalle=@IdCurvaTalle),'')

SET @IdListaPrecios=IsNull((Select Top 1 IdListaPrecios From ListasPrecios Where NumeroLista=1),0)

SET @j=0
SET @Pos=0
SET @Tramo=1

IF Len(@TalleCambioPrecio)>0
  BEGIN
	WHILE @j<15
	  BEGIN
		SET @j=@j+1
		IF Rtrim(Ltrim(Substring(@CurvaTallesReales,(@j-1)*2+1,2)))=@TalleCambioPrecio
			SET @Tramo=2
		IF Len(@TalleCambioPrecio2)>0 and Rtrim(Ltrim(Substring(@CurvaTallesReales,(@j-1)*2+1,2)))=@TalleCambioPrecio2
			SET @Tramo=3
		IF Rtrim(Ltrim(Substring(@CurvaTallesReales,(@j-1)*2+1,2)))=@Talle
		  BEGIN
			SET @Pos=@j
			BREAK
		  END
	  END
	IF @Pos=0
		SET @Tramo=1
  END

SET @Precio=IsNull((Select Top 1 Case When @Tramo=1 Then Precio When @Tramo=2 Then Precio4 When @Tramo=2 Then Precio7 Else Precio End From ListasPreciosDetalle Where IdListaPrecios=@IdListaPrecios and IdArticulo=@IdArticulo),0)

RETURN @Precio

END