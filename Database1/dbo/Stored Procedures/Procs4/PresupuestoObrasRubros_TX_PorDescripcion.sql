
CREATE Procedure [dbo].[PresupuestoObrasRubros_TX_PorDescripcion]

@Descripcion varchar(50)

AS 

SELECT * 
FROM Tipos
WHERE Descripcion=@Descripcion and Grupo=1
