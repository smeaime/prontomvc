CREATE Procedure ProduccionLineas_TL
AS 
Select 
IdProduccionLinea, Descripcion as [Titulo]
FROM ProduccionLineas
ORDER by idProduccionLinea
