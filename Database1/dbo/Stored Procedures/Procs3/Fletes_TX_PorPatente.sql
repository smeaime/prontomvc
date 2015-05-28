CREATE Procedure [dbo].[Fletes_TX_PorPatente]

@Patente varchar(6),
@IdFlete int = Null

AS 

SET @IdFlete=ISNULL(@IdFlete,-1)

SELECT * 
FROM Fletes
WHERE IsNull(Patente,'')=@Patente and (@IdFlete<=0 or IdFlete<>@IdFlete)