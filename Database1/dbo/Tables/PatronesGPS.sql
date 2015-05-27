CREATE TABLE [dbo].[PatronesGPS] (
    [IdPatronGPS] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    [Activa]      VARCHAR (2)  NULL,
    CONSTRAINT [PK_PatronesGPS] PRIMARY KEY CLUSTERED ([IdPatronGPS] ASC) WITH (FILLFACTOR = 90)
);

