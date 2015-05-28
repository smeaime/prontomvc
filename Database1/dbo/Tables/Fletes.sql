CREATE TABLE [dbo].[Fletes] (
    [IdFlete]              INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]          VARCHAR (50)    NULL,
    [Patente]              VARCHAR (6)     NULL,
    [NumeroInterno]        INT             NULL,
    [IdTransportista]      INT             NULL,
    [IdChofer]             INT             NULL,
    [Capacidad]            NUMERIC (18, 2) NULL,
    [Tara]                 INT             NULL,
    [TouchCarga]           VARCHAR (5)     NULL,
    [TouchDescarga]        VARCHAR (5)     NULL,
    [IdMarca]              INT             NULL,
    [IdModelo]             INT             NULL,
    [Año]                  INT             NULL,
    [Ancho]                NUMERIC (6, 2)  NULL,
    [Largo]                NUMERIC (6, 2)  NULL,
    [Alto]                 NUMERIC (6, 2)  NULL,
    [ModalidadFacturacion] TINYINT         NULL,
    [IdTarifaFlete]        INT             NULL,
    [PathImagen1]          VARCHAR (200)   NULL,
    [IdOrigenTransmision]  INT             NULL,
    CONSTRAINT [PK_Fletes] PRIMARY KEY CLUSTERED ([IdFlete] ASC) WITH (FILLFACTOR = 90)
);

