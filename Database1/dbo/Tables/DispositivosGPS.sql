CREATE TABLE [dbo].[DispositivosGPS] (
    [IdDispositivoGPS] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]      VARCHAR (50) NULL,
    [Destino]          VARCHAR (1)  NULL,
    CONSTRAINT [PK_DispositivosGPS] PRIMARY KEY CLUSTERED ([IdDispositivoGPS] ASC) WITH (FILLFACTOR = 90)
);

