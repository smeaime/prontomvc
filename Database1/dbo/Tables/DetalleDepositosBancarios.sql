CREATE TABLE [dbo].[DetalleDepositosBancarios] (
    [IdDetalleDepositoBancario] INT IDENTITY (1, 1) NOT NULL,
    [IdDepositoBancario]        INT NULL,
    [IdValor]                   INT NULL,
    CONSTRAINT [PK_DetalleDepositosBancarios] PRIMARY KEY NONCLUSTERED ([IdDetalleDepositoBancario] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleDepositosBancarios]([IdDepositoBancario] ASC, [IdDetalleDepositoBancario] ASC) WITH (FILLFACTOR = 90);

