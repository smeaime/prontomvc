CREATE Procedure [dbo].[Proveedores_TX_PorCuit]

@Cuit varchar(50)

AS 

DECLARE @CodigoEmpresa varchar(20)

SET @CodigoEmpresa=''
IF Len(@Cuit)>13
  BEGIN
	SET @CodigoEmpresa=Substring(@Cuit,14,50)
	SET @Cuit=Substring(@Cuit,1,13)
  END

SELECT * 
FROM Proveedores
WHERE Cuit=@Cuit and (@CodigoEmpresa='' or CodigoEmpresa=@CodigoEmpresa)