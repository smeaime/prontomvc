CREATE TABLE [dbo].[ProntoIniClaves] (
    [IdProntoIniClave] INT            IDENTITY (1, 1) NOT NULL,
    [Clave]            VARCHAR (1000) NULL,
    [Descripcion]      NTEXT          NULL,
    [ValorPorDefecto]  VARCHAR (1000) NULL,
    CONSTRAINT [PK_ProntoIniClaves] PRIMARY KEY CLUSTERED ([IdProntoIniClave] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[ProntoIniClaves]([Clave] ASC) WITH (FILLFACTOR = 90);

