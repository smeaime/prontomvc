





























CREATE Procedure [dbo].[ArticulosInformacionAdicional_A]
@IdArticuloInformacionAdicional int  output,
@IdArticulo int,
@Campo varchar(50),
@CampoItem varchar(50),
@ValorCampoChar varchar(50),
@ValorCampoNum numeric(12,2)
AS 
Insert into [ArticulosInformacionAdicional]
(
 IdArticulo,
 Campo,
 CampoItem,
 ValorCampoChar,
 ValorCampoNum
)
Values
(
 @IdArticulo,
 @Campo,
 @CampoItem,
 @ValorCampoChar,
 @ValorCampoNum
)
Select @IdArticuloInformacionAdicional=@@identity
Return(@IdArticuloInformacionAdicional)






























