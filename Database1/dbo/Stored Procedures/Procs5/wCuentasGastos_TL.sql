
CREATE Procedure [dbo].[wCuentasGastos_TL]
AS 
SELECT 
 IdCuentaGasto,
 Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS + ' ' + Convert(varchar,Codigo COLLATE SQL_Latin1_General_CP1_CI_AS) COLLATE SQL_Latin1_General_CP1_CI_AS as [Titulo]
FROM CuentasGastos
ORDER by Descripcion

