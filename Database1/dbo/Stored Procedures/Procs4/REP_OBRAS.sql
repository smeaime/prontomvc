




/*  
	REP_OBRAS
*/

CREATE procedure [dbo].[REP_OBRAS] 
   @REP_OBRAS_INS varchar(1), 
   @REP_OBRAS_UPD varchar(1), 
   @CCOSTO varchar(12), 
   @NOMBRE varchar(30)
as 
begin 
if @REP_OBRAS_INS = 'Y'
 begin
  insert into Obras 
	( 
	 NumeroObra,
	 IdCliente,
	 FechaInicio,
	 FechaFinalizacion,
	 Observaciones,
	 FechaEntrega,
	 Descripcion,
	 IdJefe,
	 TipoObra,
	 HorasEstimadas,
	 Consorcial,
	 EnviarEmail,
	 Activa,
	 ParaInformes,
	 IdUnidadOperativa,
	 Jerarquia,
	 ArchivoAdjunto1,
	 ArchivoAdjunto2,
	 ArchivoAdjunto3,
	 ArchivoAdjunto4,
	 ArchivoAdjunto5,
	 ArchivoAdjunto6,
	 ArchivoAdjunto7,
	 ArchivoAdjunto8,
	 ArchivoAdjunto9,
	 ArchivoAdjunto10,
	 GeneraReservaStock,
	 IdGrupoObra
	)
  values 
	( 
	 @CCOSTO,
	 null,
	 null,
	 null,
	 null,
	 null,
	 @NOMBRE,
	 null,
	 null,
	 null,
	 null,
	 null,
	 'SI',
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




