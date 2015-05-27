
CREATE Procedure [dbo].[DetValoresRubrosContables_BorrarPorIdValor]
@IdValor int  
As 
Delete DetalleValoresRubrosContables
Where (IdValor=@IdValor)
