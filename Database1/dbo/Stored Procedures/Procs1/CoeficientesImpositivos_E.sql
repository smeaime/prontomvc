










CREATE Procedure [dbo].[CoeficientesImpositivos_E]
@IdCoeficienteImpositivo int  
As 
Delete CoeficientesImpositivos
Where (IdCoeficienteImpositivo=@IdCoeficienteImpositivo)











