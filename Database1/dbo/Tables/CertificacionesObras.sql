CREATE TABLE [dbo].[CertificacionesObras] (
    [IdCertificacionObras] INT             IDENTITY (1, 1) NOT NULL,
    [IdNodoPadre]          INT             NULL,
    [Depth]                TINYINT         NULL,
    [Lineage]              VARCHAR (255)   NULL,
    [TipoNodo]             INT             NULL,
    [IdObra]               INT             NULL,
    [Descripcion]          VARCHAR (255)   NULL,
    [TipoPartida]          TINYINT         NULL,
    [IdUnidad]             INT             NULL,
    [UnidadAvance]         VARCHAR (1)     NULL,
    [Cantidad]             NUMERIC (18, 2) NULL,
    [Importe]              NUMERIC (18, 8) NULL,
    [NumeroCertificado]    INT             NULL,
    [Item]                 VARCHAR (10)    NULL,
    [Adjunto1]             VARCHAR (100)   NULL,
    [NumeroProyecto]       INT             NULL,
    CONSTRAINT [PK_CertificacionesObras] PRIMARY KEY CLUSTERED ([IdCertificacionObras] ASC) WITH (FILLFACTOR = 90)
);

