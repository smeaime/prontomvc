


CREATE Procedure [dbo].[DefinicionesFlujoCaja_M]
@IdDefinicionFlujoCaja int,
@Codigo int,
@Descripcion varchar(50),
@CodigoInforme int,
@TipoConcepto int
As
Update DefinicionesFlujoCaja
Set 
 Codigo=@Codigo,
 Descripcion=@Descripcion,
 CodigoInforme=@CodigoInforme,
 TipoConcepto=@TipoConcepto
Where (IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja)
Return(@IdDefinicionFlujoCaja)


