CREATE TABLE [dbo].[DistribucionesObras] (
    [IdDistribucionObra] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]        VARCHAR (50) NULL,
    CONSTRAINT [PK_DistribucionesObras] PRIMARY KEY CLUSTERED ([IdDistribucionObra] ASC) WITH (FILLFACTOR = 90)
);

