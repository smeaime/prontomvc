






CREATE procedure [dbo].[REP_PROVEEDO_MARK] 
@IdProveedor  int as 
begin 
  update Proveedores set REP_PROVEEDO_UPD = 'R', REP_PROVEEDO_INS = 'R' 
where idproveedor=@idproveedor
end





