CREATE TABLE [dbo].[Ubicaciones] (
    [IdUbicacion] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    [Estanteria]  VARCHAR (2)  NULL,
    [Modulo]      VARCHAR (4)  NULL,
    [Gabeta]      VARCHAR (4)  NULL,
    [IdDeposito]  INT          NULL,
    CONSTRAINT [PK_Ubicaciones] PRIMARY KEY CLUSTERED ([IdUbicacion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Ubicaciones_Depositos] FOREIGN KEY ([IdDeposito]) REFERENCES [dbo].[Depositos] ([IdDeposito])
);

