CREATE Procedure [dbo].[Empleados_TX_PorEstadoParaCombo]

@Activo varchar(2) = Null

AS 

SET @Activo=IsNull(@Activo,'SI')

SELECT IdEmpleado, Nombre as Titulo
FROM Empleados
WHERE (@Activo='' or IsNull(Activo,'SI')=@Activo)
ORDER BY Nombre