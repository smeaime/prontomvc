
CREATE procedure [dbo].[REP_CTAPRO_MARK] 
@IdComprobanteProveedor  int as 
begin 
  update ComprobantesProveedores set REP_CTAPRO_UPD = 'R', REP_CTAPRO_INS = 'R' 
where idcomprobanteproveedor=@idcomprobanteproveedor
end
