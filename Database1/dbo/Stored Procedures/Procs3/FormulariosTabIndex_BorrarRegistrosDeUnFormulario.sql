




CREATE Procedure [dbo].[FormulariosTabIndex_BorrarRegistrosDeUnFormulario]
@Formulario varchar(100)
AS 
DELETE FROM FormulariosTabIndex
WHERE Formulario=@Formulario





