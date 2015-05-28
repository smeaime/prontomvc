





























CREATE Procedure [dbo].[Recepciones_TX_xNroLetra]
@Numero1 int,
@Numero2 int,
@SubNumero varchar(1),
@Prov int
AS 
SELECT * 
FROM Recepciones
WHERE NumeroRecepcion1=@Numero1 and NumeroRecepcion2=@Numero2 and 
	 SubNumero=@SubNumero and IdProveedor=@Prov






























