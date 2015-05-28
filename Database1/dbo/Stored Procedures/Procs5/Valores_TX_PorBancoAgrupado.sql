
CREATE Procedure [dbo].[Valores_TX_PorBancoAgrupado]

@Tipo varchar(2)

AS

IF @Tipo='IN'
	SELECT IsNull(Valores.IdBancoDeposito,0) as [IdBanco], 
		IsNull(Bancos.Nombre,'En cartera') as [Banco]
	FROM Valores
	LEFT OUTER JOIN Bancos ON Valores.IdBancoDeposito=Bancos.IdBanco
	WHERE Valores.IdTipoComprobante<>17 and Valores.IdTipoValor=6
	GROUP BY Bancos.Nombre, Valores.IdBancoDeposito
	ORDER BY Bancos.Nombre, Valores.IdBancoDeposito
ELSE
	SELECT Valores.IdBanco as [IdBanco], IsNull(Bancos.Nombre,'') as [Banco]
	FROM Valores
	LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
	WHERE Valores.IdTipoComprobante=17 and Valores.IdTipoValor=6
	GROUP BY Bancos.Nombre, Valores.IdBanco
	ORDER BY Bancos.Nombre, Valores.IdBanco

