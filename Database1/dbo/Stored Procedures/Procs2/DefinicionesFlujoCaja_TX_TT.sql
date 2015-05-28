


CREATE  Procedure [dbo].[DefinicionesFlujoCaja_TX_TT]

@IdDefinicionFlujoCaja int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='0111133'
Set @vector_T='0693500'

SELECT 
 DefinicionesFlujoCaja.IdDefinicionFlujoCaja,
 DefinicionesFlujoCaja.Codigo as [Numero de vale],
 DefinicionesFlujoCaja.IdDefinicionFlujoCaja as [IdAux],
 DefinicionesFlujoCaja.Descripcion as [Descripcion],
 Case When IsNull(DefinicionesFlujoCaja.TipoConcepto,0)=1 Then 'Ingresos'
	When IsNull(DefinicionesFlujoCaja.TipoConcepto,0)=2 Then 'Egresos'
	When IsNull(DefinicionesFlujoCaja.TipoConcepto,0)=3 Then 'Otros'
	Else Null
 End as [Tipo concepto],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DefinicionesFlujoCaja
WHERE (IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja)


