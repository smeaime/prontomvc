CREATE Procedure [dbo].[Provincias_TT]

AS 

SELECT 
 Provincias.IdProvincia,
 Provincias.Codigo as [Codigo],
 Provincias.Nombre as [Provincia],
 Paises.Descripcion as [Pais],
 Provincias.ProximoNumeroCertificadoRetencionIIBB as [Prox.cert.ret.IIBB],
 Provincias.ProximoNumeroCertificadoRetencionIIBB2 as [Prox.cert.ret.IIBB (Contrucc.)],
 ProximoNumeroCertificadoPercepcionIIBB as [Prox.cert.perc.IIBB],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaRetencionIBrutos) as [Cuenta Ret. IIBB],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaRetencionIBrutos2) as [Cuenta Ret. IIBB (Contrucc.)],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaPercepcionIBrutos) as [Cuenta Perc. IIBB ventas],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaPercepcionIIBBConvenio) as [Cuenta Perc. IIBB ventas Convenio],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaRetencionIBrutosCobranzas) as [Cuenta Ret. IIBB Cobranzas],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaPercepcionIIBBCompras) as [Cuenta Perc. IIBB Compras Convenio],
 (Select Top 1 Descripcion From Cuentas Where IdCuenta=Provincias.IdCuentaPercepcionIIBBComprasJurisdiccionLocal) as [Cuenta Perc. IIBB Compras],
 Provincias.EsAgenteRetencionIIBB as [Es agente ret. IIBB],
 Provincias.CodigoESRI as [Cod.ESRI],
 Provincias.Codigo2 as [Codigo 2]
FROM Provincias
LEFT OUTER JOIN Paises ON Paises.IdPais=Provincias.IdPais
ORDER by Provincias.Nombre