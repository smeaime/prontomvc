CREATE TABLE [dbo].[DetalleObrasRecepciones] (
    [IdDetalleObraRecepcion] INT          IDENTITY (1, 1) NOT NULL,
    [IdObra]                 INT          NULL,
    [NumeroRecepcion]        INT          NULL,
    [FechaRecepcion]         DATETIME     NULL,
    [TipoRecepcion]          VARCHAR (10) NULL,
    [Detalle]                NTEXT        NULL,
    [IdRealizo]              INT          NULL,
    [FechaRealizo]           DATETIME     NULL,
    [IdAprobo]               INT          NULL,
    [FechaAprobo]            DATETIME     NULL,
    CONSTRAINT [PK_DetalleObrasRecepciones] PRIMARY KEY CLUSTERED ([IdDetalleObraRecepcion] ASC) WITH (FILLFACTOR = 90)
);

