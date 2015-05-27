CREATE Procedure [dbo].[PuntosVenta_TX_PuntosVentaPorIdTipoComprobanteLetra]

@IdTipoComprobante int,
@Letra varchar(1) = Null,
@Activo varchar(2) = Null,
@IdPuntoVenta int = Null

AS 

SET @Letra=IsNull(@Letra,'')
SET @Activo=IsNull(@Activo,'')
SET @IdPuntoVenta=IsNull(@IdPuntoVenta,0)

SELECT 
 IdPuntoVenta,
 Substring('0000',1,4-Len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta) as [Titulo], --+' ('+Letra+')'
 ProximoNumero,
 NumeroCAI_R_A,
 FechaCAI_R_A,
 NumeroCAI_F_A,
 FechaCAI_F_A,
 NumeroCAI_D_A,
 FechaCAI_D_A,
 NumeroCAI_C_A,
 FechaCAI_C_A,
 NumeroCAI_R_B,
 FechaCAI_R_B,
 NumeroCAI_F_B,
 FechaCAI_F_B,
 NumeroCAI_D_B,
 FechaCAI_D_B,
 NumeroCAI_C_B,
 FechaCAI_C_B,
 NumeroCAI_R_E,
 FechaCAI_R_E, 
 NumeroCAI_F_E,
 FechaCAI_F_E,
 NumeroCAI_D_E,
 FechaCAI_D_E,
 NumeroCAI_C_E,
 FechaCAI_C_E
FROM PuntosVenta
WHERE IdTipoComprobante=@IdTipoComprobante and (@Letra='' or Letra=@Letra) and (@Activo='' or IsNull(Activo,'SI')=@Activo) and (@IdPuntoVenta<=0 or IdPuntoVenta=@IdPuntoVenta)
ORDER by PuntoVenta