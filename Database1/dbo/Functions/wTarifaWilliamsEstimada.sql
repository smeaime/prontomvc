
CREATE FUNCTION [dbo].[wTarifaWilliamsEstimada]
(
	@idCliente int,
	@IdArticulo int, 
	@IdDestino int,
	
	@TipoTarifa int=NULL   -- 0 normal (default)/ 1 exportacion / 2 embarque
)

RETURNS money
AS
BEGIN

SET @TipoTarifa = ISNULL(@TipoTarifa, 0)

declare @idlistaPrecio int
declare @Precio money
declare @PrecioRepetidoPeroConPrecision money
declare @PrecioExportacion money
declare @PrecioEmbarque money

declare @PrecioEstimado money

            SELECT TOP 1 @idlistaPrecio=idListaPrecios FROM Clientes WHERE idCliente=@idCliente

            --If dt1.Rows.Count > 0 Then
            --    idlistaPrecio = iisNull(dt1.Rows(0).Item("idListaPrecios"), 0)
            --    If idlistaPrecio = 0 Then Return 0
            --Else
            --    Return 0
            --End If


			SELECT TOP 1 @Precio=precio,@PrecioRepetidoPeroConPrecision=PrecioRepetidoPeroConPrecision
						,@PrecioExportacion=PrecioExportacion, @PrecioEmbarque=PrecioEmbarque
			FROM ListasPreciosDetalle
			WHERE idListaPrecios=@idlistaPrecio AND idArticulo=@idArticulo
						 AND (ISNULL(IdDestinoDeCartaDePorte,0)=@idDestino OR IdDestinoDeCartaDePorte IS NULL)
			ORDER BY IdDestinoDeCartaDePorte DESC

            --If dt.Rows.Count > 0 Then
            --    Tarifa = iisNull(dt.Rows(0).Item("PrecioRepetidoPeroConPrecision"), ArticuloManager.GetItem(SC, idArticulo).CostoPPP)
            --    If Tarifa = 0 Then
            --        Tarifa = iisNull(dt.Rows(0).Item("Precio"), ArticuloManager.GetItem(SC, idArticulo).CostoPPP)
            --    End If
            --Else
            --    Tarifa = 0
            --End If




			if @TipoTarifa=1 begin return @PrecioExportacion end
			if @TipoTarifa=2 begin return @PrecioEmbarque end

			


        --'        * Si la carta de Porte esta facturada -> Tomar en cuenta la tarifa que se facturó
        --'* Si la carta de Porte no está facturada -> Tal como en el informe \"Proyección de facturación\", 
	--			chequear a que cliente le correspondería en el automático facturarle la 
--				carta de porte y tomar la tarifa que le corresponde.
        --'* Si de lo anterior surge una tarifa en cero o un cliente que no tiene cargada la tarifa, 
		-- promediar las tarifas del mes anterior para el mismo Cereal y mismo Destino. 
		-- (intentar con esto acercarse lo más posible a lo real y buscar que no queden cartas de porte en 0)
			set @PrecioEstimado=isnull(isnull(@PrecioRepetidoPeroConPrecision,@Precio),0)
			
			if @PrecioEstimado=0 
			begin 
				
				select top 20 @PrecioEstimado=avg(PrecioUnitario)
				from detallefacturas
				where 
				--	--CP.iddestino=@iddestio and  AND (ISNULL(IdDestinoDeCartaDePorte,0)=@idDestino
					idArticulo=@idArticulo
					--and fecha>dateadd(month,2, GETDATE() )
					--order by iddetallefactura desc
			end




			return @PrecioEstimado



end
						
