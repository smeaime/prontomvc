-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAllCompanies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAllCompanies]
GO

CREATE    PROCEDURE [dbo].[GetAllCompanies]
AS

Select IdBD, Descripcion, StringConection from Bases
GO

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



/****** Object:  StoredProcedure [dbo].[DeleteUserInCompanies]    Script Date: 07/25/2011 01:37:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteUserInCompanies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteUserInCompanies]
GO


CREATE   PROCEDURE [dbo].[DeleteUserInCompanies]
@IdUser varchar(100),
@IdCompany int
AS
BEGIN TRANSACTION

Delete From DetalleUserBD
where Exists  (Select * From DetalleUserBD where (UserId = @IdUser and IdBD = @IdCompany))
and (UserId = @IdUser and IdBD = @IdCompany)

COMMIT

GO


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


/****** Object:  StoredProcedure [dbo].[GetCompaniesForUser]    Script Date: 07/25/2011 01:37:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCompaniesForUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCompaniesForUser]
GO

CREATE PROCEDURE [dbo].[GetCompaniesForUser]  
@UserId varchar(100)
AS
BEGIN
Select b.IdBD, b.Descripcion, b.StringConection from Bases b
inner join DetalleUserBD d on b.IdBD = d.IdBD
where UserId = @UserId
END
GO


--[GetCompaniesForUser] '705e6364-4535-4fcc-8746-a1ade8c66c98'
Select *,b.IdBD, b.Descripcion, b.StringConection from Bases b
inner join DetalleUserBD d on b.IdBD = d.IdBD

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

/****** Object:  StoredProcedure [dbo].[wBases_TT]    Script Date: 07/25/2011 01:37:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[wBases_TT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[wBases_TT]
GO

CREATE PROCEDURE [dbo].[wBases_TT]

@BD varchar(50)=Null

AS

SET @BD=IsNull(@BD,'')

SELECT *
FROM Bases
WHERE Descripcion=@BD
GO

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

/****** Object:  StoredProcedure [dbo].[GetCompaniesUnAssociatedForUser]    Script Date: 07/25/2011 01:37:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCompaniesUnAssociatedForUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCompaniesUnAssociatedForUser]
GO

-------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetCompaniesUnAssociatedForUser]  
@UserId varchar(100)
AS
BEGIN
Select IdBD, Descripcion,StringConection from Bases
where IdBD Not in 
(Select IdBD From DetalleUserBD where UserId = @UserId)
END

GO

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


/****** Object:  StoredProcedure [dbo].[wCuentasGastos_TL]    Script Date: 07/25/2011 01:37:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[wCuentasGastos_TL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[wCuentasGastos_TL]
GO

CREATE Procedure [dbo].[wCuentasGastos_TL]
AS 
SELECT 
 IdCuentaGasto,
 Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS + ' ' + Convert(varchar,Codigo) COLLATE SQL_Latin1_General_CP1_CI_AS as [Titulo]
-- Descripcion as [Titulo]
FROM CuentasGastos
ORDER by Descripcion

GO


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

/****** Object:  StoredProcedure [dbo].[AddUserInCompanies]    Script Date: 07/25/2011 01:37:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddUserInCompanies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddUserInCompanies]
GO


CREATE    PROCEDURE [dbo].[AddUserInCompanies]
@IdUser varchar(100),
@IdCompany int
AS
BEGIN
Insert into DetalleUserBD (UserId,IdBD)
Values (@IdUser,@IdCompany)
END
GO


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


/****** Object:  StoredProcedure [dbo].[wFirmasDocumentos_PorBD]    Script Date: 07/25/2011 01:37:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[wFirmasDocumentos_PorBD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[wFirmasDocumentos_PorBD]
GO

CREATE PROCEDURE [dbo].[wFirmasDocumentos_PorBD]

@BD varchar(50), 
@IdFormulario int, 
@IdComprobante int, 
@OrdenAutorizacion int, 
@Usuario varchar(50)

AS

DECLARE @sql1 varchar(8000), @sql2 varchar(8000), @IdAutorizo int

SET @sql1='
DECLARE @IdAutorizo int
SET @IdAutorizo=IsNull((Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E Where E.UsuarioNT='+''''+@Usuario+''''+'),0)

INSERT INTO '+@BD+'.dbo.AutorizacionesPorComprobante
(IdFormulario, IdComprobante, OrdenAutorizacion, IdAutorizo, FechaAutorizacion)
VALUES
('+Convert(varchar,@IdFormulario)+', '+Convert(varchar,@IdComprobante)+', '+Convert(varchar,@OrdenAutorizacion)+', 
 @IdAutorizo, GetDate())

IF Not EXISTS(Select Top 1 da.OrdenAutorizacion
		From '+@BD+'.dbo.DetalleAutorizaciones da
		Left Outer Join '+@BD+'.dbo.Autorizaciones A On da.IdAutorizacion=A.IdAutorizacion
		Where A.IdFormulario='+Convert(varchar,@IdFormulario)+' and 
			Not Exists(Select Top 1 aut.IdAutorizacionPorComprobante
					From '+@BD+'.dbo.AutorizacionesPorComprobante aut
					Where aut.IdFormulario='+Convert(varchar,@IdFormulario)+' and 
						aut.OrdenAutorizacion=da.OrdenAutorizacion and 
						aut.IdComprobante='+Convert(varchar,@IdComprobante)+'))
    BEGIN
	IF '+Convert(varchar,@IdFormulario)+'=2
		UPDATE '+@BD+'.dbo.Lmateriales SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdLMateriales='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=3
		UPDATE '+@BD+'.dbo.Requerimientos SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdRequerimiento='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=4
		UPDATE '+@BD+'.dbo.Pedidos SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdPedido='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=5
		UPDATE '+@BD+'.dbo.Comparativas SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdComparativa='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=6
		UPDATE '+@BD+'.dbo.AjustesStock SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdAjusteStock='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=7
		UPDATE '+@BD+'.dbo.Presupuestos SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdPresupuesto='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=8
		UPDATE '+@BD+'.dbo.ValesSalida SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdValeSalida='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=9
		UPDATE '+@BD+'.dbo.SalidasMateriales SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdSalidaMateriales='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=10
		UPDATE '+@BD+'.dbo.OtrosIngresosAlmacen SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdOtroIngresoAlmacen='+Convert(varchar,@IdComprobante)+'
	IF '+Convert(varchar,@IdFormulario)+'=11
		UPDATE '+@BD+'.dbo.Recepciones SET CircuitoFirmasCompleto='+''''+'SI'+''''+' WHERE IdRecepcion='+Convert(varchar,@IdComprobante)+'
    END'

EXEC (@sql1)
GO



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


/****** Object:  StoredProcedure [dbo].[wFirmasDocumentos_DocumentosAFirmar]    Script Date: 07/25/2011 01:37:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[wFirmasDocumentos_DocumentosAFirmar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[wFirmasDocumentos_DocumentosAFirmar]
GO



CREATE PROCEDURE [dbo].[wFirmasDocumentos_DocumentosAFirmar]

@Usuario varchar(50)

AS

DECLARE @sql1 varchar(8000), @sql2 varchar(8000), @sql21 varchar(8000), @sql3 varchar(8000), 
	@sql31 varchar(8000), @sql32 varchar(8000), @sql4 varchar(8000), @sql41 varchar(8000), 
	@sql42 varchar(8000), @sql5 varchar(8000), @sql6 varchar(8000), 
	@Firmado bit
SET @Firmado=0

CREATE TABLE #Auxiliar
			(
			 BD VARCHAR(50),
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(2),
			 Numero INTEGER,
			 Fecha DATETIME,
			 Proveedor VARCHAR(50),
			 MontoCompra NUMERIC(18,2),
			 MontoPrevisto NUMERIC(18,2),
			 OrdenAutorizacion INTEGER,
			 Moneda VARCHAR(15),
			 Obra VARCHAR(13),
			 Sector VARCHAR(50),
			 Cliente VARCHAR(50),
			 Cotizacion NUMERIC(18,5),
			 Libero VARCHAR(50)
			)

CREATE TABLE #Auxiliar0 (IdBD INTEGER, BD VARCHAR(50))
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdBD) ON [PRIMARY]
INSERT INTO #Auxiliar0 
 SELECT Det.IdBD, Bases.Descripcion
 FROM DetalleUserBD Det
 LEFT OUTER JOIN aspnet_Users Us ON Det.UserId=Us.UserId
 LEFT OUTER JOIN Bases ON Det.IdBD=Bases.IdBD
 WHERE Us.UserName=@Usuario

--CORREGIR
--CORREGIR
--CORREGIR
--CORREGIR
-- Si la descripcion de la base es distinta al nombre de la base, explota...........
--CORREGIR
--CORREGIR
--CORREGIR
--CORREGIR
--CORREGIR
--CORREGIR

DECLARE @IdBD int, @BD varchar(50)
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR SELECT IdBD, BD FROM #Auxiliar0 ORDER BY BD
OPEN Cur
FETCH NEXT FROM Cur INTO @IdBD, @BD
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @sql1='
	DECLARE @RespetarPrecedencia varchar(2), @SectorEmisorEnPedidos varchar(3)
	SET @RespetarPrecedencia='+''''+'NO'+''''+'
	SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From '+@BD+'.dbo.Parametros2 P2 
						Where P2.Campo='+''''+'SectorEmisorEnPedidos'+''''+'),'+''''+'RM'+''''+')
	CREATE TABLE #Auxiliar1 
				(
				 IdComprobante INTEGER,
				 TipoComprobante VARCHAR(2),
				 Numero INTEGER,
				 IdDetalleAutorizacion INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutoriza INTEGER,
				 IdSector INTEGER,
				 Libero VARCHAR(50),
				 Fecha DATETIME
				)
	INSERT INTO #Auxiliar1 
	SELECT Aco.IdAcopio, '+''''+'AC'+''''+', Aco.NumeroAcopio, DetAut.IdDetalleAutorizacion, DetAut.OrdenAutorizacion,
		CASE 	WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E 
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E 
				Where (Select Top 1 E1.IdSector From '+@BD+'.dbo.Empleados E1 
					Where E1.IdEmpleado=Aco.Aprobo)=E.IdSector and 
					      (DetAut.IdCargoAutoriza1=E.IdCargo  or DetAut.IdCargoAutoriza1=E.IdCargo1 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo2 or DetAut.IdCargoAutoriza1=E.IdCargo3 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo4))
			ELSE Null 
		END,
		CASE 	WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E 
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=Aco.Aprobo)
			ELSE Null 
		END,
		Emp.Nombre, Aco.Fecha
	FROM '+@BD+'.dbo.Acopios Aco

	LEFT OUTER JOIN '+@BD+'.dbo.Autorizaciones A ON A.IdFormulario=1
	LEFT OUTER JOIN '+@BD+'.dbo.DetalleAutorizaciones DetAut ON A.IdAutorizacion=DetAut.IdAutorizacion
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados Emp ON Emp.IdEmpleado=Aco.Aprobo
	WHERE Aco.Aprobo is not null and 
		Not Exists(Select * From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
		(@RespetarPrecedencia<>'+''''+'SI'+''''+' or 
		 (@RespetarPrecedencia='+''''+'SI'+''''+' and 
		  (DetAut.OrdenAutorizacion=1 or 
		   Exists(Select Aut.OrdenAutorizacion From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
	
	SELECT '+''''+@BD+''''+', #Auxiliar1.IdComprobante, #Auxiliar1.TipoComprobante, #Auxiliar1.Numero, 
		#Auxiliar1.Fecha, Null, Null, Aco.MontoPrevisto, #Auxiliar1.OrdenAutorizacion, Null, 
		O.NumeroObra, Null, C.RazonSocial, Null, #Auxiliar1.Libero
	FROM #Auxiliar1
	LEFT OUTER JOIN '+@BD+'.dbo.Acopios Aco ON Aco.IdAcopio=#Auxiliar1.IdComprobante
	LEFT OUTER JOIN '+@BD+'.dbo.Obras O ON O.IdObra=Aco.IdObra
	LEFT OUTER JOIN '+@BD+'.dbo.Clientes C ON C.IdCliente=Aco.IdCliente
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados E ON E.IdEmpleado=#Auxiliar1.IdAutoriza
	WHERE E.UsuarioNT='+''''+@Usuario+''''+'
	
	DROP TABLE #Auxiliar1
	'
	SET @sql2='
	DECLARE @RespetarPrecedencia varchar(2), @SectorEmisorEnPedidos varchar(3)
	SET @RespetarPrecedencia='+''''+'NO'+''''+'
	SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From '+@BD+'.dbo.Parametros2 P2 
						Where P2.Campo='+''''+'SectorEmisorEnPedidos'+''''+'),'+''''+'RM'+''''+')
	CREATE TABLE #Auxiliar1 
				(
				 IdComprobante INTEGER,
				 TipoComprobante VARCHAR(2),
				 Numero INTEGER,
				 IdDetalleAutorizacion INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutoriza INTEGER,
				 IdSector INTEGER,
				 Libero VARCHAR(50),
				 Fecha DATETIME
				)
	INSERT INTO #Auxiliar1 
	SELECT LMat.IdLMateriales, '+''''+'LM'+''''+', LMat.NumeroLMateriales, DetAut.IdDetalleAutorizacion, DetAut.OrdenAutorizacion,
		CASE 	WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (Select Top 1 Emp1.IdSector From '+@BD+'.dbo.Empleados Emp1
					Where Emp1.IdEmpleado=LMat.Aprobo)=E.IdSector and 
					      (DetAut.IdCargoAutoriza1=E.IdCargo  or DetAut.IdCargoAutoriza1=E.IdCargo1 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo2 or DetAut.IdCargoAutoriza1=E.IdCargo3 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo4))
			ELSE Null 
		END,
		CASE 	WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=LMat.Aprobo)
			ELSE Null 
		END,
		Emp.Nombre, LMat.Fecha
	'
	SET @sql21='
	FROM '+@BD+'.dbo.LMateriales LMat
	LEFT OUTER JOIN '+@BD+'.dbo.Autorizaciones A ON A.IdFormulario=2
	LEFT OUTER JOIN '+@BD+'.dbo.DetalleAutorizaciones DetAut ON A.IdAutorizacion=DetAut.IdAutorizacion
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados Emp ON Emp.IdEmpleado=LMat.Aprobo
	WHERE LMat.Aprobo is not null and IsNull(LMat.CircuitoFirmasCompleto,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and 
		Not Exists(Select * From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
		(@RespetarPrecedencia<>'+''''+'SI'+''''+' or 
		 (@RespetarPrecedencia='+''''+'SI'+''''+' and 
		  (DetAut.OrdenAutorizacion=1 or 
		   Exists(Select Aut.OrdenAutorizacion From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
	
	SELECT '+''''+@BD+''''+', #Auxiliar1.IdComprobante, #Auxiliar1.TipoComprobante, #Auxiliar1.Numero, 
		#Auxiliar1.Fecha, Null, Null, Null, #Auxiliar1.OrdenAutorizacion, Null, 
		O.NumeroObra, Null, C.RazonSocial, Null, #Auxiliar1.Libero
	FROM #Auxiliar1
	LEFT OUTER JOIN '+@BD+'.dbo.LMateriales LMat ON LMat.IdLMateriales=#Auxiliar1.IdComprobante
	LEFT OUTER JOIN '+@BD+'.dbo.Obras O ON O.IdObra=LMat.IdObra
	LEFT OUTER JOIN '+@BD+'.dbo.Clientes C ON C.IdCliente=LMat.IdCliente
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados E ON E.IdEmpleado=#Auxiliar1.IdAutoriza
	WHERE E.UsuarioNT='+''''+@Usuario+''''+'

	DROP TABLE #Auxiliar1
	'
	SET @sql3='
	DECLARE @RespetarPrecedencia varchar(2), @SectorEmisorEnPedidos varchar(3)
	SET @RespetarPrecedencia='+''''+'NO'+''''+'
	SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From '+@BD+'.dbo.Parametros2 P2 
						Where P2.Campo='+''''+'SectorEmisorEnPedidos'+''''+'),'+''''+'RM'+''''+')
	CREATE TABLE #Auxiliar1 
				(
				 IdComprobante INTEGER,
				 TipoComprobante VARCHAR(2),
				 Numero INTEGER,
				 IdDetalleAutorizacion INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutoriza INTEGER,
				 IdSector INTEGER,
				 Libero VARCHAR(50),
				 Fecha DATETIME
				)
	INSERT INTO #Auxiliar1 
	SELECT Req.IdRequerimiento, '+''''+'RM'+''''+', Req.NumeroRequerimiento, DetAut.IdDetalleAutorizacion, DetAut.OrdenAutorizacion,
		CASE 	WHEN DetAut.SectorEmisor1='+''''+'O'+''''+' 
			 THEN CASE WHEN NOT O.TipoObra is null 
					THEN 	CASE WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN O.IdJefeRegional
							WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN O.IdJefe
							WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN O.IdSubJefe
							ELSE O.IdJefe
						END
					ELSE 	CASE WHEN DetAut.SectorEmisor2='+''''+'N'+''''+' 
							THEN (Select Top 1 E.IdEmpleado	From '+@BD+'.dbo.Empleados E
								Where (DetAut.IdSectorAutoriza2=E.IdSector  and DetAut.IdCargoAutoriza2=E.IdCargo ) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector1 and DetAut.IdCargoAutoriza2=E.IdCargo1) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector2 and DetAut.IdCargoAutoriza2=E.IdCargo2) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector3 and DetAut.IdCargoAutoriza2=E.IdCargo3) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector4 and DetAut.IdCargoAutoriza2=E.IdCargo4))
							WHEN DetAut.SectorEmisor2='+''''+'S'+''''+' 
							 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
								Where (Req.IdSector=E.IdSector  and DetAut.IdCargoAutoriza2=E.IdCargo ) or 
								      (Req.IdSector=E.IdSector1 and DetAut.IdCargoAutoriza2=E.IdCargo1) or 
								      (Req.IdSector=E.IdSector2 and DetAut.IdCargoAutoriza2=E.IdCargo2) or 
								      (Req.IdSector=E.IdSector3 and DetAut.IdCargoAutoriza2=E.IdCargo3) or 
								      (Req.IdSector=E.IdSector4 and DetAut.IdCargoAutoriza2=E.IdCargo4))
							ELSE Null 
						END
				END
			WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (Req.IdSector=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (Req.IdSector=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (Req.IdSector=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (Req.IdSector=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (Req.IdSector=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
				      
			When DetAut.SectorEmisor1='+''''+'F'+''''+'  Then DetAut.IdFirmante1	      
				      
				      
			ELSE Null 
		END,
	'
	SET @sql31='
		CASE WHEN DetAut.SectorEmisor1='+''''+'O'+''''+' 
			THEN 	CASE WHEN NOT O.TipoObra is null 
					THEN 	CASE WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=O.IdJefeRegional)
							WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=O.IdJefe)
							WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=O.IdSubJefe)
							ELSE (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=O.IdJefe)
						END
					ELSE 	CASE WHEN DetAut.SectorEmisor2='+''''+'N'+''''+' 
							THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E
								Where (DetAut.IdSectorAutoriza2=E.IdSector  and DetAut.IdCargoAutoriza2=E.IdCargo ) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector1 and DetAut.IdCargoAutoriza2=E.IdCargo1) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector2 and DetAut.IdCargoAutoriza2=E.IdCargo2) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector3 and DetAut.IdCargoAutoriza2=E.IdCargo3) or 
								      (DetAut.IdSectorAutoriza2=E.IdSector4 and DetAut.IdCargoAutoriza2=E.IdCargo4))
							WHEN DetAut.SectorEmisor2='+''''+'S'+''''+' THEN Req.IdSector
							ELSE Null 
						END
				END
			WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' THEN Req.IdSector
			
			WHEN DetAut.SectorEmisor1='+''''+'F'+''''+'  Then 
				(Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=DetAut.IdFirmante1)

			ELSE Null 
			
		END,
		Emp.Nombre, Req.FechaRequerimiento
	'
	SET @sql32='
	FROM '+@BD+'.dbo.Requerimientos Req
	LEFT OUTER JOIN '+@BD+'.dbo.Obras O ON Req.IdObra=O.IdObra
	LEFT OUTER JOIN '+@BD+'.dbo.Autorizaciones A ON A.IdFormulario=3
	LEFT OUTER JOIN '+@BD+'.dbo.DetalleAutorizaciones DetAut ON A.IdAutorizacion=DetAut.IdAutorizacion
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados Emp ON Emp.IdEmpleado=Req.Aprobo
	WHERE Req.Aprobo is not null and IsNull(Req.CircuitoFirmasCompleto,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and 
		(Req.Cumplido is null or Req.Cumplido='+''''+'NO'+''''+') and 
		Not Exists(Select * From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
		(@RespetarPrecedencia<>'+''''+'SI'+''''+' or 
		 (@RespetarPrecedencia='+''''+'SI'+''''+' and 
		  (DetAut.OrdenAutorizacion=1 or 
		   Exists(Select Aut.OrdenAutorizacion From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
	
	SELECT '+''''+@BD+''''+', #Auxiliar1.IdComprobante, #Auxiliar1.TipoComprobante, #Auxiliar1.Numero, 
		#Auxiliar1.Fecha, Null, Req.MontoParaCompra, Req.MontoPrevisto, #Auxiliar1.OrdenAutorizacion, Null, 
		O.NumeroObra, S.Descripcion, C.RazonSocial, Null, #Auxiliar1.Libero
	FROM #Auxiliar1
	LEFT OUTER JOIN '+@BD+'.dbo.Requerimientos Req ON Req.IdRequerimiento=#Auxiliar1.IdComprobante
	LEFT OUTER JOIN '+@BD+'.dbo.Obras O ON O.IdObra=Req.IdObra
	LEFT OUTER JOIN '+@BD+'.dbo.Sectores S ON S.IdSector=Req.IdSector
	LEFT OUTER JOIN '+@BD+'.dbo.Clientes C ON C.IdCliente=O.IdCliente
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados E ON E.IdEmpleado=#Auxiliar1.IdAutoriza
	WHERE E.UsuarioNT='+''''+@Usuario+''''+'
	
	DROP TABLE #Auxiliar1
	'
	SET @sql4='
	DECLARE @RespetarPrecedencia varchar(2), @SectorEmisorEnPedidos varchar(3)
	SET @RespetarPrecedencia='+''''+'NO'+''''+'
	SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From '+@BD+'.dbo.Parametros2 P2 
						Where P2.Campo='+''''+'SectorEmisorEnPedidos'+''''+'),'+''''+'RM'+''''+')
	CREATE TABLE #Auxiliar1 
				(
				 IdComprobante INTEGER,
				 TipoComprobante VARCHAR(2),
				 Numero INTEGER,
				 IdDetalleAutorizacion INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutoriza INTEGER,
				 IdSector INTEGER,
				 Libero VARCHAR(50),
				 Fecha DATETIME
				)
	INSERT INTO #Auxiliar1 
	SELECT Ped.IdPedido, '+''''+'PE'+''''+', Ped.NumeroPedido, DetAut.IdDetalleAutorizacion, DetAut.OrdenAutorizacion,
		CASE WHEN DetAut.SectorEmisor1='+''''+'O'+''''+' and 
			IsNull(DetAut.ImporteDesde1,0)<=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) 
			 THEN 	CASE WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN O.IdJefeRegional
					WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN O.IdJefe
					WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN O.IdSubJefe
					ELSE O.IdJefe
				END
			WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' and @SectorEmisorEnPedidos='+''''+'LIB'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (Select Top 1 Emp1.IdSector From '+@BD+'.dbo.Empleados Emp1
					Where Emp1.IdEmpleado=Ped.Aprobo)=E.IdSector and 
					      (DetAut.IdCargoAutoriza1=E.IdCargo  or DetAut.IdCargoAutoriza1=E.IdCargo1 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo2 or DetAut.IdCargoAutoriza1=E.IdCargo3 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' and @SectorEmisorEnPedidos='+''''+'RM'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (Select Top 1 R.IdSector From '+@BD+'.dbo.Requerimientos R 
					Where R.IdRequerimiento=
						(Select Top 1 DR.IdRequerimiento From '+@BD+'.dbo.DetalleRequerimientos DR 
						 Where DR.IdDetalleRequerimiento=
							(Select Top 1 DP.IdDetalleRequerimiento
							 From '+@BD+'.dbo.DetallePedidos DP 
							 Where DP.IdPedido=Ped.IdPedido and 
								DP.IdDetalleRequerimiento is not null)))=E.IdSector and 
					      (DetAut.IdCargoAutoriza1=E.IdCargo  or DetAut.IdCargoAutoriza1=E.IdCargo1 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo2 or DetAut.IdCargoAutoriza1=E.IdCargo3 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo4) )
			WHEN DetAut.SectorEmisor1='+''''+'F'+''''+' and 
				IsNull(DetAut.ImporteDesde1,0)<=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) and 
				IsNull(DetAut.ImporteHasta1,0)>=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) 
			 THEN DetAut.IdFirmante1
			ELSE Null 
		END,
	'
	SET @sql41='
		CASE WHEN DetAut.SectorEmisor1='+''''+'O'+''''+' and 
			IsNull(DetAut.ImporteDesde1,0)<=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) 
			 THEN 	CASE WHEN IsNull(DetAut.PersonalObra1,-1)=0 THEN (Select Top 1 Emp.IdSector From '+@BD+'.dbo.Empleados Emp Where Emp.IdEmpleado=O.IdJefeRegional)
					WHEN IsNull(DetAut.PersonalObra1,-1)=1 THEN (Select Top 1 Emp.IdSector From '+@BD+'.dbo.Empleados Emp Where Emp.IdEmpleado=O.IdJefe)
					WHEN IsNull(DetAut.PersonalObra1,-1)=2 THEN (Select Top 1 Emp.IdSector From '+@BD+'.dbo.Empleados Emp Where Emp.IdEmpleado=O.IdSubJefe)
					ELSE (Select Top 1 Emp.IdSector From '+@BD+'.dbo.Empleados Emp Where Emp.IdEmpleado=O.IdJefe)
				END
			WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' and @SectorEmisorEnPedidos='+''''+'LIB'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=Ped.Aprobo )
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' and @SectorEmisorEnPedidos='+''''+'RM'+''''+' 
			 THEN (Select Top 1 R.IdSector From '+@BD+'.dbo.Requerimientos R 
				Where R.IdRequerimiento=
					(Select Top 1 DR.IdRequerimiento From '+@BD+'.dbo.DetalleRequerimientos DR 
					 Where DR.IdDetalleRequerimiento=
						(Select Top 1 DP.IdDetalleRequerimiento From '+@BD+'.dbo.DetallePedidos DP 
						 Where DP.IdPedido=Ped.IdPedido and DP.IdDetalleRequerimiento is not null)))
			WHEN DetAut.SectorEmisor1='+''''+'F'+''''+' and 
				IsNull(DetAut.ImporteDesde1,0)<=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) and 
				IsNull(DetAut.ImporteHasta1,0)>=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=DetAut.IdFirmante1)
			ELSE Null 
		END,
		Emp.Nombre, Ped.FechaPedido
	FROM '+@BD+'.dbo.Pedidos Ped
	LEFT OUTER JOIN '+@BD+'.dbo.Autorizaciones A ON A.IdFormulario=4
	LEFT OUTER JOIN '+@BD+'.dbo.DetalleAutorizaciones DetAut ON A.IdAutorizacion=DetAut.IdAutorizacion
	LEFT OUTER JOIN '+@BD+'.dbo.Obras O ON O.IdObra=(Select Top 1 R.IdObra From '+@BD+'.dbo.Requerimientos R 
							 Where R.IdRequerimiento=
								(Select Top 1 DR.IdRequerimiento 
								 From '+@BD+'.dbo.DetalleRequerimientos DR 
								 Where DR.IdDetalleRequerimiento=
									(Select Top 1 DP.IdDetalleRequerimiento
									 From '+@BD+'.dbo.DetallePedidos DP 
									 Where DP.IdPedido=Ped.IdPedido and 
										DP.IdDetalleRequerimiento is not null)))
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados Emp ON Emp.IdEmpleado=Ped.Aprobo
	'
	SET @sql42='
	WHERE Ped.Aprobo is not null and IsNull(Ped.CircuitoFirmasCompleto,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and 
		(Ped.Cumplido is null or Ped.Cumplido<>'+''''+'AN'+''''+') and 
		Not Exists(Select * From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 

		(Patindex('+''''+'%'+''''+'+DetAut.SectorEmisor1+'+''''+'%'+''''+', '+''''+'F S'+''''+')=0 or 
		 (Patindex('+''''+'%'+''''+'+DetAut.SectorEmisor1+'+''''+'%'+''''+', '+''''+'F S'+''''+')<>0 and 
			IsNull(DetAut.ImporteDesde1,0)<=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=Ped.TotalPedido*IsNull(Ped.CotizacionMoneda,1))) and 
		(@RespetarPrecedencia<>'+''''+'SI'+''''+' or 
		 (@RespetarPrecedencia='+''''+'SI'+''''+' and 
		  (DetAut.OrdenAutorizacion=1 or 
		   Exists(Select Aut.OrdenAutorizacion From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
	
	SELECT '+''''+@BD+''''+', #Auxiliar1.IdComprobante, #Auxiliar1.TipoComprobante, #Auxiliar1.Numero, 
		#Auxiliar1.Fecha, P.RazonSocial, Ped.TotalPedido, Null, #Auxiliar1.OrdenAutorizacion, 
		M.Abreviatura, Null, Null, Null, Null, #Auxiliar1.Libero
	FROM #Auxiliar1
	LEFT OUTER JOIN '+@BD+'.dbo.Pedidos Ped ON Ped.IdPedido=#Auxiliar1.IdComprobante
	LEFT OUTER JOIN '+@BD+'.dbo.Proveedores P ON P.IdProveedor=Ped.IdProveedor
	LEFT OUTER JOIN '+@BD+'.dbo.Monedas M ON M.IdMoneda=Ped.IdMoneda
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados E ON E.IdEmpleado=#Auxiliar1.IdAutoriza
	WHERE E.UsuarioNT='+''''+@Usuario+''''+'
	
	DROP TABLE #Auxiliar1
	'
	SET @sql5='
	DECLARE @RespetarPrecedencia varchar(2), @SectorEmisorEnPedidos varchar(3)
	SET @RespetarPrecedencia='+''''+'NO'+''''+'
	SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From '+@BD+'.dbo.Parametros2 P2 
						Where P2.Campo='+''''+'SectorEmisorEnPedidos'+''''+'),'+''''+'RM'+''''+')
	CREATE TABLE #Auxiliar1 
				(
				 IdComprobante INTEGER,
				 TipoComprobante VARCHAR(2),
				 Numero INTEGER,
				 IdDetalleAutorizacion INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutoriza INTEGER,
				 IdSector INTEGER,
				 Libero VARCHAR(50),
				 Fecha DATETIME
				)
	INSERT INTO #Auxiliar1 
	SELECT Comp.IdComparativa, '+''''+'CO'+''''+', Comp.Numero, DetAut.IdDetalleAutorizacion, DetAut.OrdenAutorizacion,
		CASE WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (Select Top 1 Emp1.IdSector From '+@BD+'.dbo.Empleados Emp1
					Where Emp1.IdEmpleado=Comp.IdAprobo)=E.IdSector and 
					      (DetAut.IdCargoAutoriza1=E.IdCargo  or DetAut.IdCargoAutoriza1=E.IdCargo1 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo2 or DetAut.IdCargoAutoriza1=E.IdCargo3 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo4))
			ELSE Null 
		END,
		CASE WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=Comp.IdAprobo)
			ELSE Null 
		END,
		Emp.Nombre, Comp.Fecha
	FROM '+@BD+'.dbo.Comparativas Comp
	LEFT OUTER JOIN '+@BD+'.dbo.Autorizaciones A ON A.IdFormulario=5
	LEFT OUTER JOIN '+@BD+'.dbo.DetalleAutorizaciones DetAut ON A.IdAutorizacion=DetAut.IdAutorizacion
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados Emp ON Emp.IdEmpleado=Comp.IdAprobo
	WHERE Comp.IdAprobo is not null and IsNull(Comp.CircuitoFirmasCompleto,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and 
		Not Exists(Select * From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=5 and Aut.IdComprobante=Comp.IdComparativa and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
		(@RespetarPrecedencia<>'+''''+'SI'+''''+' or 
		 (@RespetarPrecedencia='+''''+'SI'+''''+' and 
		  (DetAut.OrdenAutorizacion=1 or 
		   Exists(Select Aut.OrdenAutorizacion From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=5 and Aut.IdComprobante=Comp.IdComparativa and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
	
	SELECT '+''''+@BD+''''+', #Auxiliar1.IdComprobante, #Auxiliar1.TipoComprobante, #Auxiliar1.Numero, 
		#Auxiliar1.Fecha, Null, Null, Null, #Auxiliar1.OrdenAutorizacion, 
		Null, Null, Null, Null, Null, #Auxiliar1.Libero
	FROM #Auxiliar1
	LEFT OUTER JOIN '+@BD+'.dbo.Comparativas Comp ON Comp.IdComparativa=#Auxiliar1.IdComprobante
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados E ON E.IdEmpleado=#Auxiliar1.IdAutoriza
	WHERE E.UsuarioNT='+''''+@Usuario+''''+'
	
	DROP TABLE #Auxiliar1
	'
	SET @sql6='
	DECLARE @RespetarPrecedencia varchar(2), @SectorEmisorEnPedidos varchar(3)
	SET @RespetarPrecedencia='+''''+'NO'+''''+'
	SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From '+@BD+'.dbo.Parametros2 P2 
						Where P2.Campo='+''''+'SectorEmisorEnPedidos'+''''+'),'+''''+'RM'+''''+')
	CREATE TABLE #Auxiliar1 
				(
				 IdComprobante INTEGER,
				 TipoComprobante VARCHAR(2),
				 Numero INTEGER,
				 IdDetalleAutorizacion INTEGER,
				 OrdenAutorizacion INTEGER,
				 IdAutoriza INTEGER,
				 IdSector INTEGER,
				 Libero VARCHAR(50),
				 Fecha DATETIME
				)
	INSERT INTO #Auxiliar1 
	SELECT Aju.IdAjusteStock, '+''''+'AJ'+''''+', Aju.NumeroAjusteStock, DetAut.IdDetalleAutorizacion, DetAut.OrdenAutorizacion,
		CASE WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdEmpleado From '+@BD+'.dbo.Empleados E
				Where (Select Top 1 Emp1.IdSector From '+@BD+'.dbo.Empleados Emp1
					Where Emp1.IdEmpleado=Aju.IdAprobo)=E.IdSector and 
					      (DetAut.IdCargoAutoriza1=E.IdCargo  or DetAut.IdCargoAutoriza1=E.IdCargo1 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo2 or DetAut.IdCargoAutoriza1=E.IdCargo3 or 
					       DetAut.IdCargoAutoriza1=E.IdCargo4))
			ELSE Null 
		END,
		CASE WHEN DetAut.SectorEmisor1='+''''+'N'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E
				Where (DetAut.IdSectorAutoriza1=E.IdSector  and DetAut.IdCargoAutoriza1=E.IdCargo ) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector1 and DetAut.IdCargoAutoriza1=E.IdCargo1) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector2 and DetAut.IdCargoAutoriza1=E.IdCargo2) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector3 and DetAut.IdCargoAutoriza1=E.IdCargo3) or 
				      (DetAut.IdSectorAutoriza1=E.IdSector4 and DetAut.IdCargoAutoriza1=E.IdCargo4))
			WHEN DetAut.SectorEmisor1='+''''+'S'+''''+' 
			 THEN (Select Top 1 E.IdSector From '+@BD+'.dbo.Empleados E Where E.IdEmpleado=Aju.IdAprobo)
			ELSE Null 
		END,
		Emp.Nombre, Aju.FechaAjuste
	FROM '+@BD+'.dbo.AjustesStock Aju
	LEFT OUTER JOIN '+@BD+'.dbo.Autorizaciones A ON A.IdFormulario=6
	LEFT OUTER JOIN '+@BD+'.dbo.DetalleAutorizaciones DetAut ON A.IdAutorizacion=DetAut.IdAutorizacion
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados Emp ON Emp.IdEmpleado=Aju.IdAprobo
	WHERE Aju.IdAprobo is not null and IsNull(Aju.CircuitoFirmasCompleto,'+''''+'NO'+''''+')<>'+''''+'SI'+''''+' and 
		Not Exists(Select * From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
		(@RespetarPrecedencia<>'+''''+'SI'+''''+' or 
		 (@RespetarPrecedencia='+''''+'SI'+''''+' and 
		  (DetAut.OrdenAutorizacion=1 or 
		   Exists(Select Aut.OrdenAutorizacion From '+@BD+'.dbo.AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and 
					Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
	
	SELECT '+''''+@BD+''''+', #Auxiliar1.IdComprobante, #Auxiliar1.TipoComprobante, #Auxiliar1.Numero, 
		#Auxiliar1.Fecha, Null, Null, Null, #Auxiliar1.OrdenAutorizacion, 
		Null, Null, Null, Null, Null, #Auxiliar1.Libero
	FROM #Auxiliar1
	LEFT OUTER JOIN '+@BD+'.dbo.AjustesStock Aju ON Aju.IdAjusteStock=#Auxiliar1.IdComprobante
	LEFT OUTER JOIN '+@BD+'.dbo.Empleados E ON E.IdEmpleado=#Auxiliar1.IdAutoriza
	WHERE E.UsuarioNT='+''''+@Usuario+''''+'
	
	DROP TABLE #Auxiliar1
	'

	--print @sql1 --acopios
	--print @sql2+@sql21 --lista materiales
	print @sql3+@sql31+@sql32 --requerimientos
	

	INSERT INTO #Auxiliar EXEC (@sql1) 
	INSERT INTO #Auxiliar EXEC (@sql2+@sql21)
	INSERT INTO #Auxiliar EXEC (@sql3+@sql31+@sql32)
	INSERT INTO #Auxiliar EXEC (@sql4+@sql41+@sql42)
	INSERT INTO #Auxiliar EXEC (@sql5)
	INSERT INTO #Auxiliar EXEC (@sql6)

	FETCH NEXT FROM Cur INTO @IdBD, @BD
   END
CLOSE Cur
DEALLOCATE Cur

SELECT 
 @Firmado as [Firma],
 BD,
 TipoComprobante as [Tipo],
 Numero,
 Fecha,
 Proveedor,
 MontoCompra as [Monto compra],
 MontoPrevisto as [Monto previsto],
 OrdenAutorizacion as [Orden],
 Moneda as [Mon.],
 Obra,
 Sector,
 Cliente,
 Cotizacion,
 Libero,
 IdComprobante,
 Case When TipoComprobante='AC' Then 1
	When TipoComprobante='LM' Then 2
	When TipoComprobante='RM' Then 3
	When TipoComprobante='PE' Then 4
	When TipoComprobante='CO' Then 5
	When TipoComprobante='AJ' Then 6
	Else 0
 End as [IdFormulario]
FROM #Auxiliar
ORDER BY  BD, TipoComprobante, Fecha, Numero, OrdenAutorizacion

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar0
GO


-- select * from bases
-- select * from wdemoesuco.dbo.empleados
-- [wFirmasDocumentos_DocumentosAFirmar]  'administrador'
-- [wFirmasDocumentos_DocumentosAFirmar]  'jmaquieira'
-- wFirmasDocumentos_PorBD] 'wDemoEsuco',4,229780,1,  'jmaquieira'
-- exec wFirmasDocumentos_DocumentosAFirmar @Usuario=N'administrador'
-- exec wFirmasDocumentos_DocumentosAFirmar @Usuario=N'Andres'
-- exec wFirmasDocumentos_DocumentosAFirmar @Usuario=N'gtejerina'
-- exec wFirmasDocumentos_DocumentosAFirmar @Usuario=N'jmontagut'
-- exec wFirmasDocumentos_DocumentosAFirmar @Usuario=N'MGutterman'
/*
 SELECT Det.IdBD, Bases.Descripcion
 FROM DetalleUserBD Det
 LEFT OUTER JOIN aspnet_Users Us ON Det.UserId=Us.UserId
 LEFT OUTER JOIN Bases ON Det.IdBD=Bases.IdBD
 WHERE Us.UserName='Andres'
*/




--[wResetearPass] 'Mariano','pirulo!'


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[wResetearPass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[wResetearPass]
GO

CREATE PROCEDURE [dbo].[wResetearPass]

@UserName varchar(256),
@Password varchar(128)
        --@Application varchar(256),
        --@PasswordSalt varchar(128)
AS

--http://team.desarrollosnea.com.ar/blogs/jfernandez/archive/2009/12/10/asp-net-membership-reset-password-with-ts-sql-por-si-las-moscas-tenerlo-a-mano.aspx


--SET @UserName = 'yoda'
--SET @Password = 'theforceiswithyou'
declare @Application varchar(256)
declare @PasswordSalt varchar(128)
SET @Application = '/'
SET @PasswordSalt = (SELECT 1 PasswordSalt
                            FROM aspnet_Membership
                            WHERE UserID IN (SELECT UserID
                                                    FROM aspnet_Users U
                                                        INNER JOIN aspnet_Applications A
                                                            ON U.ApplicationId = A.ApplicationId 
                                                    WHERE 
                                                        (U.UserName = @UserName) 
                                                        AND (A.ApplicationName = @Application)))

--que aproveche para desbloquear

exec aspnet_Membership_UnlockUser  @Application, @UserName

EXEC dbo.aspnet_Membership_ResetPassword 
        @Application, 
        @UserName, 
        @Password, 
        10, 
        10, 
        @PasswordSalt, 
        -5

GO

