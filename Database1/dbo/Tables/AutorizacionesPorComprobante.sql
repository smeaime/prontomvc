CREATE TABLE [dbo].[AutorizacionesPorComprobante] (
    [IdAutorizacionPorComprobante] INT         IDENTITY (1, 1) NOT NULL,
    [IdFormulario]                 INT         NULL,
    [IdComprobante]                INT         NULL,
    [OrdenAutorizacion]            INT         NULL,
    [IdAutorizo]                   INT         NULL,
    [FechaAutorizacion]            DATETIME    NULL,
    [Visto]                        VARCHAR (2) NULL,
    CONSTRAINT [PK_AutorizacionesPorComprobante] PRIMARY KEY CLUSTERED ([IdAutorizacionPorComprobante] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[AutorizacionesPorComprobante]([IdFormulario] ASC, [IdComprobante] ASC, [OrdenAutorizacion] ASC) WITH (FILLFACTOR = 90);

