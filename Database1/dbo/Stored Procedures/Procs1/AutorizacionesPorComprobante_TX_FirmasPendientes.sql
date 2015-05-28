CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_FirmasPendientes]

AS

SELECT IdAutoriza
FROM _TempAutorizaciones
WHERE IdAutoriza is not null
GROUP BY IdAutoriza