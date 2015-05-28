
CREATE FUNCTION [dbo].[wTarifaWilliams]
(
	@idCliente int,
	@IdArticulo int, 
	@IdDestino int,
	
	@TipoTarifa int=NULL,   -- 0 normal (default)/ 1 exportacion / 2 embarque 
	@Cantidad NUMERIC(18, 2) =NULL 
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
declare @PrecioEmbarque2 money
declare @MaximaCantidadParaPrecioEmbarque NUMERIC(18, 2)

declare @FechaVigencia Datetime



	
            SELECT TOP 1 @idlistaPrecio=idListaPrecios FROM Clientes WHERE idCliente=@idCliente

            SELECT TOP 1 @FechaVigencia=FechaVigencia FROM ListasPrecios WHERE IdListaPrecios=@idlistaPrecio

			if ((  @FechaVigencia<GetDate() ) and (@FechaVigencia is not null) )
			begin
				return 0
				--set @FechaVigencia=@FechaVigencia
			end
	

			SELECT TOP 1 @Precio=precio,@PrecioRepetidoPeroConPrecision=PrecioRepetidoPeroConPrecision
						,@PrecioExportacion=PrecioExportacion, @PrecioEmbarque=PrecioEmbarque, @PrecioEmbarque2=PrecioEmbarque2, 
						@MaximaCantidadParaPrecioEmbarque= MaximaCantidadParaPrecioEmbarque
			FROM ListasPreciosDetalle
			WHERE idListaPrecios=@idlistaPrecio AND idArticulo=@idArticulo
						 AND (ISNULL(IdDestinoDeCartaDePorte,0)=@idDestino OR IdDestinoDeCartaDePorte IS NULL)
			ORDER BY IdDestinoDeCartaDePorte DESC

  

			if @TipoTarifa=1 begin return @PrecioExportacion end
			if @TipoTarifa=2 begin 
				
				if @Cantidad<=@MaximaCantidadParaPrecioEmbarque  begin
					return @PrecioEmbarque 
				end
				else begin
					return @PrecioEmbarque2 
				end


			end


			return isnull(@PrecioRepetidoPeroConPrecision,@Precio)



end
						
