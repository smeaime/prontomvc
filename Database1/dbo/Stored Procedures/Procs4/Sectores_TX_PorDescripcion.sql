





























CREATE Procedure [dbo].[Sectores_TX_PorDescripcion]
@Descripcion varchar(50)
AS 
Select 
IdSector
FROM Sectores
where Descripcion=@Descripcion






























