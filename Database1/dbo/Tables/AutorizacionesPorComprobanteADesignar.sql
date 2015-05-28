CREATE TABLE [dbo].[AutorizacionesPorComprobanteADesignar] (
    [IdAutorizacionPorComprobanteADesignar] INT      IDENTITY (1, 1) NOT NULL,
    [IdFormulario]                          INT      NULL,
    [IdComprobante]                         INT      NULL,
    [OrdenAutorizacion]                     INT      NULL,
    [IdAutorizo]                            INT      NULL,
    [FechaAutorizacion]                     DATETIME NULL,
    [IdFirmanteDesignado]                   INT      NULL,
    CONSTRAINT [PK_AutorizacionesPorComprobanteADesignar] PRIMARY KEY CLUSTERED ([IdAutorizacionPorComprobanteADesignar] ASC) WITH (FILLFACTOR = 90)
);

