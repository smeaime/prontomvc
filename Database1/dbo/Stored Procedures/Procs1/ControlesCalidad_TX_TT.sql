

CREATE Procedure [dbo].[ControlesCalidad_TX_TT]

@IdControlCalidad int

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011133'
Set @vector_T='0E5500'

SELECT
 IdControlCalidad,
 Descripcion,
 Inspeccion,
 Abreviatura,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ControlesCalidad
WHERE (IdControlCalidad=@IdControlCalidad)

