CREATE Procedure [dbo].[CurvasTalles_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111133'
SET @vector_T='013222222222222222400'

SELECT 
 CurvasTalles.IdCurvaTalle,
 CurvasTalles.Codigo as [Codigo],
 CurvasTalles.Descripcion as [CurvaTalle],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),1,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),1,2) as [T1],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),3,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),3,2) as [T2],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),5,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),5,2) as [T3],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),7,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),7,2) as [T4],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),9,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),9,2) as [T5],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),11,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),11,2) as [T6],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),13,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),13,2) as [T7],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),15,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),15,2) as [T8],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),17,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),17,2) as [T9],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),19,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),19,2) as [T10],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),21,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),21,2) as [T11],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),23,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),23,2) as [T12],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),25,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),25,2) as [T13],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),27,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),27,2) as [T14],
 Substring(IsNull(CurvasTalles.CurvaCodigos,''),29,2) + ' = ' + Substring(IsNull(CurvasTalles.Curva,''),29,2) as [T15],
 CurvasTalles.MostrarCurvaEnInformes as [Mostrar en informes],
 @Vector_T as [Vector_T],
 @Vector_X as [Vector_X]
FROM CurvasTalles 
ORDER BY CurvasTalles.Codigo