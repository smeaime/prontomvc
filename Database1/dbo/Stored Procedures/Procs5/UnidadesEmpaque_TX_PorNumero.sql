
CREATE Procedure [dbo].[UnidadesEmpaque_TX_PorNumero]

@NumeroUnidad int

AS 

SELECT UnidadesEmpaque.*, Colores.Descripcion as [Color]
FROM UnidadesEmpaque
LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
WHERE (NumeroUnidad=@NumeroUnidad)
