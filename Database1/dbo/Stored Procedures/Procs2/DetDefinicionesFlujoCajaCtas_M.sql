


CREATE Procedure [dbo].[DetDefinicionesFlujoCajaCtas_M]
@IdDetalleDefinicionFlujoCaja int,
@IdDefinicionFlujoCaja int,
@IdCuenta int,
@IdRubroContable int,
@OtroConcepto varchar(50)
As
Update [DetalleDefinicionesFlujoCajaCuentas]
Set 
 IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja,
 IdCuenta=@IdCuenta,
 IdRubroContable=@IdRubroContable,
 OtroConcepto=@OtroConcepto
Where (IdDetalleDefinicionFlujoCaja=@IdDetalleDefinicionFlujoCaja)
Return(@IdDetalleDefinicionFlujoCaja)


