
CREATE  Procedure [dbo].[FletesPartesDiarios_M]

@IdFleteParteDiario int ,
@IdFlete int,
@Fecha datetime,
@Cantidad numeric(18,2)

AS

UPDATE FletesPartesDiarios
SET
 IdFlete=@IdFlete,
 Fecha=@Fecha,
 Cantidad=@Cantidad
WHERE (IdFleteParteDiario=@IdFleteParteDiario)

RETURN(@IdFleteParteDiario)
