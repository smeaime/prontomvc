





























CREATE Procedure [dbo].[Formularios_TX_TT]
@IdFormulario int
AS 
Select IdFormulario,Descripcion
FROM Formularios
where (IdFormulario=@IdFormulario)






























