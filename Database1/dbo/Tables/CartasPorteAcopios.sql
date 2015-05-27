CREATE TABLE [dbo].[CartasPorteAcopios] (
    [IdAcopio]    INT          NOT NULL,
    [Descripcion] VARCHAR (60) NOT NULL,
    [IdCliente]   INT          NULL,
    PRIMARY KEY CLUSTERED ([IdAcopio] ASC),
    FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente]),
    CONSTRAINT [U_Unicidad_CartasPorteAcopios] UNIQUE NONCLUSTERED ([Descripcion] ASC)
);

