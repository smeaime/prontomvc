CREATE Procedure [dbo].[Log_InsertarRegistro]

@Tipo varchar(5),
@IdComprobante int,
@IdDetalleComprobante int,
@FechaRegistro datetime = Null,
@Cantidad numeric(18,2),
@Detalle varchar(100),
@AuxString1 varchar(50) = Null,
@AuxString2 varchar(50) = Null,
@AuxString3 varchar(50) = Null,
@AuxString4 varchar(50) = Null,
@AuxString5 varchar(50) = Null,
@AuxDate1 datetime = Null,
@AuxDate2 datetime = Null,
@AuxDate3 datetime = Null,
@AuxDate4 datetime = Null,
@AuxDate5 datetime = Null,
@AuxNum1 numeric(18,2) = Null,
@AuxNum2 numeric(18,2) = Null,
@AuxNum3 numeric(18,2) = Null,
@AuxNum4 numeric(18,2) = Null,
@AuxNum5 numeric(18,2) = Null

AS 

-- Pone en cero un item de asiento de un cheque de pago diferido
IF @Tipo='AS_E1' or @Tipo='AS_E2'
   BEGIN
	SET @AuxString4='IdDetalleAsiento : '+Convert(varchar,@AuxNum2)
	SET @AuxString5='IdValor : '+Convert(varchar,@AuxNum3)
   END

SET @FechaRegistro=IsNull(@FechaRegistro,GetDate())

INSERT INTO [Log]
(
 Tipo,
 IdComprobante,
 IdDetalleComprobante,
 FechaRegistro,
 Cantidad,
 Detalle,
 AuxString1,
 AuxString2,
 AuxString3,
 AuxString4,
 AuxString5,
 AuxDate1,
 AuxDate2,
 AuxDate3,
 AuxDate4,
 AuxDate5,
 AuxNum1,
 AuxNum2,
 AuxNum3,
 AuxNum4,
 AuxNum5
)
VALUES 
(
 @Tipo,
 @IdComprobante,
 @IdDetalleComprobante,
 @FechaRegistro,
 @Cantidad,
 @Detalle,
 @AuxString1,
 @AuxString2,
 @AuxString3,
 @AuxString4,
 @AuxString5,
 @AuxDate1,
 @AuxDate2,
 @AuxDate3,
 @AuxDate4,
 @AuxDate5,
 @AuxNum1,
 @AuxNum2,
 @AuxNum3,
 @AuxNum4,
 @AuxNum5
)