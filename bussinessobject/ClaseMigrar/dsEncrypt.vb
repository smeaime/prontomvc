Public Class dsEncrypt
    'Welcome to my stuff for my encrypter.  This is my 2nd example
    'of an encrypter.  Version 2.o
    'Cya
    'SaBrE

    Private LCW As Integer                 'Length of the CodeWord
    Private LS2E As Integer                 'Length of String to be Encrypted
    Private LAM As Integer                 'Length of Array Matrix
    Private MP As Integer                    'Matrix Position
    Private Matrix As String                  'Starting Matrix
    Private mov1 As String                    'First Part of Replacement String
    Private mov2 As String                    'Second Part of Replacement String
    Private CodeWord As String            'the CodeWord
    Private CWL As String                    'the CodeWord Letter
    Private EncryptedString As String     'String to Return for Encrypt or String to UnEncrypt for UnEncrypt
    Private EncryptedLetter As String     'Storage Variable for Character just Encrypted
    Private strCryptMatrix(98) As String 'Matrix Array




    Public Property KeyString() As String
        Get
            Return CodeWord
        End Get

        Set(ByVal value As String)
            CodeWord = value
        End Set
    End Property


    Public Function Encrypt(ByVal mstext As String) As String

        Dim x As Integer                    'Loop Counter
        Dim y As Integer                    'Loop Counter
        Dim Z As Integer                    'Loop Counter
        Dim C2E As String                   'Character to Encrypt
        Dim Str2Encrypt As String           'Text from TextBox

        Str2Encrypt = mstext
        LS2E = Len(mstext)
        LCW = Len(CodeWord)
        EncryptedLetter = ""
        EncryptedString = ""

        y = 1
        For x = 1 To LS2E
            C2E = Mid(Str2Encrypt, x, 1)
            MP = InStr(1, Matrix, C2E, 0)
            CWL = Mid(CodeWord, y, 1)
            For Z = 1 To LAM
                If Mid(strCryptMatrix(Z), MP, 1) = CWL Then
                    EncryptedLetter = Left(strCryptMatrix(Z), 1)
                    EncryptedString = EncryptedString + EncryptedLetter
                    Exit For
                End If
            Next Z
            y = y + 1
            If y > LCW Then y = 1
        Next x

        Encrypt = EncryptedString

        'this changes the letters, *reminder* this is a poly-encrypter

    End Function

    Sub New()

        Dim W As Integer     'Loop Counter to set up Matrix
        Dim x As Integer     'Loop through Matrix

        Matrix = "8x3p5BeabcdfghijklmnoqrstuvwyzACDEFGHIJKLMNOPQRSTUVWXYZ 1246790-.#/\!@$<>&*()[]{}';:,?=+~`^|%_"
        'Matrix = Matrix + Chr(13)  'Add Carriage Return to Matrix
        'Matrix = Matrix + Chr(10)  'Add Line Feed to Matrix
        'Matrix = Matrix + Chr(34)  'Add "


        Matrix = Matrix + Environment.NewLine 'Add Carriage Return to Matrix
        'Matrix = Matrix + Chr(10)  'Add Line Feed to Matrix
        Matrix = Matrix + Chr(34)  'Add "
        ' My String used to make Matrix - 8x3p5Be
        ' My String can be any combination that has a character only ONCE.
        ' EACH Letter in the Matrix is Input ONLY once.
        W = 1
        LAM = Len(Matrix)
        strCryptMatrix(1) = Matrix

        For x = 2 To LAM ' LAM = Length of Array Matrix
            mov1 = Left(strCryptMatrix(W), 1)   'First Character of strCryptMatrix
            mov2 = Right(strCryptMatrix(W), (LAM - 1))   'All but First Character of strCryptMatrix
            strCryptMatrix(x) = mov2 + mov1  'Makes up each row of the Array
            W = W + 1
        Next x

    End Sub

End Class
