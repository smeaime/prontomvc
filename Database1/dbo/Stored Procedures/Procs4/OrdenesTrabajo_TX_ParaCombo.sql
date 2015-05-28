CREATE Procedure [dbo].[OrdenesTrabajo_TX_ParaCombo]

@FechaFinalizacion datetime = Null,
@ConCerradas varchar(2) = Null

AS 

SET @ConCerradas=IsNull(@ConCerradas,'')

SELECT
 IdOrdenTrabajo,
 NumeroOrdenTrabajo+' '+Case When FechaFinalizacion is not null Then '(c)' Else '' End as [Titulo]
FROM OrdenesTrabajo
WHERE FechaFinalizacion is null or @FechaFinalizacion<=FechaFinalizacion or @ConCerradas='SI'
ORDER BY NumeroOrdenTrabajo