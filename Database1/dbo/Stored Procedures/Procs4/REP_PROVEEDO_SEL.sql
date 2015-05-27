
CREATE procedure [dbo].[REP_PROVEEDO_SEL]

AS

SELECT 
	Prov.REP_PROVEEDO_INS as [REP_PROVEEDO_INS],
	Prov.CodigoEmpresa as [NUMERO],
	Prov.RazonSocial as [RAZONSOC],
	Prov.Direccion as [DIRECCION],
	Localidades.Nombre as [LOCALIDAD],
	Prov.CodigoPostal as [CODPOSTAL],
	Provincias.InformacionAuxiliar as [PROVINCIA],
	Paises.Descripcion as [PAIS],
	Case When Prov.IdCodigoIva=1 and Prov.CodigoPresto='M' 
		Then 'LM'
		Else DescripcionIva.InformacionAuxiliar 
	End as [IMPUESTO],
	Prov.Cuit as [CUIT],
	Prov.IBNumeroInscripcion as [IGRBRT],
	Prov.Telefono1 as [TELEFONOS],
	IsNull((Select Top 1 CC.CodigoCondicion 
		From [Condiciones Compra] CC 
		Where CC.IdCondicionCompra=Prov.IdCondicionCompra),'') as [CONDCPA],
	Cuentas.Codigo as [IMPUTACML],
	TiposRetencionGanancia.InformacionAuxiliar AS [RETGAN],
	Case When Prov.IvaExencionRetencion = 'SI' Then 'N' Else '1' End as [RETIVA],
	Case When Prov.IvaExencionRetencion = 'SI' Then Null Else Prov.IvaFechaCaducidadExencion End as [FECVTOEXI],
	Case When Prov.IvaExencionRetencion = 'SI' Then 0 Else Prov.IvaPorcentajeExencion End as [EXCLUSIONIVA],
	Case When Prov.IgCondicion = 1 Then 100 Else 0 End as [EXCLUSIONGAN],
	Prov.FechaLimiteExentoGanancias as [FECVTOEXG],
	Case When Prov.IBCondicion = 2 Then Provincias.InformacionAuxiliar 
		When Prov.IBCondicion = 3 Then Provincias.InformacionAuxiliar 
		Else Null 
	End as [JURISDICCION1],
	Case When Prov.IBCondicion = 2 Then IBCondiciones.InformacionAuxiliar 
		When Prov.IBCondicion = 3 Then IBCondiciones.InformacionAuxiliar 
		Else Null 
	End as [CODIGOIB1],
	Null as [FECVTOIB1],
	Prov.InformacionAuxiliar as [CODFACT],
	Prov.ChequesAlaOrdenDe as [ORDENCHEQ],
	Case When Prov.IdImpuestoDirectoSUSS=1 Then 'S' Else 'N' End as [RETSUS],
	Case When Prov.IdImpuestoDirectoSUSS=2 Then 'S' Else 'N' End as [RETLIM],
	Case When Prov.IdImpuestoDirectoSUSS>2 Then 'S' Else 'N' End as [RETCONSTRU],

	Prov.IdProveedor
FROM Proveedores Prov
LEFT OUTER JOIN Localidades ON Prov.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Prov.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Prov.IdPais = Paises.IdPais
LEFT OUTER JOIN Cuentas ON Prov.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN DescripcionIva on Prov.IdCodigoIva = Descripcioniva.IdCodigoIva
LEFT OUTER JOIN TiposRetencionGanancia on Prov.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionganancia
LEFT OUTER JOIN IBCondiciones on Prov.IdIBCondicionPorDefecto = IBCondiciones.IdIBCondicion
WHERE (Prov.REP_PROVEEDO_INS = 'Y' or Prov.REP_PROVEEDO_UPD = 'Y') and prov.codigoempresa is not null
