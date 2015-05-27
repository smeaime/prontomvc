

CREATE Procedure [dbo].[Empleados_TX_AdministradoresMasJefeCompras]

AS 

DECLARE @IdJefeCompras int
SET @IdJefeCompras=IsNull((Select Top 1 P.IdJefeCompras From Parametros P 
				Where P.IdParametro=1),0)

SELECT *
FROM Empleados
WHERE (IsNull(Administrador,'NO')='SI' or IdEmpleado=@IdJefeCompras) and IsNull(Activo,'SI')='SI'
ORDER BY Nombre

