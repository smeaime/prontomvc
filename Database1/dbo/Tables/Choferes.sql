CREATE TABLE [dbo].[Choferes] (
    [IdChofer]        INT           IDENTITY (1, 1) NOT NULL,
    [Nombre]          VARCHAR (50)  NULL,
    [PathImagen1]     VARCHAR (200) NULL,
    [NumeroDocumento] VARCHAR (20)  NULL,
    [Cuil]            VARCHAR (13)  NULL,
    CONSTRAINT [PK_Choferes] PRIMARY KEY CLUSTERED ([IdChofer] ASC) WITH (FILLFACTOR = 90)
);

