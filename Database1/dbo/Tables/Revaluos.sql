CREATE TABLE [dbo].[Revaluos] (
    [IdRevaluo]    INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]  VARCHAR (50) NULL,
    [FechaRevaluo] DATETIME     NULL,
    CONSTRAINT [PK_Revaluos] PRIMARY KEY CLUSTERED ([IdRevaluo] ASC) WITH (FILLFACTOR = 90)
);

