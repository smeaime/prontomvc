





























CREATE Procedure [dbo].[ArticulosInformacionAdicional_M]
@IdArticuloInformacionAdicional int,
@IdArticulo int,
@Campo varchar(50),
@CampoItem varchar(50),
@ValorCampoChar varchar(50),
@ValorCampoNum numeric(12,2)
as
Update [ArticulosInformacionAdicional]
SET 
IdArticulo=@IdArticulo,
Campo=@Campo,
CampoItem=@CampoItem,
ValorCampoChar=@ValorCampoChar,
ValorCampoNum=@ValorCampoNum
where (IdArticuloInformacionAdicional=@IdArticuloInformacionAdicional)
Return(@IdArticuloInformacionAdicional)






























