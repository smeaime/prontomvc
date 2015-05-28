CREATE TABLE [dbo].[CertificacionesObrasPxQ] (
    [IdCertificacionObrasPxQ] INT             IDENTITY (1, 1) NOT NULL,
    [IdCertificacionObras]    INT             NULL,
    [IdArticulo]              INT             NULL,
    [Mes]                     INT             NULL,
    [Año]                     INT             NULL,
    [Importe]                 NUMERIC (18, 8) NULL,
    [Cantidad]                NUMERIC (18, 2) NULL,
    [ImporteAvance]           NUMERIC (18, 8) NULL,
    [CantidadAvance]          NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_CertificacionesObrasPxQ] PRIMARY KEY CLUSTERED ([IdCertificacionObrasPxQ] ASC) WITH (FILLFACTOR = 90)
);

