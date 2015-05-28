CREATE Procedure [dbo].[Clientes_TX_PorCodigo]

@Codigo varchar(10)

AS 

SELECT * 
FROM Clientes
WHERE Codigo=@Codigo or (Case When IsNumeric(@Codigo)=1 Then @Codigo Else -1 End=CodigoCliente)