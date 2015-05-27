CREATE TABLE [dbo].[DetalleDistribucionesObras] (
    [IdDetalleDistribucionObra] INT            IDENTITY (1, 1) NOT NULL,
    [IdDistribucionObra]        INT            NULL,
    [IdObra]                    INT            NULL,
    [Porcentaje]                NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleDistribucionesObras] PRIMARY KEY CLUSTERED ([IdDetalleDistribucionObra] ASC) WITH (FILLFACTOR = 90)
);

