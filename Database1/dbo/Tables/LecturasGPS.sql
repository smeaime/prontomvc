CREATE TABLE [dbo].[LecturasGPS] (
    [IdLecturaGPS]     INT             IDENTITY (1, 1) NOT NULL,
    [Latitud]          NUMERIC (18, 8) NULL,
    [Longitud]         NUMERIC (18, 8) NULL,
    [Altura]           NUMERIC (18, 8) NULL,
    [Temperatura]      NUMERIC (6, 2)  NULL,
    [Velocidad]        VARCHAR (15)    NULL,
    [Curso]            VARCHAR (2)     NULL,
    [FechaLectura]     DATETIME        NULL,
    [NumeroRegistro]   INT             NULL,
    [IdDispositivoGPS] INT             NULL,
    CONSTRAINT [PK_LecturasGPS] PRIMARY KEY CLUSTERED ([IdLecturaGPS] ASC) WITH (FILLFACTOR = 90)
);

