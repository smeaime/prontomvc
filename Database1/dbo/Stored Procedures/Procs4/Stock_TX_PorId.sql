
create Procedure Stock_TX_PorId
@IdStock int
AS 
SELECT * 
FROM stock
WHERE (IdStock=@IdStock)
