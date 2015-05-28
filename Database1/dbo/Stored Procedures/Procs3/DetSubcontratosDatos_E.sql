
CREATE Procedure [dbo].[DetSubcontratosDatos_E]

@IdDetalleSubcontratoDatos int  

AS 

SET NOCOUNT ON

DECLARE @IdSubcontratoDatos int, @NumeroSubcontrato int, @NumeroCertificado int

SET @IdSubcontratoDatos=IsNull((Select Top 1 IdSubcontratoDatos From DetalleSubcontratosDatos Where IdDetalleSubcontratoDatos=@IdDetalleSubcontratoDatos),0)
SET @NumeroCertificado=IsNull((Select Top 1 NumeroCertificado From DetalleSubcontratosDatos Where IdDetalleSubcontratoDatos=@IdDetalleSubcontratoDatos),0)
SET @NumeroSubcontrato=IsNull((Select Top 1 NumeroSubcontrato From SubcontratosDatos Where IdSubcontratoDatos=@IdSubcontratoDatos),0)

DELETE SubcontratosPxQ
WHERE IsNull(NumeroCertificado,-1)=@NumeroCertificado and 
	 IsNull((Select Top 1 S.NumeroSubcontrato From Subcontratos S Where S.IdSubcontrato=SubcontratosPxQ.IdSubcontrato),-1)=@NumeroSubcontrato

DELETE DetalleSubcontratosDatos
WHERE IdDetalleSubcontratoDatos=@IdDetalleSubcontratoDatos

SET NOCOUNT OFF
