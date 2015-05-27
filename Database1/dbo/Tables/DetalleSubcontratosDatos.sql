CREATE TABLE [dbo].[DetalleSubcontratosDatos] (
    [IdDetalleSubcontratoDatos] INT             IDENTITY (1, 1) NOT NULL,
    [IdSubcontratoDatos]        INT             NULL,
    [NumeroCertificado]         INT             NULL,
    [FechaCertificado]          DATETIME        NULL,
    [PorcentajeCertificacion]   NUMERIC (6, 2)  NULL,
    [PorcentajeFondoReparo]     NUMERIC (6, 2)  NULL,
    [OtrosDescuentos]           NUMERIC (18, 2) NULL,
    [PorcentajeIVA]             NUMERIC (6, 2)  NULL,
    [Observaciones]             NTEXT           NULL,
    [FechaCertificadoDesde]     DATETIME        NULL,
    [FechaCertificadoHasta]     DATETIME        NULL,
    [IdAprobo]                  INT             NULL,
    [CircuitoFirmasCompleto]    VARCHAR (2)     NULL,
    CONSTRAINT [PK_DetalleSubcontratosDatos] PRIMARY KEY CLUSTERED ([IdDetalleSubcontratoDatos] ASC) WITH (FILLFACTOR = 90)
);

