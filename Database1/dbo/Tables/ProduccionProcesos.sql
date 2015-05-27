CREATE TABLE [dbo].[ProduccionProcesos] (
    [IdProduccionProceso] INT          IDENTITY (1, 1) NOT NULL,
    [IdProduccionSector]  INT          NULL,
    [Codigo]              VARCHAR (20) NULL,
    [Descripcion]         VARCHAR (50) NULL,
    [Obligatorio]         VARCHAR (2)  NULL,
    [Incorpora]           VARCHAR (2)  NULL,
    [Valida]              VARCHAR (2)  NULL,
    [ValidaFinal]         VARCHAR (2)  NULL,
    [IdUbicacion]         INT          NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionProceso] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdProduccionSector]) REFERENCES [dbo].[ProduccionSectores] ([IdProduccionSector])
);

