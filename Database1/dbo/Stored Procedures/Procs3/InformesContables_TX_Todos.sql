

































CREATE  Procedure [dbo].[InformesContables_TX_Todos]
AS 
SELECT 
IdInforme,
CodigoInforme as [Codigo del informe],
TituloInforme as [Titulo del informe],
InformeVector_X,
InformeVector_T,
Vector_T,
Vector_X
FROM Informes
where CodigoInforme between 500 and 599


































