CREATE TABLE [dbo].[Planos] (
    [IdPlano]     INT          IDENTITY (1, 1) NOT NULL,
    [NumeroPlano] VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Revision]    VARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail] TINYINT      NULL,
    CONSTRAINT [PK_Planos] PRIMARY KEY CLUSTERED ([IdPlano] ASC) WITH (FILLFACTOR = 90)
);

