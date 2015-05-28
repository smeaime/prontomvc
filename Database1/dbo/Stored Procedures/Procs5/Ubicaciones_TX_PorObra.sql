CREATE Procedure [dbo].[Ubicaciones_TX_PorObra]

@IdObra int = Null,
@IdDeposito int = Null,
@IdArticulo int = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

DECLARE @RegistrarStock varchar(2)

SET @IdObra=IsNull(@IdObra,-1)
SET @IdDeposito=IsNull(@IdDeposito,-1)
SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @IdUsuario=IsNull(@IdUsuario,-1)

IF @IdArticulo>0
	SET @RegistrarStock=IsNull((Select Top 1 RegistrarStock From Articulos Where IdArticulo=@IdArticulo),'SI')
ELSE
	SET @RegistrarStock='NO'

SET NOCOUNT OFF

SELECT 
 U.IdUbicacion,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+U.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Est.:'+U.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Mod.:'+U.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	IsNull(' - Gab.:'+U.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
	Case When @IdArticulo>0 and @RegistrarStock='SI' Then ', Stock : '+
		Convert(varchar,IsNull((Select Sum(IsNull(S.CantidadUnidades,0)) From Stock S 
					  Where S.IdArticulo=@IdArticulo and (@IdObra<=0 or S.IdObra=@IdObra) and S.IdUbicacion=U.IdUbicacion),0))
		Else ''
	End as [Titulo]
/*
	IsNull(' - Est.:'+Ubicaciones.Estanteria,'')+
	IsNull(' - Mod.:'+Ubicaciones.Modulo,'')+
	IsNull(' - Gab.:'+Ubicaciones.Gabeta,'') 
*/
FROM Ubicaciones U
LEFT OUTER JOIN Depositos ON U.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN Obras ON Depositos.IdObra = Obras.IdObra
WHERE (@IdObra<=0 or IsNull(Depositos.IdObra,0)=@IdObra) and 
	(@IdDeposito=-1 or IsNull(U.IdDeposito,0)=@IdDeposito) and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and deo.IdObra=Obras.IdObra))
ORDER by [Titulo]