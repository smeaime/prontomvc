




CREATE Procedure [dbo].[FormulariosTabIndex_TX_PorFormulario]
@Formulario varchar(100)
AS 
SELECT *
FROM FormulariosTabIndex
WHERE Formulario=@Formulario
ORDER BY TabIndex DESC




