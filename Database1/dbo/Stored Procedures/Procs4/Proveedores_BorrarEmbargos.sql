
CREATE Procedure [dbo].[Proveedores_BorrarEmbargos]

AS

UPDATE Proveedores
SET 
	SujetoEmbargado=Null, 
	SaldoEmbargo=Null, 
	DetalleEmbargo=Null

