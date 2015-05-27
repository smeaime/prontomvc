CREATE Procedure [dbo].[Autorizaciones_TX_CantidadAutorizaciones]

@IdFormulario int,
@Importe numeric(18,2),
@IdComprobante int = Null

AS 

SET @IdComprobante=IsNull(@IdComprobante,-1)

IF @IdFormulario=4 -- Pedidos
   BEGIN
	SET NOCOUNT ON
	DECLARE @IdTipoCompraRM int
	SET @IdTipoCompraRM=IsNull((Select Top 1 IdTipoCompraRM From Pedidos Where IdPedido=@IdComprobante),0)
	SET NOCOUNT ON

	SELECT DISTINCT DetAut.OrdenAutorizacion
	FROM DetalleAutorizaciones DetAut
	INNER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion
	WHERE Autorizaciones.IdFormulario=@IdFormulario and 
		(Patindex('%'+DetAut.SectorEmisor1+'%', 'F S O')=0 or 
		 (Patindex('%'+DetAut.SectorEmisor1+'%', 'F S O')<>0 and @Importe between IsNull(DetAut.ImporteDesde1,0) and IsNull(DetAut.ImporteHasta1,0))) and 
		(Len(IsNull(DetAut.IdsTipoCompra,''))=0 or Patindex('%('+Convert(varchar,@IdTipoCompraRM)+')%', IsNull(DetAut.IdsTipoCompra,''))<>0)
   END
ELSE
	SELECT DISTINCT DetAut.OrdenAutorizacion
	FROM DetalleAutorizaciones DetAut
	INNER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion
	WHERE Autorizaciones.IdFormulario=@IdFormulario and 
		(Patindex('%'+DetAut.SectorEmisor1+'%', 'F S O')=0 or 
		 (Patindex('%'+DetAut.SectorEmisor1+'%', 'F S O')<>0 and @Importe between IsNull(DetAut.ImporteDesde1,0) and IsNull(DetAut.ImporteHasta1,0)))
	ORDER BY DetAut.OrdenAutorizacion