CREATE Procedure [dbo].[DefinicionesFlujoCaja_A]

@IdDefinicionFlujoCaja int  output,
@Codigo int,
@Descripcion varchar(50),
@CodigoInforme int,
@TipoConcepto int

AS

INSERT INTO DefinicionesFlujoCaja
(
 Codigo,
 Descripcion,
 CodigoInforme,
 TipoConcepto
)
VALUES
(
 @Codigo,
 @Descripcion,
 @CodigoInforme,
 @TipoConcepto
)

SELECT @IdDefinicionFlujoCaja=@@identity

RETURN(@IdDefinicionFlujoCaja)