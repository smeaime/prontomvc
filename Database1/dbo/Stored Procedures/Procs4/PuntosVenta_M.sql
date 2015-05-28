CREATE  Procedure [dbo].[PuntosVenta_M]

@IdPuntoVenta int ,
@Letra varchar(1),
@PuntoVenta int,
@IdTipoComprobante int,
@ProximoNumero int,
@NumeroCAI_R_A varchar(20),
@FechaCAI_R_A datetime,
@NumeroCAI_F_A varchar(20),
@FechaCAI_F_A datetime,
@NumeroCAI_D_A varchar(20),
@FechaCAI_D_A datetime,
@NumeroCAI_C_A varchar(20),
@FechaCAI_C_A datetime,
@NumeroCAI_R_B varchar(20),
@FechaCAI_R_B datetime,
@NumeroCAI_F_B varchar(20),
@FechaCAI_F_B datetime,
@NumeroCAI_D_B varchar(20),
@FechaCAI_D_B datetime,
@NumeroCAI_C_B varchar(20),
@FechaCAI_C_B datetime,
@NumeroCAI_R_E varchar(20),
@FechaCAI_R_E datetime,
@NumeroCAI_F_E varchar(20),
@FechaCAI_F_E datetime,
@NumeroCAI_D_E varchar(20),
@FechaCAI_D_E datetime,
@NumeroCAI_C_E varchar(20),
@FechaCAI_C_E datetime,
@ProximoNumero1 int,
@ProximoNumero2 int,
@ProximoNumero3 int,
@ProximoNumero4 int,
@ProximoNumero5 int,
@Descripcion varchar(50),
@WebService varchar(5),
@WebServiceModoTest varchar(2),
@CAEManual varchar(2),
@Activo varchar(2),
@AgentePercepcionIIBB varchar(2),
@CodigoAuxiliar int,
@IdDeposito int

AS

SET NOCOUNT ON

DECLARE @LetraAnt varchar(1), @PuntoVentaAnt int, @ProximoNumeroAnt int

SET @LetraAnt=IsNull((Select Top 1 Letra From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),'')
SET @PuntoVentaAnt=IsNull((Select Top 1 PuntoVenta From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),0)
SET @ProximoNumeroAnt=IsNull((Select Top 1 ProximoNumero From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),0)

IF @Letra<>@LetraAnt or @PuntoVenta<>@PuntoVentaAnt or @ProximoNumero<>@ProximoNumeroAnt
	INSERT INTO Log
	(Tipo, IdComprobante, FechaRegistro, Detalle)
	VALUES
	('MOD', @IdPuntoVenta, getdate(), 'Modif. proximo numero '+
	 @LetraAnt+'-'+Substring('0000',1,4-Len(Convert(varchar,@PuntoVentaAnt)))+Convert(varchar,@PuntoVentaAnt)+'-'+Substring('00000000',1,8-Len(Convert(varchar,@ProximoNumeroAnt)))+Convert(varchar,@ProximoNumeroAnt)+' por '+
	 @Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,@PuntoVenta)))+Convert(varchar,@PuntoVenta)+'-'+Substring('00000000',1,8-Len(Convert(varchar,@ProximoNumero)))+Convert(varchar,@ProximoNumero))

SET NOCOUNT OFF

UPDATE PuntosVenta
SET 
 Letra=@Letra,
 PuntoVenta=@PuntoVenta,
 IdTipoComprobante=@IdTipoComprobante,
 ProximoNumero=@ProximoNumero,
 NumeroCAI_R_A=@NumeroCAI_R_A,
 FechaCAI_R_A=@FechaCAI_R_A,
 NumeroCAI_F_A=@NumeroCAI_F_A,
 FechaCAI_F_A=@FechaCAI_F_A,
 NumeroCAI_D_A=@NumeroCAI_D_A,
 FechaCAI_D_A=@FechaCAI_D_A,
 NumeroCAI_C_A=@NumeroCAI_C_A,
 FechaCAI_C_A=@FechaCAI_C_A,
 NumeroCAI_R_B=@NumeroCAI_R_B,
 FechaCAI_R_B=@FechaCAI_R_B,
 NumeroCAI_F_B=@NumeroCAI_F_B,
 FechaCAI_F_B=@FechaCAI_F_B,
 NumeroCAI_D_B=@NumeroCAI_D_B,
 FechaCAI_D_B=@FechaCAI_D_B,
 NumeroCAI_C_B=@NumeroCAI_C_B,
 FechaCAI_C_B=@FechaCAI_C_B,
 NumeroCAI_R_E=@NumeroCAI_R_E,
 FechaCAI_R_E=@FechaCAI_R_E, NumeroCAI_F_E=@NumeroCAI_F_E,
 FechaCAI_F_E=@FechaCAI_F_E,
 NumeroCAI_D_E=@NumeroCAI_D_E,
 FechaCAI_D_E=@FechaCAI_D_E,
 NumeroCAI_C_E=@NumeroCAI_C_E,
 FechaCAI_C_E=@FechaCAI_C_E,
 ProximoNumero1=@ProximoNumero1,
 ProximoNumero2=@ProximoNumero2,
 ProximoNumero3=@ProximoNumero3,
 ProximoNumero4=@ProximoNumero4,
 ProximoNumero5=@ProximoNumero5,
 Descripcion=@Descripcion,
 WebService=@WebService,
 WebServiceModoTest=@WebServiceModoTest,
 CAEManual=@CAEManual,
 Activo=@Activo,
 AgentePercepcionIIBB=@AgentePercepcionIIBB,
 CodigoAuxiliar=@CodigoAuxiliar,
 IdDeposito=@IdDeposito
WHERE (IdPuntoVenta=@IdPuntoVenta)

RETURN(@IdPuntoVenta)