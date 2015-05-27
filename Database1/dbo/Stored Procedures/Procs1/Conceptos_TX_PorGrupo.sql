CREATE  Procedure [dbo].[Conceptos_TX_PorGrupo]

@Grupo int

AS 

SELECT 
 Conceptos.IdConcepto,
 Conceptos.Descripcion as [Descripcion],
 Case When IsNull(Conceptos.Grupo,0)=0 Then ''
	When IsNull(Conceptos.Grupo,0)=1 Then 'Otros conceptos para OP'
	When IsNull(Conceptos.Grupo,0)=2 Then 'Clasificacion por tipo de cancelacion'
	When IsNull(Conceptos.Grupo,0)=3 Then 'Modalidades de pago'
	When IsNull(Conceptos.Grupo,0)=4 Then 'Enviar a'
	When IsNull(Conceptos.Grupo,0)=5 Then 'Textos auxiliares para OP'
 End as [Tipo concepto]
FROM Conceptos 
WHERE (@Grupo=-1 and (IsNull(Conceptos.Grupo,0)=1 or IsNull(Conceptos.Grupo,0)=2 or IsNull(Conceptos.Grupo,0)=3 or IsNull(Conceptos.Grupo,0)=4 or IsNull(Conceptos.Grupo,0)=5)) or 
	(@Grupo<>-1 and IsNull(Conceptos.Grupo,0)=@Grupo)
ORDER BY Conceptos.Descripcion