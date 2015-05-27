CREATE TABLE [dbo].[DetallePatronesGPS] (
    [IdDetallePatronGPS] INT             IDENTITY (1, 1) NOT NULL,
    [IdPatronGPS]        INT             NULL,
    [Latitud]            NUMERIC (18, 8) NULL,
    [Longitud]           NUMERIC (18, 8) NULL,
    [Altura]             NUMERIC (18, 8) NULL,
    [DistanciaKm]        NUMERIC (18, 8) NULL,
    [Temperatura]        NUMERIC (6, 2)  NULL,
    [Velocidad]          VARCHAR (20)    NULL,
    [Curso]              VARCHAR (2)     NULL,
    [FechaLectura]       DATETIME        NULL,
    [NumeroRegistro]     INT             NULL,
    CONSTRAINT [PK_DetallePatronesGPS] PRIMARY KEY CLUSTERED ([IdDetallePatronGPS] ASC) WITH (FILLFACTOR = 90)
);

