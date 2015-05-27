































CREATE Procedure [dbo].[AcoCodigos_TX_TT]
@IdAcoCodigo int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='04400'
Select 
AcoCodigos.IdAcoCodigo,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM AcoCodigos
INNER JOIN Rubros ON AcoCodigos.IdRubro = Rubros.IdRubro
INNER JOIN Subrubros ON AcoCodigos.IdSubrubro = Subrubros.IdSubrubro
where (IdAcoCodigo=@IdAcoCodigo)
































