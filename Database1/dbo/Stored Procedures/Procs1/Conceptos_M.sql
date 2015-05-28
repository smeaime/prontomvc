CREATE Procedure [dbo].[Conceptos_M]

@IdConcepto int,
@Descripcion varchar(50),
@IdCuenta int,
@ValorRechazado varchar(2),
@CodigoConcepto int,
@GravadoDefault varchar(2),
@Grupo int,
@CodigoAFIP varchar(20),
@CoeficienteAuxiliar numeric(18,2),
@GeneraComision varchar(2),
@NoTomarEnRanking varchar(2)

AS 

UPDATE Conceptos
SET 
 Descripcion=@Descripcion,
 IdCuenta=@IdCuenta,
 ValorRechazado=@ValorRechazado,
 CodigoConcepto=@CodigoConcepto,
 GravadoDefault=@GravadoDefault,
 Grupo=@Grupo,
 CodigoAFIP=@CodigoAFIP,
 CoeficienteAuxiliar=@CoeficienteAuxiliar,
 GeneraComision=@GeneraComision,
 NoTomarEnRanking=@NoTomarEnRanking
WHERE (IdConcepto=@IdConcepto)

RETURN(@IdConcepto)