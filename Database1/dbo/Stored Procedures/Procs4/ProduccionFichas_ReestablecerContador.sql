
create Procedure ProduccionFichas_ReestablecerContador
AS
declare @a int
select @a=max(IdProduccionFicha)+1 from ProduccionFichas
DBCC CHECKIDENT ('ProduccionFichas', RESEED, @a)
