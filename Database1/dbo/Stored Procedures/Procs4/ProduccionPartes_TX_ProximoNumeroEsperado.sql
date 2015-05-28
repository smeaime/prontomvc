
create procedure ProduccionPartes_TX_ProximoNumeroEsperado

AS 


SELECT ProximoNumeroEsperado=IDENT_CURRENT('ProduccionPartes') + 1

