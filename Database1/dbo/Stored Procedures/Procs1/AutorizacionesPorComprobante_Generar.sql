CREATE Procedure [dbo].[AutorizacionesPorComprobante_Generar]

@RespetarPrecedencia varchar(2) = Null

AS

SET NOCOUNT ON

SET @RespetarPrecedencia=IsNull(@RespetarPrecedencia,'SI')

DECLARE @SectorEmisorEnPedidos varchar(3), @FirmantesPorRubro varchar(2), @FirmantesPorRubroRango varchar(2), @IdEmpleadoSinFirma int

SET @SectorEmisorEnPedidos=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='SectorEmisorEnPedidos'),'RM')
SET @IdEmpleadoSinFirma=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='IdEmpleadoSinFirma'),0)

CREATE TABLE #Auxiliar1 (IdComprobanteProveedor INTEGER, IdObra INTEGER)
IF Exists(Select Top 1 Autorizaciones.IdFormulario From DetalleAutorizaciones da 
		Left Outer Join Autorizaciones On Autorizaciones.IdAutorizacion=da.IdAutorizacion
		Where Autorizaciones.IdFormulario=31)
	INSERT INTO #Auxiliar1
	 SELECT DISTINCT dcp.IdComprobanteProveedor, dcp.IdObra
	 FROM DetalleComprobantesProveedores dcp
	 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor
	 WHERE IsNull(cp.CircuitoFirmasCompleto,'NO')<>'SI' and IsNull(dcp.IdObra,0)<>0

SET @FirmantesPorRubro=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Modelo de firmas de documentos por firmante rubro' and IsNull(ProntoIni.Valor,'')='SI'),'')
CREATE TABLE #Auxiliar2 (IdComprobante INTEGER, IdFormulario INTEGER, OrdenAutorizacion INTEGER, IdFirmante INTEGER)
CREATE TABLE #Auxiliar3 (IdComprobante INTEGER, IdFormulario INTEGER, OrdenAutorizacion INTEGER, IdFirmante INTEGER)

SET @FirmantesPorRubroRango=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Modelo de firmas de documentos por firmante entre importes por rubro' and IsNull(ProntoIni.Valor,'')='SI'),'')
CREATE TABLE #Auxiliar5 (IdComprobante INTEGER, IdRubro INTEGER, ImporteItem NUMERIC(18,2))
CREATE TABLE #Auxiliar6 (IdComprobante INTEGER, IdFormulario INTEGER, OrdenAutorizacion INTEGER, IdFirmante INTEGER, ImporteItem NUMERIC(18,2))
CREATE TABLE #Auxiliar7 (IdComprobante INTEGER, IdFormulario INTEGER, OrdenAutorizacion INTEGER, IdFirmante INTEGER)
CREATE TABLE #Auxiliar8 (IdComprobante INTEGER, IdFormulario INTEGER, OrdenAutorizacion INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar8 ON #Auxiliar8 (IdComprobante, IdFormulario) ON [PRIMARY]

IF @FirmantesPorRubro='SI'
    BEGIN
	INSERT INTO #Auxiliar2
	 SELECT r.IdRequerimiento, a.IdFormulario, da.OrdenAutorizacion, daf.IdFirmante
	 FROM DetalleRequerimientos dr
	 LEFT OUTER JOIN Requerimientos r ON r.IdRequerimiento=dr.IdRequerimiento
	 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dr.IdArticulo
	 LEFT OUTER JOIN DetalleAutorizacionesFirmantes daf ON daf.IdRubro=Articulos.IdRubro and daf.IdSubrubro=Articulos.IdSubrubro and IsNull(daf.ParaTaller,'')=IsNull(r.ParaTaller,'')
	 LEFT OUTER JOIN DetalleAutorizaciones da ON da.IdDetalleAutorizacion=daf.IdDetalleAutorizacion
	 LEFT OUTER JOIN Autorizaciones a ON a.IdAutorizacion=daf.IdAutorizacion
	 WHERE r.Aprobo is not null and IsNull(r.CircuitoFirmasCompleto,'NO')<>'SI' and IsNull(r.Cumplido,'NO')='NO' and a.IdFormulario=3 and daf.IdFirmante is not null

	INSERT INTO #Auxiliar2
	 SELECT p.IdPedido, a.IdFormulario, da.OrdenAutorizacion, daf.IdFirmante
	 FROM DetallePedidos dp
	 LEFT OUTER JOIN Pedidos p ON p.IdPedido=dp.IdPedido
	 LEFT OUTER JOIN DetalleRequerimientos dr ON dr.IdDetalleRequerimiento=dp.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos r ON r.IdRequerimiento=dr.IdRequerimiento
	 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dp.IdArticulo
	 LEFT OUTER JOIN DetalleAutorizacionesFirmantes daf ON daf.IdRubro=Articulos.IdRubro and daf.IdSubrubro=Articulos.IdSubrubro and IsNull(daf.ParaTaller,'')=IsNull(r.ParaTaller,'')
	 LEFT OUTER JOIN DetalleAutorizaciones da ON da.IdDetalleAutorizacion=daf.IdDetalleAutorizacion
	 LEFT OUTER JOIN Autorizaciones a ON a.IdAutorizacion=daf.IdAutorizacion
	 WHERE p.Aprobo is not null and IsNull(p.CircuitoFirmasCompleto,'NO')<>'SI' and (p.Cumplido is null or p.Cumplido<>'AN') and a.IdFormulario=4 and daf.IdFirmante is not null

	INSERT INTO #Auxiliar3
	 SELECT #Auxiliar2.IdComprobante, #Auxiliar2.IdFormulario, #Auxiliar2.OrdenAutorizacion, Max(#Auxiliar2.IdFirmante)
	 FROM #Auxiliar2
	 GROUP BY #Auxiliar2.IdComprobante, #Auxiliar2.IdFormulario, #Auxiliar2.OrdenAutorizacion
    END
ELSE
	IF @FirmantesPorRubroRango='SI'
	    BEGIN
		INSERT INTO #Auxiliar5
		 SELECT p.IdPedido, Articulos.IdRubro, Sum(((dp.Cantidad*dp.Precio)-IsNull(dp.ImporteBonificacion,0))*IsNull(p.CotizacionMoneda,1))
		 FROM DetallePedidos dp
		 LEFT OUTER JOIN Pedidos p ON p.IdPedido=dp.IdPedido
		 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dp.IdArticulo
		 WHERE p.Aprobo is not null and IsNull(p.CircuitoFirmasCompleto,'NO')<>'SI' and (p.Cumplido is null or p.Cumplido<>'AN') 
		 GROUP BY p.IdPedido, Articulos.IdRubro

		INSERT INTO #Auxiliar6
		 SELECT #Auxiliar5.IdComprobante, a.IdFormulario, da.OrdenAutorizacion, daf.IdFirmante, #Auxiliar5.ImporteItem
		 FROM #Auxiliar5
		 LEFT OUTER JOIN DetalleAutorizacionesFirmantes daf ON daf.IdRubro=#Auxiliar5.IdRubro and IsNull(daf.ImporteDesde,0)<=#Auxiliar5.ImporteItem and IsNull(daf.ImporteHasta,0)>=#Auxiliar5.ImporteItem
		 LEFT OUTER JOIN DetalleAutorizaciones da ON da.IdDetalleAutorizacion=daf.IdDetalleAutorizacion
		 LEFT OUTER JOIN Autorizaciones a ON a.IdAutorizacion=daf.IdAutorizacion
		 WHERE a.IdFormulario=4 and daf.IdFirmante is not null 

		INSERT INTO #Auxiliar7
		 SELECT DISTINCT IdComprobante, IdFormulario, OrdenAutorizacion, Null
		 FROM #Auxiliar6
		 GROUP BY IdComprobante, IdFormulario, OrdenAutorizacion

		UPDATE #Auxiliar7
		SET IdFirmante=(Select Top 1 #Auxiliar6.IdFirmante From #Auxiliar6 
				Where #Auxiliar6.IdComprobante=#Auxiliar7.IdComprobante and #Auxiliar6.IdFormulario=#Auxiliar7.IdFormulario and #Auxiliar6.OrdenAutorizacion=#Auxiliar7.OrdenAutorizacion
				Order By #Auxiliar6.IdComprobante, #Auxiliar6.IdFormulario,  #Auxiliar6.OrdenAutorizacion,  #Auxiliar6.ImporteItem Desc)
	    END


UPDATE Comparativas
SET ImporteComparativaCalculado=(Select Sum(IsNull(dc.Cantidad,0)*IsNull(dc.Precio,0)*IsNull(dc.CotizacionMoneda,1))
				 From DetalleComparativas dc Where dc.IdComparativa=Comparativas.IdComparativa and 
					(IsNull(dc.Estado,'')='MR' or (dc.NumeroPresupuesto=Comparativas.PresupuestoSeleccionado and dc.Subnumero=Comparativas.SubnumeroSeleccionado)))
WHERE IsNull(ImporteComparativaCalculado,0)=0

CREATE TABLE #Auxiliar4 (IdComparativa INTEGER, IdSectorEmisor INTEGER)
INSERT INTO #Auxiliar4
 SELECT IdComparativa, Null
 FROM Comparativas

UPDATE #Auxiliar4
SET IdSectorEmisor=(Select Top 1 Requerimientos.IdSector
			From DetalleComparativas dc
			Left Outer Join DetallePresupuestos dp On dp.IdDetallePresupuesto=dc.IdDetallePresupuesto
			Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento=dp.IdDetalleRequerimiento
			Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=dr.IdRequerimiento
			Where dc.IdComparativa=#Auxiliar4.IdComparativa)

TRUNCATE TABLE _TempAutorizaciones
INSERT INTO _TempAutorizaciones
SELECT 
	Aco.IdAcopio as [IdComp],
	'Acopio' as [Tipo],
	str(Aco.NumeroAcopio,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=1 and a.IdComprobante=Aco.IdAcopio and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='N' Then 
		(Select Top 1 Emp.IdEmpleado From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
		(Select Top 1 Emp.IdEmpleado From Empleados Emp
			Where (Select Top 1 Emp1.IdSector From Empleados Emp1
					Where Emp1.IdEmpleado=Aco.Aprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo  or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='N' Then
		(Select Top 1 Emp.IdSector From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
		(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Aco.Aprobo)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=1 and a.IdComprobante=Aco.IdAcopio and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	Aco.Aprobo as [IdLibero],
	Aco.Fecha as [Fecha]
FROM Acopios Aco
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=1
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE Aco.Aprobo is not null and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=1 and Aut.IdComprobante=Aco.IdAcopio and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	LMat.IdLMateriales as [IdComp],
	'L.Materiales' as [Tipo],
	str(LMat.NumeroLMateriales,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=2 and a.IdComprobante=LMat.IdLMateriales and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='N' Then
		(Select Top 1 Emp.IdEmpleado From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
		     (  Select Top 1 Emp.IdEmpleado
			From Empleados Emp
			Where ( Select Top 1 Emp1.IdSector 
				From Empleados Emp1
				Where Emp1.IdEmpleado=LMat.Aprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo  or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='N' Then
		(Select Top 1 Emp.IdSector From Empleados Emp
			Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
		(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=LMat.Aprobo)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=2 and a.IdComprobante=LMat.IdLMateriales and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	LMat.Aprobo as [IdLibero],
	LMat.Fecha as [Fecha]
FROM LMateriales LMat
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=2
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE LMat.Aprobo is not null and IsNull(LMat.CircuitoFirmasCompleto,'NO')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=2 and Aut.IdComprobante=LMat.IdLMateriales and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	Req.IdRequerimiento as [IdComp],
	'R.M.' as [Tipo],
	str(Req.NumeroRequerimiento,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=3 and a.IdComprobante=Req.IdRequerimiento and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='O' Then 			Case When NOT Obras.TipoObra is null Then 
					Case When IsNull(DetAut.PersonalObra1,-1)=0 Then Obras.IdJefeRegional
						When IsNull(DetAut.PersonalObra1,-1)=1 Then Obras.IdJefe
						When IsNull(DetAut.PersonalObra1,-1)=2 Then Obras.IdSubJefe
						Else Obras.IdJefe
					End
				Else Case When DetAut.SectorEmisor2='N' Then							(Select Top 1 Emp.IdEmpleado From Empleados Emp
							 Where (DetAut.IdSectorAutoriza2=Emp.IdSector  and DetAut.IdCargoAutoriza2=Emp.IdCargo) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector1 and DetAut.IdCargoAutoriza2=Emp.IdCargo1) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector2 and DetAut.IdCargoAutoriza2=Emp.IdCargo2) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector3 and DetAut.IdCargoAutoriza2=Emp.IdCargo3) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector4 and DetAut.IdCargoAutoriza2=Emp.IdCargo4))
						When DetAut.SectorEmisor2='S' Then
							(Select Top 1 Emp.IdEmpleado From Empleados Emp
							 Where (Req.IdSector=Emp.IdSector  and DetAut.IdCargoAutoriza2=Emp.IdCargo) or 
							      (Req.IdSector=Emp.IdSector1 and DetAut.IdCargoAutoriza2=Emp.IdCargo1) or 
							      (Req.IdSector=Emp.IdSector2 and DetAut.IdCargoAutoriza2=Emp.IdCargo2) or 
							      (Req.IdSector=Emp.IdSector3 and DetAut.IdCargoAutoriza2=Emp.IdCargo3) or 
							      (Req.IdSector=Emp.IdSector4 and DetAut.IdCargoAutoriza2=Emp.IdCargo4))
						Else Null 
					End
			End
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Req.IdSector=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (Req.IdSector=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (Req.IdSector=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (Req.IdSector=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (Req.IdSector=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' Then IsNull(#Auxiliar3.IdFirmante,DetAut.IdFirmante1)
		Else Null 
	End as [Autoriza],	
	Case When DetAut.SectorEmisor1='O' Then 
			Case When NOT Obras.TipoObra is null Then 
					Case When IsNull(DetAut.PersonalObra1,-1)=0 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefeRegional)
						When IsNull(DetAut.PersonalObra1,-1)=1 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
						When IsNull(DetAut.PersonalObra1,-1)=2 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdSubJefe)
						Else (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
					End
				Else 	
					Case When DetAut.SectorEmisor2='N' Then
						(Select Top 1 Emp.IdSector From Empleados Emp
							Where (DetAut.IdSectorAutoriza2=Emp.IdSector  and DetAut.IdCargoAutoriza2=Emp.IdCargo) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector1 and DetAut.IdCargoAutoriza2=Emp.IdCargo1) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector2 and DetAut.IdCargoAutoriza2=Emp.IdCargo2) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector3 and DetAut.IdCargoAutoriza2=Emp.IdCargo3) or 
							      (DetAut.IdSectorAutoriza2=Emp.IdSector4 and DetAut.IdCargoAutoriza2=Emp.IdCargo4))
						When DetAut.SectorEmisor2='S' Then Req.IdSector
						Else Null 
					End
			End
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector  and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then Req.IdSector
		When DetAut.SectorEmisor1='F' Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=IsNull(#Auxiliar3.IdFirmante,DetAut.IdFirmante1))
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=3 and a.IdComprobante=Req.IdRequerimiento and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],	Req.Aprobo as [IdLibero],
	Req.FechaRequerimiento as [Fecha]
FROM Requerimientos Req
LEFT OUTER JOIN Obras ON Req.IdObra=Obras.IdObra
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=3
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdComprobante=Req.IdRequerimiento and #Auxiliar3.IdFormulario=Autorizaciones.IdFormulario and #Auxiliar3.OrdenAutorizacion=DetAut.OrdenAutorizacion
WHERE Req.Aprobo is not null and IsNull(Req.CircuitoFirmasCompleto,'NO')<>'SI' and IsNull(Req.Cumplido,'NO')='NO' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
/*
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=3 and Aut.IdComprobante=Req.IdRequerimiento and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1)))) and 
*/
	Not (Exists(Select Top 1 daf.IdDetalleAutorizacionFirmantes From DetalleAutorizacionesFirmantes daf Where daf.IdDetalleAutorizacion=DetAut.IdDetalleAutorizacion) and IsNull(#Auxiliar3.IdFirmante,0)=0)

UNION ALL

SELECT 
	Ped.IdPedido as [IdComp],
	'Pedido' as [Tipo],
	Case When Ped.SubNumero is not null Then str(Ped.NumeroPedido,8)+' / '+str(Ped.SubNumero,2) Else str(Ped.NumeroPedido,8) End as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=4 and a.IdComprobante=Ped.IdPedido and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='O' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			Case When IsNull(DetAut.PersonalObra1,-1)=0 Then Obras.IdJefeRegional
				When IsNull(DetAut.PersonalObra1,-1)=1 Then Obras.IdJefe
				When IsNull(DetAut.PersonalObra1,-1)=2 Then Obras.IdSubJefe
				Else Obras.IdJefe
			End
		When DetAut.SectorEmisor1='N' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='LIB' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Select Top 1 Emp1.IdSector From Empleados Emp1 Where Emp1.IdEmpleado=Ped.Aprobo)=Emp.IdSector and 
					(DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
					 DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
					 DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='RM' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Select Top 1 R.IdSector From Requerimientos R 
					Where R.IdRequerimiento=(Select Top 1 DR.IdRequerimiento From DetalleRequerimientos DR 
									Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento From DetallePedidos DP 
														Where DP.IdPedido=Ped.IdPedido and DP.IdDetalleRequerimiento is not null)))=Emp.IdSector and 
					(DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				     DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				     DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' Then 
			Case When #Auxiliar7.IdFirmante is not null Then #Auxiliar7.IdFirmante
				Else Case When IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
						IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then IsNull(#Auxiliar3.IdFirmante,DetAut.IdFirmante1) Else Null End
			End
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='O' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			Case When IsNull(DetAut.PersonalObra1,-1)=0 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefeRegional)
				When IsNull(DetAut.PersonalObra1,-1)=1 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
				When IsNull(DetAut.PersonalObra1,-1)=2 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdSubJefe)
				Else (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
			End
		When DetAut.SectorEmisor1='N' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='LIB' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Ped.Aprobo)
		When DetAut.SectorEmisor1='S' and @SectorEmisorEnPedidos='RM' and 
			IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
			(Select Top 1 R.IdSector From Requerimientos R 
			 Where R.IdRequerimiento=(Select Top 1 DR.IdRequerimiento From DetalleRequerimientos DR 
							Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento From DetallePedidos DP 
												Where DP.IdPedido=Ped.IdPedido and DP.IdDetalleRequerimiento is not null)))
		When DetAut.SectorEmisor1='F' Then 
			Case When #Auxiliar7.IdFirmante is not null Then (Select Top 1 IsNull(Emp.IdSector,Emp.IdSector1) From Empleados Emp Where Emp.IdEmpleado=#Auxiliar7.IdFirmante)
				Else Case When IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
						IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) Then
					(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=IsNull(#Auxiliar3.IdFirmante,DetAut.IdFirmante1)) Else Null End
			End
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=4 and a.IdComprobante=Ped.IdPedido and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	Ped.Aprobo as [IdLibero],
	Ped.FechaPedido as [Fecha]
FROM Pedidos Ped
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=4
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
LEFT OUTER JOIN Obras ON Obras.IdObra=(Select Top 1 R.IdObra From Requerimientos R 
					Where R.IdRequerimiento=(Select Top 1 DR.IdRequerimiento From DetalleRequerimientos DR 
									Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento From DetallePedidos DP 
														Where DP.IdPedido=Ped.IdPedido and DP.IdDetalleRequerimiento is not null)))
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdComprobante=Ped.IdPedido and #Auxiliar3.IdFormulario=Autorizaciones.IdFormulario and #Auxiliar3.OrdenAutorizacion=DetAut.OrdenAutorizacion
LEFT OUTER JOIN #Auxiliar7 ON #Auxiliar7.IdComprobante=Ped.IdPedido and #Auxiliar7.IdFormulario=Autorizaciones.IdFormulario and #Auxiliar7.OrdenAutorizacion=DetAut.OrdenAutorizacion
WHERE Ped.Aprobo is not null and IsNull(Ped.CircuitoFirmasCompleto,'NO')<>'SI' and (Ped.Cumplido is null or Ped.Cumplido<>'AN') and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
	(Patindex('%'+DetAut.SectorEmisor1+'%', 'F S N O')=0 or 
	 (Patindex('%'+DetAut.SectorEmisor1+'%', 'F S N O')<>0 and 
		IsNull(DetAut.ImporteDesde1,0)<=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1) and 
		IsNull(DetAut.ImporteHasta1,0)>=(Ped.TotalPedido-Ped.TotalIva1)*IsNull(Ped.CotizacionMoneda,1))) and 
/*
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=4 and Aut.IdComprobante=Ped.IdPedido and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1)))) and 
*/
	(@FirmantesPorRubro<>'SI' or (@FirmantesPorRubro='SI' and Not (Exists(Select Top 1 daf.IdDetalleAutorizacionFirmantes From DetalleAutorizacionesFirmantes daf Where daf.IdDetalleAutorizacion=DetAut.IdDetalleAutorizacion) and IsNull(#Auxiliar3.IdFirmante,0)=0))) and 
	(Len(IsNull(DetAut.IdsTipoCompra,''))=0 or Patindex('%('+Convert(varchar,IsNull(Ped.IdTipoCompraRM,0))+')%', IsNull(DetAut.IdsTipoCompra,''))<>0)

UNION ALL

SELECT 
	Comp.IdComparativa as [IdComp],
	'Comparativa' as [Tipo],
	str(Comp.Numero,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=5 and a.IdComprobante=Comp.IdComparativa and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='N' and 
			IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
			IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0) Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' and 
			IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
			IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0) Then 
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where #Auxiliar4.IdSectorEmisor=Emp.IdSector and (DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
									     DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
			IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0) Then
		     DetAut.IdFirmante1
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='N' and 
			IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
			IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0) Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' and 
			IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
			IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0) Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Comp.IdAprobo)
		When DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
			IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0) Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=DetAut.IdFirmante1)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=5 and a.IdComprobante=Comp.IdComparativa and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	Comp.IdAprobo as [IdLibero],
	Comp.Fecha as [Fecha]
FROM Comparativas Comp
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=5
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdComparativa=Comp.IdComparativa
WHERE Comp.IdAprobo is not null and IsNull(Comp.Anulada,'')<>'SI' and IsNull(Comp.CircuitoFirmasCompleto,'NO')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut 
			Where Aut.IdFormulario=5 and Aut.IdComprobante=Comp.IdComparativa and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
	(Patindex('%'+DetAut.SectorEmisor1+'%', 'F ')=0 or 
	 (Patindex('%'+DetAut.SectorEmisor1+'%', 'F ')<>0 and 
		IsNull(DetAut.ImporteDesde1,0)<=IsNull(Comp.ImporteComparativaCalculado,0) and 
		IsNull(DetAut.ImporteHasta1,0)>=IsNull(Comp.ImporteComparativaCalculado,0))) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=5 and Aut.IdComprobante=Comp.IdComparativa and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	Aju.IdAjusteStock as [IdComp],
	'Ajuste Stock' as [Tipo],
	str(Aju.NumeroAjusteStock,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=6 and a.IdComprobante=Aju.IdAjusteStock and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Select Top 1 Emp1.IdSector From Empleados Emp1
					Where Emp1.IdEmpleado=Aju.IdAprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Aju.IdAprobo )
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=6 and a.IdComprobante=Aju.IdAjusteStock and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	Aju.IdAprobo as [IdLibero],
	Aju.FechaAjuste as [Fecha]
FROM AjustesStock Aju
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=6
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE Aju.IdAprobo is not null and IsNull(Aju.CircuitoFirmasCompleto,'NO')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=6 and Aut.IdComprobante=Aju.IdAjusteStock and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	cp.IdComprobanteProveedor as [IdComp],
	'Comp.Proveedores' as [Tipo],
	cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=31 and a.IdComprobante=cp.IdComprobanteProveedor and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='O' and 
			IsNull(DetAut.ImporteDesde1,0)<=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) Then
			Case When IsNull(DetAut.PersonalObra1,-1)=0 Then Obras.IdJefeRegional
				When IsNull(DetAut.PersonalObra1,-1)=1 Then Obras.IdJefe
				When IsNull(DetAut.PersonalObra1,-1)=2 Then Obras.IdSubJefe
				Else Obras.IdJefe
			End
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) Then
		     DetAut.IdFirmante1
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='O' and 
			IsNull(DetAut.ImporteDesde1,0)<=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) Then
			Case When IsNull(DetAut.PersonalObra1,-1)=0 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefeRegional)
				When IsNull(DetAut.PersonalObra1,-1)=1 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
				When IsNull(DetAut.PersonalObra1,-1)=2 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdSubJefe)
				Else (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
			End
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' and 
			IsNull(DetAut.ImporteDesde1,0)<=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) and 
			IsNull(DetAut.ImporteHasta1,0)>=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=DetAut.IdFirmante1)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=31 and a.IdComprobante=cp.IdComprobanteProveedor and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	Null as [IdLibero],
	cp.FechaComprobante as [Fecha]
FROM ComprobantesProveedores cp
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=31
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar1.IdObra
WHERE IsNull(cp.CircuitoFirmasCompleto,'NO')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=31 and Aut.IdComprobante=cp.IdComprobanteProveedor and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) and 
	(Patindex('%'+DetAut.SectorEmisor1+'%', 'F O')=0 or 
	 (Patindex('%'+DetAut.SectorEmisor1+'%', 'F O')<>0 and 
		IsNull(DetAut.ImporteDesde1,0)<=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1) and 
		IsNull(DetAut.ImporteHasta1,0)>=cp.TotalBruto*IsNull(cp.CotizacionMoneda,1))) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=31 and Aut.IdComprobante=cp.IdComprobanteProveedor and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	ac.IdAutorizacionCompra as [IdComp],
	'Autorizacion compra' as [Tipo],
	str(ac.Numero,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=55 and a.IdComprobante=ac.IdAutorizacionCompra and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Select Top 1 Emp1.IdSector From Empleados Emp1
					Where Emp1.IdEmpleado=ac.IdAprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=ac.IdAprobo)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=55 and a.IdComprobante=ac.IdAutorizacionCompra and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	ac.IdAprobo as [IdLibero],
	ac.Fecha as [Fecha]
FROM AutorizacionesCompra ac
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=55
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE ac.IdAprobo is not null and IsNull(ac.CircuitoFirmasCompleto,'NO')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=55 and Aut.IdComprobante=ac.IdAutorizacionCompra and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=55 and Aut.IdComprobante=ac.IdAutorizacionCompra and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	co.IdCertificacionObraDatos as [IdComp],
	'Certificado obra' as [Tipo],
	str(co.NumeroCertificado,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=56 and a.IdComprobante=co.IdCertificacionObraDatos and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Select Top 1 Emp1.IdSector From Empleados Emp1
					Where Emp1.IdEmpleado=co.IdAprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' Then
		     DetAut.IdFirmante1
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=co.IdAprobo )
		When DetAut.SectorEmisor1='F' Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=DetAut.IdFirmante1)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=56 and a.IdComprobante=co.IdCertificacionObraDatos and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	co.IdAprobo as [IdLibero],
	co.Fecha as [Fecha]
FROM CertificacionesObrasDatos co
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=56
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE co.IdAprobo is not null and IsNull(co.CircuitoFirmasCompleto,'NO')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=56 and Aut.IdComprobante=co.IdCertificacionObraDatos and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=56 and Aut.IdComprobante=co.IdCertificacionObraDatos and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/

UNION ALL

SELECT 
	dsd.IdDetalleSubcontratoDatos as [IdComp],
	'Certif. Subcontrato' as [Tipo],
	str(dsd.NumeroCertificado,8) as [Numero],
	Autorizaciones.IdAutorizacion,
	Autorizaciones.IdFormulario,
	DetAut.IdDetalleAutorizacion,
	DetAut.SectorEmisor1,
	DetAut.OrdenAutorizacion,
	Case When IsNull(DetAut.ADesignar,'')='SI' Then 
		IsNull((Select Top 1 a.IdFirmanteDesignado From AutorizacionesPorComprobanteADesignar a
			Where a.IdFormulario=57 and a.IdComprobante=dsd.IdDetalleSubcontratoDatos and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		When DetAut.SectorEmisor1='O' Then 			Case When NOT Obras.TipoObra is null Then 
					Case When IsNull(DetAut.PersonalObra1,-1)=0 Then Obras.IdJefeRegional
						When IsNull(DetAut.PersonalObra1,-1)=1 Then Obras.IdJefe
						When IsNull(DetAut.PersonalObra1,-1)=2 Then Obras.IdSubJefe
						Else Obras.IdJefe
					End
				Else Null 
			End
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdEmpleado From Empleados Emp
			 Where (Select Top 1 Emp1.IdSector From Empleados Emp1
					Where Emp1.IdEmpleado=dsd.IdAprobo)=Emp.IdSector and 
				      (DetAut.IdCargoAutoriza1=Emp.IdCargo or DetAut.IdCargoAutoriza1=Emp.IdCargo1 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo2 or DetAut.IdCargoAutoriza1=Emp.IdCargo3 or 
				       DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='F' Then
		     DetAut.IdFirmante1
		Else Null 
	End as [Autoriza],
	Case When DetAut.SectorEmisor1='O' Then 
			Case When NOT Obras.TipoObra is null Then 
					Case When IsNull(DetAut.PersonalObra1,-1)=0 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefeRegional)
						When IsNull(DetAut.PersonalObra1,-1)=1 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
						When IsNull(DetAut.PersonalObra1,-1)=2 Then (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdSubJefe)
						Else (Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=Obras.IdJefe)
					End
				Else Null 
			End
		When DetAut.SectorEmisor1='N' Then
			(Select Top 1 Emp.IdSector From Empleados Emp
			 Where (DetAut.IdSectorAutoriza1=Emp.IdSector and DetAut.IdCargoAutoriza1=Emp.IdCargo ) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector1 and DetAut.IdCargoAutoriza1=Emp.IdCargo1) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector2 and DetAut.IdCargoAutoriza1=Emp.IdCargo2) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector3 and DetAut.IdCargoAutoriza1=Emp.IdCargo3) or 
			      (DetAut.IdSectorAutoriza1=Emp.IdSector4 and DetAut.IdCargoAutoriza1=Emp.IdCargo4))
		When DetAut.SectorEmisor1='S' Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=dsd.IdAprobo )
		When DetAut.SectorEmisor1='F' Then
			(Select Top 1 Emp.IdSector From Empleados Emp Where Emp.IdEmpleado=DetAut.IdFirmante1)
		When DetAut.SectorEmisor1='V' Then
			IsNull((Select Top 1 Emp.IdSector From AutorizacionesPorComprobanteADesignar a
				Left Outer Join Empleados Emp On Emp.IdEmpleado=a.IdFirmanteDesignado
				Where a.IdFormulario=56 and a.IdComprobante=dsd.IdDetalleSubcontratoDatos and a.OrdenAutorizacion=DetAut.OrdenAutorizacion),-1)
		Else Null 
	End as [Sector],
	dsd.IdAprobo as [IdLibero],
	dsd.FechaCertificado as [Fecha]
FROM DetalleSubcontratosDatos dsd
LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.IdSubcontratoDatos=dsd.IdSubcontratoDatos
LEFT OUTER JOIN Obras ON Obras.IdObra=SubcontratosDatos.IdObra
LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdFormulario=57
LEFT OUTER JOIN DetalleAutorizaciones DetAut ON Autorizaciones.IdAutorizacion=DetAut.IdAutorizacion
WHERE dsd.IdAprobo is not null and IsNull(dsd.CircuitoFirmasCompleto,'NO')<>'SI' and IsNull(SubcontratosDatos.Anulado,'')<>'SI' and 
	Not Exists(Select * From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=57 and Aut.IdComprobante=dsd.IdDetalleSubcontratoDatos and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion) 
/*
	and 
	(@RespetarPrecedencia<>'SI' or 
	 (@RespetarPrecedencia='SI' and 
	  (DetAut.OrdenAutorizacion=1 or 
	   Exists(Select Aut.OrdenAutorizacion From AutorizacionesPorComprobante Aut Where Aut.IdFormulario=57 and Aut.IdComprobante=dsd.IdDetalleSubcontratoDatos and Aut.OrdenAutorizacion=DetAut.OrdenAutorizacion-1))))
*/
ORDER BY Tipo, IdComp, DetAut.OrdenAutorizacion

/*
select * from #Auxiliar5 order by idcomprobante,idrubro,importeitem
select * from #Auxiliar6 order by idcomprobante,ordenautorizacion
select * from #Auxiliar7 order by idcomprobante
*/

DELETE _TempAutorizaciones WHERE IdAutoriza=@IdEmpleadoSinFirma

IF @RespetarPrecedencia='SI'
  BEGIN
	INSERT INTO #Auxiliar8
	 SELECT IdComprobante, IsNull(IdFormulario,0), Min(IsNull(OrdenAutorizacion,0))
	 FROM _TempAutorizaciones
	 GROUP BY IdComprobante, IdFormulario

	DELETE _TempAutorizaciones WHERE Not Exists(Select Top 1 a.IdComprobante From #Auxiliar8 a Where a.IdComprobante=_TempAutorizaciones.IdComprobante and a.IdFormulario=_TempAutorizaciones.IdFormulario and a.OrdenAutorizacion=_TempAutorizaciones.OrdenAutorizacion)
  END

SET NOCOUNT OFF

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
