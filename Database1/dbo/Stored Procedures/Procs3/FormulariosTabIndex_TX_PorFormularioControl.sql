




CREATE Procedure [dbo].[FormulariosTabIndex_TX_PorFormularioControl]
@Formulario varchar(100),
@Control varchar(100),
@Subindice int
AS 
SELECT *
FROM FormulariosTabIndex
WHERE Formulario=@Formulario and 
	Control=@Control and Subindice=@Subindice




