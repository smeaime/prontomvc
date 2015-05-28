CREATE TABLE [dbo].[Depositos] (
    [IdDeposito]  INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    [Abreviatura] VARCHAR (10) NULL,
    [IdObra]      INT          NULL,
    CONSTRAINT [PK_Depositos] PRIMARY KEY CLUSTERED ([IdDeposito] ASC) WITH (FILLFACTOR = 90)
);

