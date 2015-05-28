CREATE TABLE [dbo].[ProntoIni] (
    [IdProntoIni]      INT            IDENTITY (1, 1) NOT NULL,
    [IdUsuario]        INT            NULL,
    [IdProntoIniClave] INT            NULL,
    [Valor]            VARCHAR (1000) NULL,
    CONSTRAINT [PK_ProntoIni] PRIMARY KEY CLUSTERED ([IdProntoIni] ASC) WITH (FILLFACTOR = 90)
);

