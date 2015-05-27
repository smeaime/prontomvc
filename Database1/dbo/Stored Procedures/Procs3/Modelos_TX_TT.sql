





























CREATE Procedure [dbo].[Modelos_TX_TT]
@IdModelo int
AS 
Select IdModelo,Descripcion
FROM Modelos
where (IdModelo=@IdModelo)
order by Descripcion






























