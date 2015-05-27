CREATE TABLE [dbo].[Cargos] (
    [IdCargo]     INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Cargos] PRIMARY KEY CLUSTERED ([IdCargo] ASC) WITH (FILLFACTOR = 90)
);

