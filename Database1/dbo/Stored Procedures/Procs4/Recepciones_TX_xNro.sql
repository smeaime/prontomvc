CREATE Procedure [dbo].[Recepciones_TX_xNro]

@Numero1 int,
@Numero2 int,
@Prov int

AS 

SELECT * 
FROM Recepciones
WHERE NumeroRecepcion1=@Numero1 and NumeroRecepcion2=@Numero2 and IdProveedor=@Prov
ORDER By SubNumero