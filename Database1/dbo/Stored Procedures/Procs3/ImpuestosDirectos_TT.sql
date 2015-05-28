CREATE Procedure [dbo].[ImpuestosDirectos_TT]

AS

SELECT
 ImpuestosDirectos.IdImpuestoDirecto,
 ImpuestosDirectos.Descripcion,
 ImpuestosDirectos.Tasa,
 TiposImpuesto.Descripcion as [Tipo impuesto],
 Cuentas.Descripcion as [Cuenta contable],
 BaseMinima as [Base minima],
 ProximoNumeroCertificado as [Prox.Nro.Certif.],
 ImpuestosDirectos.Codigo,
 ImpuestosDirectos.TopeAnual as [Tope anual],
 ImpuestosDirectos.ParaInscriptosEnRegistroFiscalOperadoresGranos as [Inscr.Reg.Fiscal],
 ImpuestosDirectos.CodigoRegimen as [Cod.Regimen]
FROM ImpuestosDirectos
LEFT OUTER JOIN TiposImpuesto ON ImpuestosDirectos.IdTipoImpuesto=TiposImpuesto.IdTipoImpuesto
LEFT OUTER JOIN Cuentas ON ImpuestosDirectos.IdCuenta=Cuentas.IdCuenta
ORDER BY ImpuestosDirectos.Descripcion