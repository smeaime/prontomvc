
CREATE Procedure [dbo].[_TempSAP_TX_Proveedores]

AS 

SELECT 
 Proveedores.InformacionAuxiliar as [KTOKK],
 '1000' as [BUKRS], 
 '1' as [BUKRS], 
 Proveedores.RazonSocial as [lfa1-name1], 
 Proveedores.NombreFantasia as [lfa1-name2], 
 Proveedores.Direccion as [lfa1-stras],  
 Localidades.Nombre as [lfa1-ort01], 
 Proveedores.CodigoPostal as [lfa1-pstlz], 
 Prov1.Codigo AS [lfa1-regio], 
 Paises.Codigo AS [lfa1-land1], 
 Proveedores.Telefono1 as [lfa1-telf1], 
 Proveedores.Fax as [lfa1-telfx],
 '80' as [lfa1-stcdt], 
 Case When Len(IsNull(Proveedores.Cuit,''))>0 
	Then Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1)
	Else ''
 End as [lfa1-stcd1],
 IsNull(Proveedores.IBNumeroInscripcion,'') as [lfa1-stcd2],
 DescripcionIva.InformacionAuxiliar as [lfa1-fityp], 
 [Condiciones Compra].Codigo as [lfb1-zterm],
 'X' as [lfb1-zwels], 
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then ''
	Else Substring(IsNull(TiposRetencionGanancia.InformacionAuxiliar,''),1,2)
 End as [LFBW-WITHT],
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then ''
	Else Substring(IsNull(TiposRetencionGanancia.InformacionAuxiliar,''),3,2)
 End as [LBFW-WT_WITHCD],
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then '100,00'
	Else ''
 End as [LFBW-WT_EXRT],
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then ''
	Else ''
 End as [LFBW-WT_EXNR],
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then Substring(Convert(varchar,Getdate(),103),1,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),4,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoGanancias,Getdate()),103),1,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoGanancias,Getdate()),103),4,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoGanancias,Getdate()),103),7,4)
	Else ''
 End as [LFBW-WT_EXDT],
 Case When IsNull(Proveedores.IGCondicion,1)=1
	Then ''
	Else Substring(IsNull(TiposRetencionGanancia.InformacionAuxiliar,''),5,2)
 End as [LFBW-QSREC],
 Substring(IsNull(Proveedores.CodigoRetencionIVA,''),1,2) as [LBFW-WT_WITH],
 Substring(IsNull(Proveedores.CodigoRetencionIVA,''),3,2) as [LBFW-WT_WITHCD],
 Case When IsNull(Proveedores.IvaExencionRetencion,'NO')='SI' 
	Then '100,00'
	When IsNull(Proveedores.IvaPorcentajeExencion,0)<>0 
	Then Replace(Convert(varchar,Proveedores.IvaPorcentajeExencion),'.',',')
	Else ''
 End as [LFBW-WT_EXRT],
 '' as [LFBW-WT_EXNR],
 Case When Proveedores.IvaFechaInicioExencion is not null
	Then Substring(Convert(varchar,IsNull(Proveedores.IvaFechaInicioExencion,Getdate()),103),1,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.IvaFechaInicioExencion,Getdate()),103),4,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.IvaFechaInicioExencion,Getdate()),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When Proveedores.IvaFechaCaducidadExencion is not null
	Then Substring(Convert(varchar,IsNull(Proveedores.IvaFechaCaducidadExencion,Getdate()),103),1,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.IvaFechaCaducidadExencion,Getdate()),103),4,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.IvaFechaCaducidadExencion,Getdate()),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Substring(IsNull(Proveedores.CodigoRetencionIVA,''),5,2) as [LFBW-QSREC],
 Substring(IsNull(ImpuestosDirectos.Codigo,''),1,2) as [LBFW-WT_WITH],
 Substring(IsNull(ImpuestosDirectos.Codigo,''),3,2) as [LBFW-WT_WITHCD],
 Case When IsNull(RetenerSUSS,'NO')='EX' 
	Then '100,00'
	Else ''
 End as [LFBW-WT_EXRT],
 '' as [LFBW-WT_EXNR],
 Case When IsNull(RetenerSUSS,'NO')='EX' 
	Then Substring(Convert(varchar,Getdate(),103),1,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),4,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When IsNull(RetenerSUSS,'NO')='EX' 
	Then Substring(Convert(varchar,IsNull(Proveedores.SUSSFechaCaducidadExencion,Getdate()),103),1,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.SUSSFechaCaducidadExencion,Getdate()),103),4,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.SUSSFechaCaducidadExencion,Getdate()),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Substring(IsNull(ImpuestosDirectos.Codigo,''),5,2) as [LFBW-QSREC],
 Case When Prov1.IdProvincia=8
	Then Substring(IsNull(IBCondiciones.InformacionAuxiliar,''),1,2)
	Else ''
 End as [LBFW-WT_WITH],
 Case When Prov1.IdProvincia=8
	Then Substring(IsNull(IBCondiciones.InformacionAuxiliar,''),3,2)
	Else ''
 End as [LBFW-WT_WITHCD],
 Case When Prov1.IdProvincia=8 and IsNull(Proveedores.IBCondicion,1)=1
	Then '100,00'
	Else ''
 End as [LFBW-WT_EXRT],
 '' as [LFBW-WT_EXNR],
 Case When Prov1.IdProvincia=8 and IsNull(Proveedores.IBCondicion,1)=1
	Then Substring(Convert(varchar,Getdate(),103),1,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),4,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When Prov1.IdProvincia=8 and IsNull(Proveedores.IBCondicion,1)=1
	Then Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoIIBB,Getdate()),103),1,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoIIBB,Getdate()),103),4,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoIIBB,Getdate()),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When Prov1.IdProvincia=8
	Then Substring(IsNull(IBCondiciones.InformacionAuxiliar,''),5,2)
	Else ''
 End as [LFBW-QSREC],
 Case When Prov1.IdProvincia=2
	Then Substring(IsNull(IBCondiciones.InformacionAuxiliar,''),1,2)
	Else ''
 End as [LBFW-WT_WITH],
 Case When Prov1.IdProvincia=2
	Then Substring(IsNull(IBCondiciones.InformacionAuxiliar,''),3,2)
	Else ''
 End as [LBFW-WT_WITHCD],
 Case When Prov1.IdProvincia=2 and IsNull(Proveedores.IBCondicion,1)=1
	Then '100,00'
	Else ''
 End as [LFBW-WT_EXRT],
 '' as [LFBW-WT_EXNR],
 Case When Prov1.IdProvincia=2 and IsNull(Proveedores.IBCondicion,1)=1
	Then Substring(Convert(varchar,Getdate(),103),1,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),4,2)+'.'+
		Substring(Convert(varchar,Getdate(),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When Prov1.IdProvincia=2 and IsNull(Proveedores.IBCondicion,1)=1
	Then Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoIIBB,Getdate()),103),1,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoIIBB,Getdate()),103),4,2)+'.'+
		Substring(Convert(varchar,IsNull(Proveedores.FechaLimiteExentoIIBB,Getdate()),103),7,4)
	Else ''
 End as [LFBW-WT_EXDF],
 Case When Prov1.IdProvincia=2
	Then Substring(IsNull(IBCondiciones.InformacionAuxiliar,''),5,2)
	Else ''
 End as [LFBW-QSREC],
 '' as [LIFNR],
 IsNull(Proveedores.CodigoEmpresa,'') as [LFB1-ALTKN],
 IsNull(Cuentas.Codigo,0) as [lfb1-akont],
 IsNull(Monedas.CodigoAFIP,'') as [LFM1-WAERS],
 '' as [LFM1-KALSK],
 ' ' as [Filler]
FROM Proveedores
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias Prov1 ON Proveedores.IdProvincia = Prov1.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
LEFT OUTER JOIN [Condiciones Compra] ON Proveedores.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
LEFT OUTER JOIN TiposRetencionGanancia ON Proveedores.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionGanancia
LEFT OUTER JOIN Cuentas ON Proveedores.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN IBCondiciones ON Proveedores.IdIBCondicionPorDefecto = IBCondiciones.IdIBCondicion
LEFT OUTER JOIN Provincias Prov2 ON IBCondiciones.IdProvincia = Prov2.IdProvincia
LEFT OUTER JOIN ImpuestosDirectos ON Proveedores.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
LEFT OUTER JOIN Monedas ON Proveedores.IdMoneda = Monedas.IdMoneda
WHERE IsNull(Proveedores.Confirmado,'SI')<>'NO' and IsNull(Proveedores.IdEstado,1)=1
ORDER BY Proveedores.InformacionAuxiliar, Proveedores.RazonSocial
