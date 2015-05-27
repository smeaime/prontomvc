CREATE TABLE [dbo].[DetalleFletes] (
    [IdDetalleFlete]      INT             IDENTITY (1, 1) NOT NULL,
    [IdFlete]             INT             NULL,
    [Fecha]               DATETIME        NULL,
    [Tara]                NUMERIC (18, 2) NULL,
    [Ancho]               NUMERIC (6, 2)  NULL,
    [Largo]               NUMERIC (6, 2)  NULL,
    [Alto]                NUMERIC (6, 2)  NULL,
    [Capacidad]           NUMERIC (18, 2) NULL,
    [Patente]             VARCHAR (6)     NULL,
    [IdOrigenTransmision] INT             NULL,
    CONSTRAINT [PK_DetalleFletes] PRIMARY KEY CLUSTERED ([IdDetalleFlete] ASC) WITH (FILLFACTOR = 90)
);

