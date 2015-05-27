




/* 
	REP_CUENTAS
*/

CREATE procedure [dbo].[REP_CUENTAS] 
   @REP_CUENTAS_INS varchar(1), 
   @REP_CUENTAS_UPD varchar(1), 
   @NROCUENTA varchar(12), 
   @NOMCUENTA varchar(30)
as 
begin 
if @REP_CUENTAS_INS = 'Y'
 begin
  insert into Cuentas 
	( 
	 Codigo,
	 Descripcion,
	 IdTipoCuenta,
	 NivelTotal,
	 IdRubroContable,
	 Jerarquia,
	 IdObra,
	 IdCuentaGasto,
	 DebeHaber,
	 IdTipoCuentaGrupo,
	 VaAlCiti,
	 PresupuestoTeoricoMes01,
	 PresupuestoTeoricoMes02,
	 PresupuestoTeoricoMes03,
	 PresupuestoTeoricoMes04,
	 PresupuestoTeoricoMes05,
	 PresupuestoTeoricoMes06,
	 PresupuestoTeoricoMes07,
	 PresupuestoTeoricoMes08,
	 PresupuestoTeoricoMes09,
	 PresupuestoTeoricoMes10,
	 PresupuestoTeoricoMes11,
	 PresupuestoTeoricoMes12,
	 EnviarEmail
	)
  values 
	( 
	 @NROCUENTA,
	 @NOMCUENTA,
	 2,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null
	) 
 end
end




